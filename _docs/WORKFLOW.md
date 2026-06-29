# How xiaolan.in works — workflow reference

Your personal site. Written in Markdown, built by Hugo, deployed to Hostinger automatically on every push to GitHub. Once set up (done), you never touch servers again — you just edit text and `git push`.

---

## The stack

```
You edit Markdown            (content/*.md)
        ↓ git push
GitHub repo                  github.com/xlxu220/PersonalWeb
        ↓ triggers
GitHub Actions               builds with Hugo, rsyncs over SSH
        ↓
Hostinger  public_html       (server path + credentials in DEPLOY.md)
        ↓
https://xiaolan.in
```

- **Theme:** Hugo Apéro (vendored in `themes/hugo-apero/`).
- **Build:** Hugo extended, pinned to v0.128.0 in the workflow.
- **Deploy:** `.github/workflows/deploy.yml` → rsync over SSH (key-based).
- **Secrets / server details:** see `DEPLOY.md` (git-ignored, private).
- **Design rationale & scope:** see `PRD.md`.

---

## Everyday workflow (the only thing you normally do)

1. **Edit** a Markdown file under `content/` (in Obsidian, VS Code, anything).
2. **Preview locally** (optional but recommended):

   ```bash
   hugo server      # open http://localhost:1313
   ```

3. **Publish:**

   ```bash
   git add .
   git commit -m "describe the change"
   git push
   ```

4. Wait ~2 minutes. GitHub Actions builds and deploys. Check status at
   <https://github.com/xlxu220/PersonalWeb/actions> — green check = live.

That's it. No FTP, no server login, no manual upload.

---

## Where content lives

| Page | File |
|------|------|
| Home (hero + intro) | `content/_index.md` |
| About | `content/about/header/`, `main/`, `sidebar/index.md` |
| Research | `content/research.md` |
| Projects (landing) | `content/project/_index.md` |
| A project | `content/project/<slug>/index.md` |
| Publications | `content/publication.md` |
| Talks (landing) | `content/talk/_index.md` |
| A talk | `content/talk/<slug>/index.md` (drop `slides.pdf` beside it) |
| Blog (landing) | `content/blog/_index.md` |
| A blog post | `content/blog/<slug>/index.md` |
| CV | `content/cv.md` (PDF: `static/files/cv.pdf`) |
| Contact | `content/contact.md` |
| Site settings, menu, social links | `config/_default/*.toml` |
| Images | `static/img/` (e.g. `profile.jpg`) |

**Add a new post/talk/project:** create a folder with an `index.md` in the right section. `hugo new blog/my-post/index.md` scaffolds the front matter for you.

---

## If a change doesn't show up

The site updates fine, but a **cache** can show you the old version:

1. **Hard refresh:** Cmd+Shift+R. Or check in a private/incognito window.
2. **Hostinger CDN/page cache** can hold the old page briefly — it expires on its own, usually within the hour, or purge it in hPanel (Performance → Clear cache).
3. To confirm the *server* is actually updated (bypassing all caches), the GitHub Actions run going green is the source of truth.

> This is exactly what happened at first launch — the deploy was correct; the browser/CDN was just showing the cached WordPress page.

---

## Occasional maintenance

- **Refresh citation counts** on `content/publication.md` — they're dated Google Scholar snapshots.
- **Swap the CV** — replace `static/files/cv.pdf`, regenerate from the master CV in the Profile folder.
- **Update social links** — `config/_default/params.toml` (Scholar and GitHub are still placeholders).
- **New headshot** — drop a square JPG at `static/img/profile.jpg`.
- **Theme updates** — Apéro is vendored, so it won't change unless you re-copy it; that's intentional (stable, low-maintenance).

---

## Key facts

- Repo: <https://github.com/xlxu220/PersonalWeb>
- Live: <https://xiaolan.in>
- Hosting: Hostinger Business plan (SSH key-based deploy enabled; details in `DEPLOY.md`)
- Identifiers wired into the site: ORCID `0000-0003-4321-7931`, Web of Science `U-3654-2018`
- WordPress: retired; the old content is archived in `wordpress-content-archive.md`
