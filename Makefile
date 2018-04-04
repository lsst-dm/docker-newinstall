all: build

build:
	docker build \
		-t lsstsqre/centos:7-newinstall .
