
FROM nginxinc/nginx-unprivileged:1.31.1-alpine

ARG SOURCE_URL="https://github.com/pdxlocations/meshconfig"
LABEL org.opencontainers.image.title="MeshConfig" \
      org.opencontainers.image.description="Static web app for direct Meshtastic configuration" \
      org.opencontainers.image.source="${SOURCE_URL}" \
      org.opencontainers.image.licenses="GPL-3.0-or-later"

COPY index.html app.js i18n.js styles.css /usr/share/nginx/html/
COPY configs/ /usr/share/nginx/html/configs/
COPY i18n/    /usr/share/nginx/html/i18n/

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider http://127.0.0.1:8080/ || exit 1
