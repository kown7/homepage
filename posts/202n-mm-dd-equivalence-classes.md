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
