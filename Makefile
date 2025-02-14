.PHONY: all
all:
	export JEKYLL_ENV=debug && \
	bundle config set --local path 'vendor/bundle' && \
	(bundle update || echo) && \
	bundle install && \
	mkdir -p _site && \
	chmod +x _scripts/*.sh && \
	_scripts/build.sh && \
	bundle exec jekyll serve --watch

