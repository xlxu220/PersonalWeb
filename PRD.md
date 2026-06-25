---
title: "PRD — xiaolan.in Personal Science Website"
owner: Xiaolan Xu
status: Draft v1
date: 2026-06-25
tags: [prd, website, career]
---

# PRD — xiaolan.in Personal Science Website

> **One-line goal:** A polished, self-owned professional science home at `xiaolan.in`, authored in Markdown, version-controlled in this folder, and auto-deployed to Hostinger on every push.

---

## 1. Background & Problem

Xiaolan's public-facing identity is currently spread across CV PDFs, Google Scholar, and Web of Science snapshots (see `../Profile.md`, `../mypaper.md`, `../myproposal.md`). There is no single, owned, narrative web presence that:

- Positions her as a mission-level scientist across her communities (hydrology, IEEE-GRSS, missions, emerging AI/cross-domain work).
- Lets her publish thinking (blog/notes), talks/slides, and project narratives — not just a static CV.
- Is authored from her existing Markdown workflow (Obsidian) without re-keying content into a CMS.

**This site solves that:** one Markdown-driven Hugo site, owned end-to-end, that doubles as a living portfolio and a writing surface.

---

## 2. Goals & Non-Goals

### Goals (v1)

| # | Goal | Success signal |
|---|------|----------------|
| G1 | Ship a professional site at `xiaolan.in` | Live, HTTPS, custom domain resolves |
| G2 | Author 100% in Markdown from this folder | No content edited outside `content/` |
| G3 | Auto-deploy on push to `main` | Push → live in < 5 min, no manual FTP |
| G4 | Cover four content types | Core pages, Projects, Talks, Blog all live |
| G5 | Mission-leader register, not a résumé dump | Home + About read as positioning, not lists |

### Non-Goals (v1)

- Public Obsidian note graph / digital garden (deferred to `notes.xiaolan.in`, Quartz, later).
- Baseball coaching portal (`spartans.xiaolan.in`, separate project, later).
- Comments, newsletter, analytics dashboards, search — all post-v1.
- Multi-language, dark-mode toggle, custom theme fork — post-v1 unless trivial.

---

## 3. Framework Decision

**Decision: Hugo + Apéro theme.** Leaning confirmed; brief comparison below so the rationale is on record.

| Option | Strengths | Weaknesses | Verdict |
|--------|-----------|------------|---------|
| **Hugo + Apéro** | Built for personal/academic sites; native `project`, `talk`, `blog` archetypes; fast builds; single-binary; large community | Go templating learning curve if deep customization needed | **Chosen** |
| Quartz | Best Obsidian→web fidelity (wikilinks, backlinks); zero content reshaping | Garden aesthetic, not a polished professional homepage; weaker for projects/talks/CV | Reserve for `notes.xiaolan.in` later |
| Astro | Most flexible/modern; great performance | More front-end engineering; no opinionated academic content model out of the box | Overkill for v1 |

**Why Apéro over Hugo Academic/Wowchemy:** Apéro is lighter, less template-locked, and ages better; Wowchemy's maintenance has been uncertain. Apéro's blog/project/talk separation maps cleanly to G4.

---

## 4. Information Architecture

```
xiaolan.in
├── Home              ← positioning statement + 4 cards
├── About             ← bio (mission-leader register), photo, communities
├── Research          ← narrative overview of research program + themes
├── Projects          ← stable scientific themes (cards → detail pages)
├── Publications      ← portfolio summary + links (from mypaper.md)
├── Talks / Slides    ← seminars + embedded/linked slide PDFs
├── Blog / Notes      ← thinking pieces
├── CV                ← rendered page + downloadable PDF
└── Contact           ← email, scholar, ORCID, GitHub, LinkedIn
```

### Navigation

Primary nav: `About · Research · Projects · Publications · Talks · Blog · CV`. Contact lives in footer + About. Home is the logo/name link.

---

## 5. Repository Structure

This folder (`Profile/Website/`) **is** the git repo root. Initialize git here, push to GitHub.

```
Website/                         ← git repo root
├── content/
│   ├── _index.md                ← homepage front matter + intro
│   ├── about/index.md
│   ├── research/index.md
│   ├── project/
│   │   ├── _index.md
│   │   ├── smap-nisar-soil-moisture/index.md
│   │   ├── gnss-r-land/index.md
│   │   ├── snow-insar-swe/index.md
│   │   ├── freeze-thaw-vod/index.md
│   │   └── microwave-scattering-models/index.md
│   ├── talk/
│   │   ├── _index.md
│   │   └── igarss-2025/{index.md, slides.pdf}
│   ├── blog/
│   │   ├── _index.md
│   │   └── why-sar-adds-information/index.md
│   ├── publication/index.md
│   ├── cv/index.md
│   └── contact/index.md
├── static/
│   ├── files/cv.pdf
│   └── images/{profile.jpg, research/...}
├── layouts/                     ← only if overriding theme partials
├── themes/hugo-apero/           ← git submodule (or Hugo module)
├── config/_default/
│   ├── hugo.yaml
│   ├── params.yaml
│   └── menus.yaml
├── .github/workflows/deploy.yml
├── .gitignore                   ← ignore /public, /resources/_gen
├── PRD.md                       ← this file
└── README.md
```

**Content provenance — reuse, don't re-key:**

| Site section | Source in this workspace |
|--------------|--------------------------|
| Publications | `../mypaper.md` (37 published; trackers in `04_Outputs/01_Papers/`) |
| Projects / Research | `../myproposal.md` grants + `../Profile.md` mission map + `01_Science/` |
| About / bio | `00_Who_is_who/People/Xiaolan Xu.md` + Profile identity notes |
| CV | `../CV_Xiaolan_[year].docx` → export `cv.pdf` to `static/files/` |

---

## 6. Authoring & Deployment Pipeline

```
Obsidian / Markdown (this folder)
        ↓ edit content/
   git commit + push → GitHub (main)
        ↓ triggers
   GitHub Actions: hugo --minify
        ↓ FTP/SSH upload of /public
   Hostinger public_html
        ↓
   xiaolan.in (HTTPS)
```

**Decision: GitHub Actions → Hostinger** (keeps existing Hostinger hosting).

> **Confirmed from hPanel (2026-06-25):** Hosting is the **Business** plan (paid through 2029-02-02), which **includes SSH + Git**. Prefer **`rsync` over SSH** for fast incremental deploys; the FTP path below is the fallback. FTP/SSH host IP on file: `145.223.77.126`.

### Deploy workflow (`.github/workflows/deploy.yml`) — reference

```yaml
name: Deploy to Hostinger
on:
  push:
    branches: [main]
jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with: { submodules: recursive, fetch-depth: 0 }
      - uses: peaceiris/actions-hugo@v3
        with: { hugo-version: 'latest', extended: true }
      - run: hugo --minify --baseURL "https://xiaolan.in/"
      - name: Deploy via FTP
        uses: SamKirkland/FTP-Deploy-Action@v4.3.5
        with:
          server: ${{ secrets.FTP_SERVER }}
          username: ${{ secrets.FTP_USERNAME }}
          password: ${{ secrets.FTP_PASSWORD }}
          local-dir: ./public/
          server-dir: ./public_html/
```

> If Hostinger plan supports SSH, prefer `rsync` over `lftp` for faster incremental deploys. FTP action above is the lowest-common-denominator path.

### Secrets to set in GitHub repo settings

`FTP_SERVER`, `FTP_USERNAME`, `FTP_PASSWORD` (from Hostinger hPanel → Files → FTP Accounts). **Never commit these.**

### Domain & TLS

> **Confirmed from hPanel (2026-06-25):** `xiaolan.in` is registered at Hostinger, Active, expires **2027-02-02**, auto-renew on. Nameservers are Hostinger's (`ns1/ns2.dns-parking.com`) — DNS is managed in hPanel and **already points at Hostinger hosting**. Existing records: root `@` ALIAS → `xiaolan.in.cdn.hstgr.net`, `www` CNAME → `www.xiaolan.in.cdn.hstgr.net`, `spartans` ALIAS → `spartans.xiaolan.in.cdn.hstgr.net`, `ftp` A → `145.223.77.126`.

- DNS already resolves to Hostinger — **no nameserver change needed**. Hugo output just needs to land in the correct document root (see §6.1 migration).
- Enable Hostinger's free SSL (Let's Encrypt) for HTTPS; force HTTPS redirect.
- Set Hugo `baseURL: https://xiaolan.in/`.

### 6.1 Migration — existing WordPress site (NEW, must resolve before M2)

> **Confirmed from hPanel (2026-06-25):** `xiaolan.in` currently runs a **live WordPress install** under the Business plan. `spartans.xiaolan.in` already exists as a **separate website** (coaching portal) — leave it untouched.

**DECISION (2026-06-25): Option A — retire WordPress entirely, replace in place.** Rationale: GitHub + Hugo build is simpler for Xiaolan to maintain long-term than a WordPress backend. The old WP content has been **captured to `wordpress-content-archive.md`** (Home + About pages, verbatim) so nothing is lost.

**Migration steps:**
1. ✅ **Content captured** → `wordpress-content-archive.md` (done 2026-06-25). Old site had two pages: Home and About.
2. **Full WordPress backup** before deleting — in hPanel, export Files + Database (safety net; keep offline, not in repo).
3. **Build Hugo locally** to parity using the captured content + canonical sources (`../mypaper.md`, `../myproposal.md`).
4. **Empty `public_html/`** of the WordPress install and deploy Hugo `public/` there via SSH/rsync.
5. **Remove the WordPress site** in hPanel once Hugo is confirmed live and correct.

`spartans.xiaolan.in` is a **distinct site** and is out of scope — do not touch it during this migration.

> **Captured content inventory (for §5 content provenance):** old Home page → feeds Home + Research + Awards; old About page → feeds About (Education, Professional Activities, Contact). See `wordpress-content-archive.md`. Note: WP intro text mixes 1st/3rd person and has minor typos — fix during rebuild.

---

## 7. Homepage Spec

**Hero:**

```
Xiaolan Xu
Research Scientist · NASA/JPL

Microwave remote sensing of the land surface — soil moisture, snow,
and freeze–thaw. Active/passive retrievals, SAR time series, and the
algorithms behind SMAP, NISAR, and CYGNSS.
```

**Four cards** linking to: `Research`, `Projects`, `Talks & Slides`, `Blog / Notes`.

**Below the fold:** 1–2 line positioning paragraph + selected highlights (e.g., SMAP freeze/thaw product author, CYGNSS soil-moisture PI, IEEE TGRS associate editor). Keep mission-leader register per folder identity note.

---

## 8. Content Model (front matter conventions)

**Project** (`content/project/<slug>/index.md`):
```yaml
---
title: "SMAP + NISAR Soil Moisture"
summary: "L-band active/passive retrieval algorithm lineage."
date: 2026-01-01
tags: [soil-moisture, SMAP, NISAR, SAR]
weight: 10
---
```

**Talk** (`content/talk/<slug>/index.md`):
```yaml
---
title: "Invited Seminar — ..."
event: "IGARSS 2025"
date: 2025-07-01
slides: slides.pdf
---
```

**Blog** (`content/blog/<slug>/index.md`):
```yaml
---
title: "Why SAR Can Add Information to Soil Moisture"
date: 2026-06-01
tags: [SAR, soil-moisture, retrieval]
draft: false
---
```

Date format `YYYY-MM-DD` per workspace conventions. Use real, documented facts only — anchor project/research claims to papers and proposals (fact-first principle).

---

## 9. v1 Scope & Milestones

**In scope (must ship):** Core pages (Home, About, Research, Publications, CV, Contact) + Projects + Talks & Slides + Blog/Notes.

| Milestone | Deliverable | Done when |
|-----------|-------------|-----------|
| M0 — Scaffold | Hugo+Apéro running locally; repo + git init in this folder | `hugo server` renders theme locally |
| M1 — Pipeline | GitHub repo + Actions deploy to Hostinger staging path | Test push lands on a live URL |
| M2 — Core pages | Home, About, Research, Publications, CV, Contact populated | All 6 render with real content |
| M3 — Portfolio | Projects (5 themes) + Talks (≥1 with slides) | Cards + detail pages live |
| M4 — Voice | Blog section + 1–2 seed posts | First post published |
| M5 — Launch | DNS + HTTPS on `xiaolan.in`; proofread; mobile check | Public, indexed, no broken links |

**Suggested order:** M0 → M1 (prove deploy early before content piles up) → M2 → M3 → M4 → M5.

---

## 10. Open Decisions / Risks

**Resolved (hPanel check, 2026-06-25):**
- ~~Hostinger access method~~ → **SSH available** (Business plan). Use `rsync`/SSH deploy.
- ~~DNS state~~ → **Already on Hostinger NS and pointing at Hostinger hosting.** No nameserver change needed.
- ~~`spartans.xiaolan.in`~~ → **Already exists** as its own site; leave as-is.

**Still open:**
- **WordPress migration (NEW, highest priority):** `xiaolan.in` currently serves a live WordPress site. Choose §6.1 option A (replace in place) vs B (staging subdomain), and **back up WP first**.
- **Theme acquisition:** Apéro as git **submodule** vs. Hugo **module** (`go.mod`). Module is cleaner for updates; submodule is simpler. Recommend Hugo module.
- **CV sync:** CV PDF must be regenerated from the master `.docx` on each CV update (ties into the Profile folder "update all" trigger).
- **`notes.xiaolan.in` (future):** Quartz public notes deferred; DNS room available.

---

## 11. Definition of Done (v1)

A visitor at `https://xiaolan.in` sees a fast, mobile-friendly, professionally written site with working nav across Home, About, Research, Projects, Publications, Talks, Blog, CV, and Contact; every page is sourced from Markdown in this folder; and a `git push` to `main` redeploys the live site automatically with no manual steps.
