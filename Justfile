set shell := ["bash", "-euxo", "pipefail", "-c"]

RUBY_BIN := "/opt/homebrew/opt/ruby/bin"
HTML_FOLDER := "_site"

build:
	PATH="{{RUBY_BIN}}:$PATH" bundle exec jekyll build

serve:
	PATH="{{RUBY_BIN}}:$PATH" bundle exec jekyll serve --livereload

clean:
	rm -rf {{HTML_FOLDER}}

deploy: build
	: "${CLOUDFLARE_PAGES_PROJECT_NAME:?Set CLOUDFLARE_PAGES_PROJECT_NAME}"
	npx wrangler@latest pages deploy {{HTML_FOLDER}} --project-name "$CLOUDFLARE_PAGES_PROJECT_NAME"
