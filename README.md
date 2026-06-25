# xiaolan.in — personal science website

Hugo site (theme: **Apéro**) for [xiaolan.in](https://xiaolan.in). Authored in Markdown, built with Hugo, deployed to Hostinger via GitHub Actions on every push to `main`.

See `PRD.md` for the full design and migration plan.

---

## One-time setup (run on your Mac)

This scaffold was generated in a sandbox that couldn't delete files, so the vendored theme still contains its own `.git` folder and an `exampleSite/`. Clean those up once, locally, before your first commit:

```bash
cd "path/to/Website"

# 1. Remove the theme's embedded git repo and example site (so git treats it as plain files)
rm -rf themes/hugo-apero/.git themes/hugo-apero/exampleSite

# 2. Initialize YOUR repo
git init
git add .
git commit -m "Initial Hugo site (Apero), migrated from WordPress"

# 3. Create the GitHub repo, then:
git branch -M main
git remote add origin git@github.com:<your-username>/xiaolan-site.git
git push -u origin main
```

> Prefer the theme as a submodule instead of vendored? After step 1, run:
> `rm -rf themes/hugo-apero && git submodule add https://github.com/hugo-apero/hugo-apero.git themes/hugo-apero`

---

## Run locally

Install Hugo **extended** (`brew install hugo`), then:

```bash
hugo server        # live preview at http://localhost:1313
hugo --gc --minify # production build into ./public
```

---

## Add content

| You want to add… | Create… |
|------------------|---------|
| A blog post | `content/blog/<slug>/index.md` |
| A project | `content/project/<slug>/index.md` |
| A talk (+ slides) | `content/talk/<slug>/index.md` and drop `slides.pdf` beside it |
| A simple page | `content/<name>.md` |

`hugo new blog/my-post/index.md` scaffolds front matter from the archetypes.

Write in Obsidian, copy the Markdown into `content/`, commit, push — Actions does the rest.

---

## Deploy

`.github/workflows/deploy.yml` builds and rsyncs `public/` to Hostinger over SSH.
Set these repo secrets (Settings → Secrets and variables → Actions):

- `SSH_HOST`, `SSH_USER`, `SSH_PORT`, `SSH_KEY`, `DEPLOY_PATH`

Get the SSH host/port/username from **hPanel → Websites → xiaolan.in → Advanced → SSH Access**, and add your public key there. `DEPLOY_PATH` is the docroot, e.g. `/home/uXXXX/domains/xiaolan.in/public_html`.

> **Before first deploy:** back up the existing WordPress site (hPanel → Files + Database export), then let the first rsync (`--delete`) replace it. See `PRD.md` §6.1.

---

## To replace before launch

- `static/img/profile.jpg` — your headshot (square works best)
- `static/img/logo.png`, `static/img/favicon.ico`
- `static/files/cv.pdf` — current CV (export from the master `.docx` in the Profile folder)
- Social URLs in `config/_default/params.toml` (Scholar, ORCID, GitHub, ResearchGate)
- Real talk(s) in `content/talk/` (the `igarss-sample` is a placeholder)
