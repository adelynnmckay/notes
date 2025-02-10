.PHONY: all
all: serve

.PHONY: setup
setup:
	bundle config set --local path 'vendor/bundle' && \
	(bundle update || echo) && \
	bundle install

.PHONY: build
build: setup
	bundle exec jekyll build --trace

.PHONY: serve
serve: build
	bundle exec jekyll serve --watch

