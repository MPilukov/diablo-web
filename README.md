# diablo-web

Diablo (1996) in the browser, from the prebuilt [diabloweb](https://github.com/d07RiV/diabloweb)
site, in one nginx container on port 80. The shareware `spawn.mpq` is included, so the demo
(the first dungeon levels, the Warrior) runs straight away; the full game needs your own
`DIABDAT.MPQ`, which the page asks for and keeps in the browser.

```bash
docker build -t diablo-web . && docker run --rm -p 8080:80 diablo-web
```

## Deploy

Hosted on Filiniti as a Git app: https://diablo.filiniti.app, app id `5a47db0f-c432-49de-a412-cb4c3e443cad`, built from this repo's `Dockerfile` on `main`.
Both ways below build what is on GitHub, so commit and push first - local changes never go up. The
address, access, env vars and data folders stay; a build that fails leaves the previous version running.

1. **CI/CD: not on.** This repo has no Filiniti push webhook, so a push to `main` does not deploy.
   Turn on "Auto-deploy from GitHub" ("Redeploy automatically on git push") in the app's settings on filiniti.com to make it work like the other repos.
2. **Directly**, after the push: through the Filiniti MCP server `redeploy_git_app(appId)`, which
   returns a generationId, then `get_creation_status(generationId, waitSeconds: 45)` until it is done;
   or the Rebuild button on the app's page on filiniti.com.

After either: `get_app_status("5a47db0f-c432-49de-a412-cb4c3e443cad")` (container running, restart count) and `get_app_logs` for errors.
The container is down for a few seconds while it is replaced.
