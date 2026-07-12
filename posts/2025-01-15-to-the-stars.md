----------
title: Astro on Cloudflare Pages with Functions
----------

Migrating our family cottage away from a Wordpress site to something
homegrown. 

Aims:

* Booking system with custom rules
* Track everything in git
* [Astro](https://astro.build/) as a framework

See the working demo over at Cloudflare: <https://astro-booking.pages.dev/>.
The source is at [GitHub](https://github.com/kown7/accessible-astro-starter).

# Astro

It's a static site generator (SSR) hosted at <https://astro.build/>.

SSRs have the benefit that all content is stored in your git repository and can
be moved with ease and hosted on anything, even your
[vape](https://bogdanthegeek.github.io/blog/projects/vapeserver/) if need be.

Unfortunately it doesn't (natively) support dynamic content like message boards
or e.g., a booking system.

# Cloudflare Pages

Free hosting for your static site. Use *Basic Auth* protected by 
*Functions* as described here: 
<https://github.com/garrison/cloudflare-pages-shared-password>.

Functions to serverlessy process the bookings.

## Installation

Cloudflare Pages supports deploying static site generators straight
from github using npm.

Add a new page in `Compute (Workers)`/`Workers & Pages` and import an existing
git repository. Follow Cloudflares own documentation for more information.

Enable the build cache for your page.

Enable the necessary actions `addreservation.yml` in your github repository.

Update the location of your github repository in `functions/postbooking/index.ts`.

Create a personal access token according to
<https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens>
here: <https://github.com/settings/personal-access-tokens>.
Save it as `GITHUB_TOKEN` in your Cloudflare settings to be able to run the
workflow.

Save it as a actions secret `PUSH_TOKEN` in github to be able to push to your github repository.


# Wordpress

Keep a local copy though:
<https://medium.com/@richardevcom/wordpress-development-environment-with-docker-ba52427bdd65>

