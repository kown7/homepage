----------
title: Adventures in TikZ-Land
----------

# Introduction

There is a certain desire, e.g., [^1][^2][^3] and more, to embed non-vector
graphics in the source document for a LaTeX document.

I haven't yet tried [^3] but it should do the for most use-cases, but it requires
an external command to do its magic.

My idead was to use TikZ to draw a bitmap with single aquares. It's not the most
efficient, but for spares images it could be good enough.

----

# Working Example

There's not a lot to go through, the solution was proposed basically proposed
here[^4].


## Overall LaTeX File

The minimal working examples (MWE) for a TikZ image follows. The external
file `mwe2h.tex` defines the `\pixels`.

```tex
\documentclass{article}
\usepackage{tikz}
\usepackage{tikzscale}

\input{mwe2h}

\begin{document}

Now whenever we want to create a TikZ diagram we need to use the tikzpicture environment.

\begin{figure}
\centering
\resizebox{7cm}{!}{%
\begin{tikzpicture}
  \foreach \line [count=\y] in \pixels {
    \foreach \pix [count=\x] in \line {
      %\draw[fill=pixel \pix] (\x,-\y) rectangle +(1,1);
	    \filldraw[fill=c\pix, draw=c\pix] (\x,-\y) rectangle +(1,1);
    }
  }
\end{tikzpicture}
}
\end{figure}

\end{document}
```


## Transforming the Picture

The `.png` image is converted to a [PPM](https://netpbm.sourceforge.net/doc/ppm.html)
image using run-of-the-mill `convert` from ImageMagick. The following Python
script then turns that into a LaTeX array.

```python
"""This is a crude hack to convert ppm files to tikz"""
import hashlib
from collections import defaultdict


def parse_ppm_file(file_path):
    with open(file_path, 'rb') as ppm_file:
        header = ppm_file.readline()
        width, height = map(int, ppm_file.readline().split())
        max_val = int(ppm_file.readline())

        data = ppm_file.read()

    pixel_values = []
    colours = defaultdict(int)
    for i in range(0, len(data), 3):
        r = data[i]
        g = data[i + 1]
        b = data[i + 2]
        colours[(r,g,b)] += 1
        pixel_values.append((r, g, b))

    return pixel_values, width, height, colours


def generate_tikz_file(file_path, pixels, width, height, colourmap):
    with open(file_path + ".tex", 'w') as tikz_file:
        tikz_file.write("\\begin{tikzpicture}\n")

        maxkey = max(colourmap, key=colourmap.get)
        maxval = colourmap[maxkey]
        tikz_file.write("% max value: {} {}\n".format(maxkey, maxval))
        for colours, numbers in colourmap.items():
            if numbers:
                htmlcolour = "{:02x}{:02x}{:02x}".format(colours[0], colours[1], colours[2])
                key = htmlcolour
                tikz_file.write("\\definecolor{{c{}}}{{HTML}}{{{}}} % {}\n".format(key, htmlcolour, numbers))
        tikz_file.write("\\def\\pixels{\n")
        for y in range(height):
            xlist = []
            for x in range(width):
                # if pixels[y * width + x] == maxkey:
                #     continue
                r, g, b = pixels[y * width + x]
                htmlcolour = "{:02x}{:02x}{:02x}".format(r, g, b)
                key = htmlcolour
                # tikz_file.write("\\filldraw[fill=c{}, draw=c{}] ({},-{}) rectangle +(1,1);\n".format(key, key, x, y))
                xlist.append(htmlcolour)
            tikz_file.write("{{{}}},\n".format(",".join(xlist)))
        tikz_file.write("}\n")
        tikz_file.write("\\end{tikzpicture}\n")

if __name__ == "__main__":
    import sys

    if len(sys.argv) != 2:
        print("Usage: python parse_ppm.py <filename>")
        sys.exit(1)

    file_path = sys.argv[1]
    pixels, width, height, colourmap = parse_ppm_file(file_path)

    tikz_file_path = ".".join(file_path.split('.')[:-1])  # Remove the file extension
    generate_tikz_file(tikz_file_path, pixels, width, height, colourmap)
```


# Alternatives

## PxPic

https://ctan.org/pkg/pxpic

## Lines

It will reduce the size of the result if just \put was used[^9]. That doesn't
look particularly good though.

# Post-Script

Reading through the references mentioned hereafter, it seems as if EPS files
acould be embedded. Another item on the backlog.


# Summary

This works, but barely and doesn't solve the problem to a adequate degree.

Other solutions are needed.



[^1]: https://tex.stackexchange.com/questions/21541/embedding-images-with-an-encoding-algorithm
[^2]: https://tex.stackexchange.com/questions/208819/embedding-images-in-tex-file-as-base64-strings
[^3]: https://github.com/zerotoc/pdfinlimg
[^4]: https://tex.stackexchange.com/a/157134 in https://tex.stackexchange.com/questions/157080/can-tikz-create-pixel-art-images
[^9]: https://web.archive.org/web/20211022212446/http://alexisfles.ch/en/latex/pixelart.html