.PHONY: all
all:
	export JEKYLL_ENV=debug && \
	bundle config set --local path 'vendor/bundle' && \
	(bundle update || echo) && \
	bundle install && \
	mkdir -p _site && \
	bundle exec jekyll serve --watch

