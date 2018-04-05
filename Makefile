all: build

build:
	docker build \
		-t lsstsqre/newinstall .
