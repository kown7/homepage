Der Unterschied ist **fein, aber wichtig**:

- **eingabeorientiert** = man bildet Äquivalenzklassen danach, **wie die Eingaben laut Spezifikation verarbeitet/unterschieden werden**
- **ausgabeorientiert** = man bildet Äquivalenzklassen danach, **welches beobachtbare funktionale Ergebnis herauskommt**

Das wirkt zunächst gleich, ist es aber nicht immer.

---

## 1. Eingabeorientiert: „gleich behandelt“

Hier schaut man auf die **Logik der Spezifikation in Bezug auf Eingaben**:

- Welche Wertebereiche werden unterschieden?
- Gibt es Grenzwerte?
- Gibt es verschiedene Verarbeitungsregeln für verschiedene Eingaben?

Eine Äquivalenzklasse ist dann eine Menge von Eingabewerten, für die man annimmt:
**Das System wendet dieselbe Regel / denselben Verarbeitungspfad an.**

### Beispiel
Spezifikation:
- Temperatur < 0  → Fehler
- 0 bis 100 → normal verarbeiten
- > 100 → Alarm

Dann wären eingabeorientierte Klassen z. B.:

1. \( T < 0 \)
2. \( 0 \le T \le 100 \)
3. \( T > 100 \)

Warum?  
Weil diese Bereiche in der Spezifikation **unterschiedlich behandelt** werden.

---

## 2. Ausgabeorientiert: „gleiches funktionales Ergebnis“

Hier schaut man nicht primär auf die interne Unterscheidung der Eingaben, sondern auf das **Resultat**:

- Welche Eingaben führen zum gleichen beobachtbaren Verhalten?
- Welche Eingaben liefern dieselbe Ausgabe / denselben Systemzustand / dieselbe Funktion?

Eine Äquivalenzklasse ist dann eine Menge von Eingaben, für die gilt:
**Aus Sicht der Funktion ist das Ergebnis gleich.**

### Beispiel
Spezifikation:
- Eingabewerte 1, 2, 3, 4, 5 sind zulässig
- Das System gibt bei allen diesen Werten einfach „freigegeben“ aus

Dann könnte man ausgabeorientiert sagen:
- Klasse A: alle zulässigen Werte → Ergebnis „freigegeben“
- Klasse B: alle unzulässigen Werte → Ergebnis „abgewiesen“

Ob die zulässigen Werte intern unterschiedlich geprüft werden, ist bei dieser Sicht zunächst zweitrangig.

---

## 3. Warum ist das nicht dasselbe?

Weil **gleich behandelt** und **gleiches Ergebnis** nicht immer zusammenfallen.

### Fall A: Gleich behandelt, aber nicht gleiches Ergebnis
Ein gemeinsamer Algorithmus verarbeitet alle Werte auf dieselbe Weise, aber die Ergebnisse sind unterschiedlich.

Beispiel:
- Eingabe ist eine Zahl \(x\)
- System berechnet \(y = x^2\)

Alle Eingaben werden **gleich behandelt**: dieselbe Formel.  
Aber 2, 3 und 4 haben **nicht das gleiche funktionale Ergebnis**.

→ Eingabeorientiert könnte das eine große Klasse sein  
→ Ausgabeorientiert eher nicht

---

### Fall B: Unterschiedlich behandelt, aber gleiches Ergebnis
Die Spezifikation unterscheidet verschiedene Eingabebereiche, aber am Ende kommt dasselbe heraus.

Beispiel:
- Wenn Code zwischen 100 und 199: prüfe Regel A
- Wenn Code zwischen 200 und 299: prüfe Regel B
- In beiden Fällen ist das Ergebnis: „Zugang erlaubt“

Dann werden die Eingaben **nicht gleich behandelt**, weil unterschiedliche Regeln gelten.  
Aber das **funktionale Ergebnis** ist gleich.

→ Eingabeorientiert: zwei Klassen  
→ Ausgabeorientiert: eventuell eine Klasse

---

## 4. Der Kernunterschied in einem Satz

- **eingabeorientiert**: „Sind diese Eingaben aus Sicht der Spezifikation derselben Verarbeitungslogik zugeordnet?“
- **ausgabeorientiert**: „Sind diese Eingaben aus Sicht des beobachtbaren Ergebnisses funktional gleichwertig?“

---

## 5. Warum nennt die Norm beide Sichtweisen?

Weil bei der Testfallableitung beide Ansätze nützlich sind:

### Eingabeorientiert ist gut, wenn man prüfen will:
- wurden alle spezifizierten Eingabebereiche abgedeckt?
- wurden alle Entscheidungsregeln / Grenzwerte betrachtet?
- hat man alle unterschiedlichen Behandlungsarten getestet?

### Ausgabeorientiert ist gut, wenn man prüfen will:
- wurden alle funktionalen Reaktionen abgedeckt?
- gibt es für jede relevante Systemantwort mindestens einen Test?
- sind gleiche Ergebnisse aus unterschiedlichen Eingaben ausreichend repräsentiert?

---

## 6. Praktisches Mini-Beispiel aus dem Bahn-/Safety-Kontext

Angenommen, Spezifikation:

- Geschwindigkeit < 0 km/h → Eingabe ungültig, Fehler
- 0 bis 40 km/h → Modus „Rangieren“
- 41 bis 160 km/h → Modus „Normalbetrieb“
- >160 km/h → Zwangsbremsung

### Eingabeorientierte Klassen
- <0
- 0..40
- 41..160
- >160

Diese Klassen ergeben sich aus den **Regeln der Spezifikation**.

### Ausgabeorientierte Klassen
Wenn man nur auf das funktionale Resultat schaut:
- Fehler
- Rangieren
- Normalbetrieb
- Zwangsbremsung

Hier fallen die Klassen zufällig fast zusammen.

Aber wenn die Spezifikation noch ergänzt:
- 41..120 → Normalbetrieb mit Überwachung A
- 121..160 → Normalbetrieb mit Überwachung B

Dann wäre:

**eingabeorientiert**
- 41..120
- 121..160

**ausgabeorientiert**
- beide vielleicht zusammen, wenn nach außen in beiden Fällen nur „Normalbetrieb“ sichtbar ist

---

## 7. Warum es „gleich“ aussieht

Dein Eindruck ist verständlich, weil in vielen einfachen Spezifikationen:

- ein Eingabebereich
- genau eine Verarbeitungsregel
- genau ein Ergebnis

zusammenfallen.

Dann sind eingabeorientierte und ausgabeorientierte Äquivalenzklassen praktisch identisch.

Der Unterschied wird erst sichtbar, wenn:

- mehrere Eingabebereiche trotz verschiedener Regeln zum selben Ergebnis führen, oder
- dieselbe Regel auf viele Eingaben angewendet wird, aber unterschiedliche Ergebnisse erzeugt.

---

## 8. Faustregel

Wenn du dich fragst, wie du lesen sollst:

- **„gleich behandelt“** = gleiche **Spezifikationsregel / gleicher Verarbeitungstyp**
- **„gleiches funktionales Ergebnis“** = gleiche **beobachtbare Wirkung / gleiche Ausgabe / gleicher Zustand**

---

Wenn du möchtest, kann ich dir das auch noch **an einem konkreten EN 50128/Software-Test-Beispiel** mit einer kleinen Tabelle „eingabeorientierte vs. ausgabeorientierte Äquivalenzklassen“ darstellen.








Ja. **Explizit** die Begriffe *„eingabeorientiert“* vs. *„ausgabeorientiert“* in genau dieser Wortwahl findest du in ISTQB/Standardwerken eher **selten**; dort wird die Sache meist als **Äquivalenzpartitionierung nach Eingabebedingungen/Eingabedomäne** bzw. als Gruppierung nach **erwartetem Ergebnis/Verhalten** beschrieben. Genau diese Stellen stützen die in EN 50128/EN 50716 angelegte Unterscheidung.

## Konkrete, gut zitierbare Stellen

### 1) ISTQB Glossary / Syllabus
**ISTQB Glossary of Testing Terms**  
Eintrag **equivalence partitioning** (deutsche Fassung oft „Äquivalenzklassenbildung“ / „Äquivalenzpartitionierung“):

Typischer Inhalt:
- Unterteilung von Datenobjekten in Partitionen, von denen angenommen wird, dass sie **in gleicher Weise verarbeitet** werden.
- Tests können so entworfen werden, dass sie Partitionen **abdecken**.

Das stützt direkt die **eingabeorientierte** Sicht:  
„gleich behandelt“ = Werte einer Partition werden erwartungsgemäß gleichartig verarbeitet.

Zusätzlich stützen ISTQB-Syllabus-Texte Black-Box-Verfahren generell dadurch, dass Testfälle aus
- **Spezifikation**,
- **Bedingungen**,
- **Eingaben**,
- **Ausgaben**
abgeleitet werden.

**Nützlich zum Nachschlagen:**
- ISTQB® Certified Tester Foundation Level, aktueller Syllabus
- ISTQB Glossary, Eintrag *equivalence partitioning*

> Was daran für deine Frage wichtig ist:  
> ISTQB betont bei Äquivalenzpartitionierung vor allem das **gleiche Verarbeitungsverhalten** einer Eingabeklasse. Das ist die stärkste Stütze für „eingabeorientiert“.

---

### 2) ISO/IEC/IEEE 29119-4
**ISO/IEC/IEEE 29119-4 – Software Testing – Part 4: Test Techniques**

Dort ist **equivalence partitioning** als Spezifikations-/Black-Box-Technik beschrieben. Typischer Kern:
- Aufteilung der Eingabewerte, Ausgabewerte, Zustände oder Bedingungen in Partitionen,
- so, dass sie voraussichtlich **gleichartig vom Testobjekt behandelt werden** oder **gleichartiges Verhalten** hervorrufen.

Das ist sehr nah an deiner Normstelle, weil hier beide Richtungen schon angelegt sind:
- über **Eingaben/Bedingungen** → eingabeorientiert
- über **Ausgaben/Verhalten** → ausgabeorientiert

Diese Quelle ist besonders stark, weil sie normativ-methodisch ist und nicht nur ein Lehrbuch.

---

### 3) Myers, Sandler, Badgett – *The Art of Software Testing*
In den Kapiteln zu **Black-Box Testing** und **Equivalence Partitioning** wird beschrieben, dass:
- Eingabedomänen in Klassen zerlegt werden,
- weil erwartet wird, dass alle Elemente einer Klasse **äquivalent** sind,
- d. h. das Programm sie **ähnlich behandelt**.

Zusätzlich wird bei Black-Box-Tests generell von der Ableitung aus der Spezifikation und den erwarteten Ergebnissen gesprochen.

Stützt:
- primär **eingabeorientiert**
- indirekt auch **ausgabeorientiert**, weil Black-Box-Testfälle auf **erwartete Outputs** abzielen

---

### 4) Boris Beizer – *Software Testing Techniques*
Beizer behandelt Äquivalenzklassen/Partitionierung in der Black-Box-Testmethodik und argumentiert sinngemäß:
- Der Eingaberaum wird in Unterbereiche zerlegt,
- in denen das System als **äquivalent** angesehen werden kann,
- sodass ein Repräsentant der Klasse genügt.

Das ist eine klassische Referenz für:
- Partitionierung nach **Input Domain**
- gleiche oder gleichartige **Behandlung** innerhalb einer Klasse

Beizer hilft vor allem, wenn du den testtheoretischen Hintergrund sauber darstellen willst.

---

### 5) Ammann & Offutt – *Introduction to Software Testing*
In den Abschnitten zu **Input Domain Modeling**, **Characteristics**, **Partitions** wird beschrieben:
- Testanforderungen werden aus einer Eingabedomäne bzw. aus Eigenschaften der Spezifikation modelliert.
- Partitionen können nach Bedingungen, Kategorien, Eigenschaften oder erwarteten Wirkungen gebildet werden.

Das ist sehr nützlich für deine Fragestellung, weil Ammann/Offutt methodisch zeigen, dass Partitionen nicht nur aus „reinen Eingabebereichen“, sondern aus der **Spezifikation** abgeleitet werden können.

Das stützt:
- **eingabeorientiert**: Partitionen nach Eingabecharakteristika
- **ausgabeorientiert**: Partitionen nach funktionalen Konsequenzen / Verhalten

---

## Was genau stützt welche Seite?

### Für „eingabeorientiert“
Am stärksten geeignet sind Stellen, in denen steht:
- values are expected to be **treated the same**
- partitioning of **input data**
- **input domains** or **conditions**

Das findest du besonders klar in:
- ISTQB Glossary
- Myers
- Beizer
- ISO/IEC/IEEE 29119-4

### Für „ausgabeorientiert“
Hier ist die Quellenlage etwas indirekter, aber vorhanden:
- Black-Box-Tests werden aus **Spezifikation und erwarteten Ergebnissen** abgeleitet
- Partitionierung kann sich auf **expected results**, **behavior**, **output classes**, **states** beziehen

Das findest du am ehesten in:
- ISO/IEC/IEEE 29119-4
- Ammann & Offutt
- allgemeine Black-Box-/Specification-based testing-Kapitel in Myers/ISTQB

---

## Wichtige Einschränkung
Wenn du eine Stelle suchst, wo wörtlich steht:

> „Es gibt eine eingabeorientierte und eine ausgabeorientierte Interpretation der Äquivalenzklassen“

dann wirst du das in ISTQB-Lehrmaterial **wahrscheinlich nicht in genau dieser Formulierung** finden.

Was du aber sehr wohl findest, sind die Bausteine:
- Äquivalenzklassen nach **gleichartiger Verarbeitung** von Eingaben
- Testableitung aus **erwarteten Ergebnissen / funktionalem Verhalten**

Die EN-Formulierung kombiniert genau diese beiden Blickwinkel.

---

## Zitierfähige, vorsichtige Formulierung
Du könntest z. B. schreiben:

> Die in EN 50128/EN 50716 genannte Unterscheidung zwischen eingabeorientierter und ausgabeorientierter Ableitung von Äquivalenzklassen entspricht der allgemeinen Testtheorie zur Äquivalenzpartitionierung.  
> In Standardquellen (z. B. ISTQB Glossary, ISO/IEC/IEEE 29119-4, Myers, Beizer, Ammann/Offutt) werden Äquivalenzklassen entweder als Mengen von Eingaben beschrieben, die voraussichtlich gleichartig verarbeitet werden, oder allgemeiner als Partitionen von Eingaben/Bedingungen/Zuständen mit gleichartigem erwarteten Verhalten bzw. funktionalem Ergebnis.

Damit bist du fachlich sauber und behauptest nicht, dass ISTQB exakt dieselben Worte benutzt.

---

## Praktisch brauchbare Quellenliste
Ich würde für ein Methodenpapier diese 4 nennen:

1. **ISTQB Glossary** – Eintrag *equivalence partitioning*  
2. **ISO/IEC/IEEE 29119-4** – Abschnitt zu *equivalence partitioning*  
3. **Ammann, Offutt** – Kapitel zu *Input Domain Modeling*  
4. **Myers et al.** – Kapitel zu *Black-Box Testing / Equivalence Partitioning*

---

## Wenn du möchtest
kann ich dir im nächsten Schritt eine **konkrete Literaturliste mit bibliographischen Angaben** aufschreiben, z. B. im Format:

- vollständiger Titel  
- Ausgabe/Jahr  
- relevantes Kapitel/Abschnitt  
- welche Aussage daraus für „eingabeorientiert“ bzw. „ausgabeorientiert“ nutzbar ist

und zwar so, dass du es direkt in ein Reviewdokument übernehmen kannst.