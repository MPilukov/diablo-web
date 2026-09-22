# Diablo (1996) in the browser: the prebuilt diabloweb site (d07RiV/diabloweb,
# gh-pages branch) served by nginx. It ships the shareware spawn.mpq, so the
# demo runs as is; a player with the full game loads their own DIABDAT.MPQ.
FROM nginx:1.27-alpine

# Pinned to a commit of the gh-pages branch and checked by hash, so a change
# upstream cannot change this image silently.
ARG DW_REF=6e187315aec6bd7c0b53275ef0228718a789ecff
ARG DW_SHA256=989e20b6e85922ef657170614a168c8aaaebc45ce05378e43fb84091da332a34

RUN apk add --no-cache curl \
	&& curl -fsSL -o /tmp/dw.tgz "https://codeload.github.com/d07RiV/diabloweb/tar.gz/${DW_REF}" \
	&& echo "${DW_SHA256}  /tmp/dw.tgz" | sha256sum -c - \
	&& mkdir -p /usr/share/nginx/html/diabloweb \
	&& tar -xzf /tmp/dw.tgz -C /usr/share/nginx/html/diabloweb --strip-components=1 \
	&& rm /tmp/dw.tgz \
	&& find /usr/share/nginx/html/diabloweb -name '*.map' -delete \
	# the build reports to its author's Google Analytics property; drop the id
	&& sed -i 's/UA-43123589-6//g' /usr/share/nginx/html/diabloweb/static/js/*.js \
	&& ! grep -rq 'UA-43123589-6' /usr/share/nginx/html/diabloweb \
	&& test -s /usr/share/nginx/html/diabloweb/spawn.mpq \
	&& apk del curl

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
