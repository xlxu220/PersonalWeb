# Design Brief — xiaolan.in

*Working spec for the redesign. Source of truth for design + IA decisions. Build against this, not memory.*
*Started 2026-06-25. Status: living — `TBD` items still open.*

> Companion docs: `WORKFLOW.md` (how the site is built/deployed) · `PRD.md` (original scope) · me.md in `🌟 Vision/` (private identity source — **never quoted verbatim on the public site**).

---

## 1. What this site is

A scientist's **identity page** — the public-facing record of who Xiaolan Xu is. Two jobs:

1. **Capability archive** — papers, proposals (talks later) that *back up* the claims with public evidence.
2. **Personal voice** — a blog of short, honest takes, plus a frictionless way to ask a question / email.

It is personal and human, not an institutional page. Xiaolan speaks **as herself** — an algorithm developer — **not** for JPL, NASA, or any mission.

---

## 2. Positioning

**Hero line (locked):**

> **Physics-first. Verified. Fast.**
> *I close the loop from electromagnetic theory to mission-ready science.*

Register: **bold, declarative.** Ties to the Closed-Loop Science north star.

**The expertise edge:** the microwave remote-sensing *signal itself* — the bridge from EM physics → the hard retrieval/inversion → mission-ready soil-moisture, snow, and freeze-thaw products that missions and hydrologists depend on. The **retrieval step is the spine** of every research page.

**Tone duality:** rigorous, precisely-scoped *work* + a warm, approachable *person*. Typography carries the rigor; the illustrated avatar and blog voice carry the warmth.

---

## 3. Humility guardrail (non-negotiable)

Claims are scoped to **her part only**. She is the **algorithm developer**, not the mission lead. Overclaiming reads as *less* credible to the expert audiences — precise scope is the credibility move ("humble but strong").

- **Verbs stay precise:** *"I developed the retrieval algorithm for…"* — never *"I lead / I run the mission."*
- **Per-mission framing:** each mission section is headed **"My contribution"**, scoped to her algorithm/retrieval work, with an **outbound link to the official mission site** for everything outside her lane.
- **Site-wide disclaimer** (small, footer/About): *"Algorithm developer at JPL. Views and content here are my own and not official statements of NASA, JPL, or any mission."*
- For everything outside her domain: **a link, not a claim.**

---

## 4. Audiences → doors

| Audience | Wants | Door |
|---|---|---|
| EM modelers (peers) | the signal, forward/physics models | *Signal/physics* layer of a research area |
| Hydrologists / hydro modelers (end users) | the product + how to use it | *Product* layer — esp. Soil Moisture |
| HQ / mission planners | what a mission measures; how hard the inversion is | *Missions* index |
| Search committees / collaborators / "who is she" | the person, the through-line, judgment | Homepage + About + Blog |

---

## 5. Information architecture

**Primary spine = research themes** (timeless). **Second door = missions** (come & go). Every page cross-links the other axis.

**Top nav:** Research · Missions · Writing (blog) · About + Contact · [Publications · Proposals in archive]

**Research themes (primary):** Soil Moisture · Snow · Freeze–Thaw

**Each research page — layered top → bottom (audience self-selects depth):**
1. What & why — one line
2. The signal / physics — *EM modelers stop here*
3. **The retrieval — the hard inversion — ★ HER EDGE**
4. Product & how to use it — *hydrologists stop here*
5. Which missions it powers → *cross-link to Missions*

**Missions (second door):** SMAP (core) · NISAR (SMAP→NISAR framework) · CYGNSS (GNSS-R) · Aquarius / AMSR-E (early). Each: what it measures, the signal challenge, **"My contribution"**, link to official site, link back into the science.

**The work as a matrix:**

| | SMAP | NISAR | CYGNSS | AMSR-E / Aquarius |
|---|---|---|---|---|
| **Soil Moisture** | ✦ core — product + framework | bringing SMAP framework → NISAR | GNSS-R retrieval | — |
| **Snow** | — | snow mission *development* | — | early work (no dedicated snow mission) |
| **Freeze–Thaw** | FT product | — | — | early-career FT |

---

## 6. Capability archive

- **Publications** — public, unambiguous. List in full; link out (DOI / Scholar).
- **Proposals** — list **title + her role + year + funder**. ⚠️ Funded-proposal *full text* is often **not** public (NASA ROSES, internal JPL). Attach a PDF **only** where clearance is certain; otherwise metadata only.
- **Talks** — deferred. Leave a placeholder section to add later.

---

## 7. Visual direction

- **Typography (locked):** clean precision sans, **no decorative serifs**. Target feel = Helvetica Now. Free build choice: **Inter** or system (`-apple-system` / Helvetica Neue). Retire Fraunces + the soft academic-serif look.
- **Headshot (locked):** keep the warm **illustrated/animated-style avatar** (`static/img/profile.jpg`) — but **small & secondary**, never competing with the hero line. It is the deliberate "approachable, warm, playful" signal.
- **Layout (locked):** the homepage must be **informative above the fold, no scrolling** — who she is, the edge, and the doors all visible immediately. Current site fails this.
- **Palette (locked 2026-06-26):** **Earth Elements** — nature-forward science palette. Near-white ground (`#FBFBFA`) + Earth Blue Darkest text (`#05161E`) + **Ivy Green primary accent** (`#0D8758`) + Mylar Gold highlights (`#FCEB9D`) + Earth Blue hover states (`#0F7EB1`). File: `assets/earth-hex.scss`.

---

## 8. Personal blog

- Frictionless **contact / email** path (ask a question, reach out).
- **Voice — `TBD`.** Options: short technical takes · field opinion/commentary · both. *Decision pending.*

---

## 9. Current-site pain points (what triggered the redesign)

1. Headshot too big.
2. Font feels ugly (Fraunces).
3. Can't tell who she is without scrolling — landing not informative above the fold.
4. Hard to navigate / have to hunt for things — weak information scent.
5. A couple of social icons render as empty squares (placeholder Scholar/ORCID links).

---

## 10. Open decisions (blockers before build)

- [x] **Palette** — ✅ Earth Elements locked 2026-06-26 (Ivy Green primary, near-white ground)
- [ ] **Blog voice** — technical / opinion / both.
- [ ] Which proposals (if any) are cleared for full-PDF posting vs. metadata-only.

---

## Constraints carried from WORKFLOW.md

- Hugo + **Apéro theme, vendored** — keep it stable; customize via `assets/*.scss` (custom palette in `assets/calm-hex.scss`, `custom_theme` in `params.toml`) and content, not by editing the vendored theme.
- Deploy is automatic on `git push` (GitHub Actions → Hostinger). No server work needed.
