# Dependencies:
#	  go get github.com/gohugoio/hugo
build:
	hugo

# Dependencies:
#	  npm install netlify-cli
deploy:
	netlify deploy -p public

clean:
	rm -r public

.PHONY: build deploy clean
