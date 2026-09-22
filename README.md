# diablo-web

Diablo (1996) in the browser, from the prebuilt [diabloweb](https://github.com/d07RiV/diabloweb)
site, in one nginx container on port 80. The shareware `spawn.mpq` is included, so the demo
(the first dungeon levels, the Warrior) runs straight away; the full game needs your own
`DIABDAT.MPQ`, which the page asks for and keeps in the browser.

```bash
docker build -t diablo-web . && docker run --rm -p 8080:80 diablo-web
```
