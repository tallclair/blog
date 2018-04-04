build:
	hugo

build-draft:
	hugo --buildDrafts

deploy:
	netlifyctl deploy

preview:
	netlifyctl deploy --draft

preview-local:
	hugo server

clean:
	rm -r public

build-deps:
	go get -u github.com/netlify/netlifyctl
	go get -u github.com/gohugoio/hugo

.PHONY: build deploy clean
