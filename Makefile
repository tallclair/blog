# Dependencies:
#	  go get github.com/gohugoio/hugo
build:
	hugo

# Dependencies:
#	  npm install netlify-cli
deploy:
	netlify deploy -p public

.PHONY: build deploy
