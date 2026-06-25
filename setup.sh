#!/usr/bin/env bash
# One-time repo setup for the xiaolan.in Hugo site.
# Run this ONCE, on your Mac, from inside the Website/ folder.
set -euo pipefail

echo "==> 1/4  Cleaning the vendored theme (remove its embedded git repo + example site)"
rm -rf themes/hugo-apero/.git themes/hugo-apero/exampleSite

echo "==> 2/4  Removing leftover build artifacts"
rm -rf public resources .hugo_build.lock

echo "==> 3/4  Initializing git and committing"
git init
git add .
git commit -m "Initial Hugo site (Apero theme), migrated from WordPress"
git branch -M main

echo "==> 4/4  Connecting to GitHub and pushing"
git remote add origin https://github.com/xlxu220/PersonalWeb.git 2>/dev/null || git remote set-url origin https://github.com/xlxu220/PersonalWeb.git
git push -u origin main

cat <<'NEXT'

Pushed. Next: add the deploy secrets in your GitHub repo
  Settings -> Secrets and variables -> Actions -> New repository secret
(the 5 values are in DEPLOY.md), then enable SSH on Hostinger.

Preview locally any time with:  hugo server
NEXT
