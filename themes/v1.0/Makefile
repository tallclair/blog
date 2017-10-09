all: assets

.PHONY: assets
assets: css

.PHONY: css
css: static/style.css

# Dependencies:
#   go get github.com/tdewolff/minify/cmd/minify
static/style.css: css/*.css
	minify css/*.css > static/style.css
