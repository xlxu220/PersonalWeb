# GitHub Enterprise Pages Lessons — Research Presentations Site

**Date:** 2026-06-27  
**Context:** Internal JPL presentation portfolio (not xiaolan.in)  
**Site:** https://github.jpl.nasa.gov/pages/xxu/research-presentations/  
**Repo:** git@github.jpl.nasa.gov:xxu/research-presentations.git  
**Source:** `/Users/xxu/00_ReOrg/04_Outputs/03_Talks/public_html/`  
**Tech Stack:** Astro + Static Site Generation

**Note:** This is for the **research presentations site** (GitHub Pages + Astro), not the personal website xiaolan.in (Hostinger + Hugo). See `DEPLOY.md` for xiaolan.in deployment.

---

## Critical Lessons

### 1. Static Assets MUST Include Base URL in Production

**Problem:**
- Files in `public/2026/*.pdf` would link as `/2026/file.pdf` in local dev
- In production, needed `/pages/xxu/research-presentations/2026/file.pdf`
- Without base URL, assets returned 404 even though files were committed

**Solution:**
Always use `import.meta.env.BASE_URL` in Astro components for asset links:

```typescript
// src/components/TalkCard.astro
const base = import.meta.env.BASE_URL;

// For assets in public/
const url = `${base}${format.url}`;  // format.url is "/2026/file.pdf"
```

**Why this works:**
- Local dev: `BASE_URL` = empty string → `/2026/file.pdf` ✅
- Production: `BASE_URL` = `/pages/xxu/research-presentations` → `/pages/xxu/research-presentations/2026/file.pdf` ✅

**Astro config:**
```javascript
// astro.config.mjs
export default defineConfig({
  site: 'https://github.jpl.nasa.gov',
  base: '/pages/xxu/research-presentations',  // Critical!
  output: 'static',
});
```

---

### 2. GitHub Enterprise Pages Has Severe Caching (2-10 Minutes)

**Problem:**
- Made changes, deployed, saw old version
- Hard refresh didn't help immediately
- Thought deployment failed, but it was just cached

**Timeline observed:**
- Commit pushed at T+0
- GitHub Pages rebuilds: T+1 min
- Site partially updated: T+2-3 min
- Full cache clear: T+5-10 min

**What actually happens:**
1. Push triggers immediate rebuild (1 min)
2. New files deployed to server (2 min)
3. CDN/proxy cache expires gradually (5-10 min)
4. Different assets cache at different rates (HTML faster than static files)

**Debugging strategy:**
1. Check local `index.html` has your changes ✅
2. Check git commit includes the files ✅
3. Wait 3 minutes
4. Hard refresh (`Cmd+Shift+R` on Mac, `Ctrl+F5` on Windows)
5. Try incognito/private window
6. If still wrong after 5 min, check git log to verify file was pushed
7. If file was pushed but still not showing, wait 10 min total

**Rule of thumb:** Wait at least 5 minutes before assuming deployment failed.

---

### 3. Build Output Must Be Committed (No GitHub Actions on Enterprise)

**Problem:**
- Wanted to use GitHub Actions for clean git history
- Enterprise doesn't provide hosted runners

**Solution:**
Manual build + commit workflow:

```bash
# 1. Build
npm run build

# 2. Copy dist to root (careful - overwrites!)
cp -r dist/* .
rm -rf dist

# 3. Commit build artifacts
git add index.html talks/index.html
git commit -m "Update: description"
git push

# 4. Wait 5+ minutes for cache to clear
```

**What gets committed:**
- ✅ `index.html` (built)
- ✅ `talks/index.html` (built)
- ✅ `2026/` folder (from `public/`, served as static assets)
- ✅ `src/` (source code)
- ❌ `node_modules/` (gitignored)
- ❌ `dist/` (gitignored)
- ❌ `.astro/` (gitignored)

---

### 4. CSS Variables + Inline Styles for Dynamic Backgrounds

**Problem:**
- Wanted different background colors per category card
- Astro components are server-rendered, no client-side JS for styling

**Solution:**
1. Define colors as CSS variables in BaseLayout:
```css
:root {
  --smap-bg: #e8f5e9;    /* light green */
  --cygnss-bg: #e3f2fd;  /* light blue */
  --snow-bg: #f5f5f5;    /* light gray */
  --genai-bg: #efebe9;   /* light brown */
}
```

2. Map categories to colors in component:
```typescript
const bgColorMap: Record<string, string> = {
  'smap': 'var(--smap-bg)',
  'cygnss': 'var(--cygnss-bg)',
  'snow': 'var(--snow-bg)',
  'genai': 'var(--genai-bg)',
};
```

3. Apply via inline style:
```astro
<div class="category-card" style={`background-color: ${bgColorMap[id]};`}>
```

**Why inline styles:**
- Astro scopes CSS per component (can't reference parent component's CSS)
- CSS variables defined in BaseLayout are global
- Inline styles reference global variables → works across component boundaries

---

### 5. Design Changes: Spacing and Visual Balance

**Principles applied:**
- **Hero as introduction, cards as main content** — compact hero, spacious card grid
- **Reduce spacing in increments** — cut 50% first, then tweak by 0.25rem
- **Tighten line-height for headings** — 1.4 for headings, 1.5-1.6 for body
- **Use relative units** — `rem` for spacing, not `px` (easier to adjust globally)

**Specific changes:**
```css
/* Before: Loose spacing */
.hero { margin: 0 auto 3rem; }
.hero h1 { margin-bottom: 1rem; }
.hero .subhead { margin-bottom: 1rem; }

/* After: Compact spacing */
.hero { margin: 0 auto 1.5rem; }      /* 50% reduction */
.hero h1 { margin-bottom: 0.75rem; }   /* 25% reduction */
.hero .subhead { margin-bottom: 0.5rem; }  /* 50% reduction */
```

**Result:** Hero section 40% shorter, cards visible without scrolling.

---

### 6. Thicker Accent Borders for Visual Hierarchy

**Before:**
```css
border-left: 4px solid var(--jpl-red);
```

**After:**
```css
border-left: 6px solid var(--jpl-red);
```

**Why:** With subtle background colors, thicker border provides stronger visual anchor. 6px is noticeable without being heavy.

---

### 7. Earth Science Color Palette (Subtle Backgrounds)

**Color choices:**
- SMAP (soil moisture) → Light green `#e8f5e9` (vegetation/moisture)
- CYGNSS (ocean reflection) → Light blue `#e3f2fd` (water)
- Snow → Light gray `#f5f5f5` (ice/snow)
- Gen-AI → Light brown `#efebe9` (earth/soil)

**Saturation level:** ~10% tint of base hue
- Too light: invisible, no differentiation
- Too saturated: unprofessional, hard to read text
- Sweet spot: Visible but not distracting

**Testing approach:**
1. Started with 5% tint → too subtle
2. Tried 20% tint → too saturated
3. Settled on 10-15% tint → readable + distinct

---

### 8. git add Strategy for Mixed Changes

**Problem:**
- Made changes to `src/` (source) and `index.html` (build output)
- Also had unrelated changes in `.astro/` (local cache)
- Didn't want to commit everything

**Solution:**
Stage files explicitly:
```bash
git add src/components/CategoryCard.astro
git add src/layouts/BaseLayout.astro
git add src/pages/index.astro
git add index.html talks/index.html
git add docs/STRUCTURE.md

# NOT: git add -A (would include .astro/ cache files)
```

**When to use each:**
- `git add -A` → Only when everything is intentional
- `git add <specific files>` → When you have cache/build artifacts mixed in
- `git add -u` → Only tracked files (skips new untracked files)

---

### 9. Browser DevTools for CSS Debugging

**Workflow:**
1. Open browser DevTools (`Cmd+Option+I`)
2. Inspect element
3. Edit CSS live to test values
4. Once happy, copy to source file
5. Rebuild and deploy

**Why this works:**
- Instant feedback (no rebuild cycle)
- Can test multiple values quickly
- See computed styles (what actually renders)

**Example:** Testing spacing values
- Tried `margin-bottom: 0.5rem` → too tight
- Tried `margin-bottom: 1rem` → too loose
- Settled on `margin-bottom: 0.75rem` → just right

---

### 10. Documentation Organization

**Three-tier structure:**

1. **CLAUDE.md** (workflow instructions, stays at root)
   - How to add talks
   - Build commands
   - Deployment steps

2. **docs/STRUCTURE.md** (directory map)
   - What lives where
   - Common tasks cheat sheet
   - Navigation reference

3. **docs/GITHUB-PAGES-LESSONS.md** (this file)
   - Design decisions
   - Technical gotchas
   - Lessons learned

**Why separate:**
- CLAUDE.md = operational (how to do X)
- STRUCTURE.md = organizational (where is X)
- Lessons learned = educational (why we do X this way)

Different audiences, different retention periods.

---

## Quick Reference

### Adding a new talk
```bash
# 1. Add files
cp slides.pdf public/2026/2026-MM-DD_Topic_XU.pdf

# 2. Create metadata
cat > src/content/talks/2026/slug.md <<EOF
---
title: "Title"
date: 2026-MM-DD
category: smap
venue: "Conference Name"
formats:
  pdf: "/2026/2026-MM-DD_Topic_XU.pdf"
---
EOF

# 3. Build and deploy
npm run build
cp -r dist/* . && rm -rf dist
git add src/ index.html talks/index.html
git commit -m "Add: Talk title"
git push

# 4. Wait 5+ minutes for GitHub Pages
```

### Testing locally before deploy
```bash
npm run dev
# Visit http://localhost:4321
# Check everything works
# THEN build and deploy
```

### If changes don't appear after deploy
1. Wait 5 full minutes (set a timer!)
2. Hard refresh: `Cmd+Shift+R` (Mac) or `Ctrl+F5` (Windows)
3. Try incognito/private window
4. Check git log: `git log --oneline -3` (verify your commit pushed)
5. Check local file: `head -20 index.html` (verify your changes are in the file)
6. If still wrong after 10 minutes, something else is wrong

---

## What We Tried That Didn't Work

### Removing base URL from asset links
**Why we tried:** Thought it would work like regular static hosting  
**Why it failed:** GitHub Pages requires full path including `/pages/xxu/research-presentations/`  
**Lesson:** Always include base URL for assets in subpath deployments

### Assuming immediate updates
**Why we tried:** Local dev server updates instantly  
**Why it failed:** GitHub Enterprise Pages has 5-10 minute cache  
**Lesson:** Deploy, wait 5 min, THEN check results

### Using background property instead of inline styles
**Why we tried:** Cleaner CSS, no inline styles  
**Why it failed:** Astro scoped styles can't access parent component's CSS variables  
**Lesson:** When you need dynamic values from component props, use inline styles with CSS variables

---

## Future Enhancements (Not Yet Implemented)

1. **Automated screenshots** — Generate thumbnails from HTML slides
2. **Search** — Client-side search across talk titles/venues
3. **RSS feed** — Auto-generated from content collection
4. **Year-based filtering** — Filter talks by year in addition to category
5. **Related talks** — Show related talks based on category/author
6. **Analytics** — Track which talks are most viewed

---

## Key Takeaways

1. **GitHub Enterprise Pages is slow** — 5-10 min cache, plan accordingly
2. **Base URL is critical** — All asset links need it for subpath hosting
3. **Build artifacts must be committed** — No Actions on Enterprise
4. **Inline styles + CSS variables** — Best pattern for dynamic styling in Astro
5. **Wait before debugging** — Give cache time to clear before assuming failure
6. **Test locally first** — `npm run dev` catches most issues before deploy
7. **Document as you go** — Capture lessons while fresh, reference later

---

**Last Updated:** 2026-06-27  
**Site Status:** Live and working  
**Next Review:** When adding next major feature or encountering new issues
