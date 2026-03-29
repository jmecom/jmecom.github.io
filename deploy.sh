#!/usr/bin/env bash
set -euo pipefail

HTML_FOLDER="${HTML_FOLDER:-_site}"
: "${CLOUDFLARE_PAGES_PROJECT_NAME:?Set CLOUDFLARE_PAGES_PROJECT_NAME}"

bundle exec jekyll build --destination "${HTML_FOLDER}"

npx wrangler@latest pages deploy "${HTML_FOLDER}" \
  --project-name "${CLOUDFLARE_PAGES_PROJECT_NAME}"
