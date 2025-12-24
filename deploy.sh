#!/usr/bin/env bash
set -euo

bundle exec jekyll build
# bundle exec travis-lint
# bundle exec htmlproof ${HTML_FOLDER} --disable-external

cd ${HTML_FOLDER}

# deploy
git init
git add --all
git commit -m "Deploy to GitHub Pages"
git push --force --quiet "https://${GH_TOKEN}@github.com/${GH_REF}" master:gh-pages
