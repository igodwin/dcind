DOCKER_VERSION ?= 26.1.2
DOCKER_COMPOSE_VERSION ?= 2.27.0
TAG ?= latest

.PHONY: all
all: build tag push

.PHONY: build
build:
	docker build -t dcind \
		--build-arg DOCKER_VERSION=${DOCKER_VERSION} \
		--build-arg DOCKER_COMPOSE_VERSION=${DOCKER_COMPOSE_VERSION} \
		.

.PHONY: tag
tag: img-base
	docker tag dcind \
		$(IMG_BASE)/dcind

.PHONY: push
push: tag
	docker push $(IMG_BASE)/dcind:$(TAG)

img-base:
ifndef IMG_BASE
	$(error IMG_BASE environment variable must be set)
endif
