# Deploy runbook — xiaolan.in

> **Private file.** Git-ignored on purpose (it holds server connection details). Don't commit or share it.

This is the step-by-step to go from the local repo to the live site. Steps marked **[you]** require your account/credentials or a setting change — I can't do those for you. Everything else is already built.

---

## Your Hostinger connection details (from hPanel, 2026-06-25)

| Item | Value |
|------|-------|
| SSH host / IP | `145.223.77.126` |
| SSH port | `65002` |
| SSH username | `u156465630` |
| Document root (`DEPLOY_PATH`) | `/home/u156465630/domains/xiaolan.in/public_html` |
| SSH status | **INACTIVE — must be enabled (step 2)** |
| Hosting backups | Daily (automatic) |

---

## Step 0 — Back up the WordPress site **[you]**

Even though daily backups run, take a manual snapshot before the first deploy overwrites the site:
hPanel → xiaolan.in → Files → **Backups** → generate/download a backup (files + database). Keep it off the repo.

## Step 1 — Initialize the repo **[you, one command]**

On your Mac, in the `Website/` folder:

```bash
bash setup.sh
```

This cleans the vendored theme, runs `git init`, and makes the first commit. (Verified to produce a clean ~310-file commit that builds 63 pages.)

## Step 2 — Enable SSH + add your key on Hostinger **[you]**

1. hPanel → xiaolan.in → Advanced → SSH Access → click **Enable**.
2. Generate a key pair on your Mac (no passphrase, dedicated to deploys):

   ```bash
   ssh-keygen -t ed25519 -f ~/.ssh/xiaolan_deploy -C "github-actions-deploy"
   ```

3. On the SSH Access page, add the **public** key (`~/.ssh/xiaolan_deploy.pub`) under "Manage SSH keys".
4. Test it:

   ```bash
   ssh -i ~/.ssh/xiaolan_deploy -p 65002 u156465630@145.223.77.126
   ```

## Step 3 — Create the GitHub repo and push **[you]**

1. Create an **empty** repo at github.com (e.g. `xiaolan-site`), no README.
2. ```bash
   git remote add origin git@github.com:<your-username>/xiaolan-site.git
   git push -u origin main
   ```

## Step 4 — Add the deploy secrets **[you]**

GitHub repo → Settings → Secrets and variables → Actions → **New repository secret**, one per row:

| Secret name | Value |
|-------------|-------|
| `SSH_HOST` | `145.223.77.126` |
| `SSH_USER` | `u156465630` |
| `SSH_PORT` | `65002` |
| `DEPLOY_PATH` | `/home/u156465630/domains/xiaolan.in/public_html` |
| `SSH_KEY` | contents of the **private** key `~/.ssh/xiaolan_deploy` (the whole file) |

## Step 5 — Deploy

The push in Step 3 already triggered the workflow, but it will have failed at the deploy step until the secrets exist. Re-run it:

GitHub repo → **Actions** tab → latest run → **Re-run all jobs**.

The job builds the site and `rsync`s it to `public_html`, **replacing the WordPress files**. Give DNS/caching a few minutes, then load https://xiaolan.in.

## Step 6 — Retire WordPress **[you]**

Once the static site is confirmed live and correct: hPanel → xiaolan.in → WordPress → remove the WordPress installation (the files are already replaced; this clears the database/app entry). Keep your backup from Step 0.

---

## After launch

Edit Markdown in `content/`, then:

```bash
git add . && git commit -m "update content" && git push
```

Every push auto-builds and redeploys. Preview locally first with `hugo server`.
