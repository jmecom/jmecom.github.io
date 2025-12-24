set shell := ["bash", "-euxo", "pipefail", "-c"]

RUBY_BIN := "/opt/homebrew/opt/ruby/bin"
HTML_FOLDER := "_site"
GH_REF := "github.com/jmecom/jmecom.github.io"

build:
	PATH="{{RUBY_BIN}}:$PATH" bundle exec jekyll build

serve:
	PATH="{{RUBY_BIN}}:$PATH" bundle exec jekyll serve --livereload

clean:
	rm -rf {{HTML_FOLDER}}

deploy1: build
	PATH="{{RUBY_BIN}}:$PATH" bash -c 'cd {{HTML_FOLDER}} && git init && git add --all && git commit -m "Deploy to GitHub Pages" && git push --force --quiet "https://${GH_TOKEN}@{{GH_REF}}" master:gh-pages'
