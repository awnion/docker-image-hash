DOCKER              ?= docker
DOCKER_BUILDER_NAME ?= public-gosh-builder
DOCKER_BUILDX       ?= ${DOCKER} buildx --builder ${DOCKER_BUILDER_NAME} build
PLATFORM            ?= linux/amd64,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x
PROGRESS            ?= plain

PROJECT_ROOT        ?= ..

# GIT_COMMIT := $(shell git rev-parse HEAD)
# GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

# # main ==> docker:latest
# ifeq "${GIT_BRANCH}" "main"
# 	GIT_BRANCH := "latest"
# endif


.PHONE: default
default: help


.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONE: clean
clean:
	${DOCKER} buildx rm ${DOCKER_BUILDER_NAME} || true


.PHONE: prepare-builder
prepare-builder: ## Prepare docker buildx builder container
	( ${DOCKER} buildx inspect ${DOCKER_BUILDER_NAME} ) || ${DOCKER} buildx create \
		--name ${DOCKER_BUILDER_NAME} \
		--driver docker-container


build: ## Make local image
	${DOCKER_BUILDX} \
		--load \
		-t teamgosh/image-hash:latest \
		\
		-f Dockerfile \
		${PROJECT_ROOT}


publish: ## Publish Docker image
	${DOCKER_BUILDX} \
		--push \
		--progress=${PROGRESS} \
		--platform ${PLATFORM} \
		-t teamgosh/image-hash:latest \
		\
		-f Dockerfile \
		${PROJECT_ROOT}
