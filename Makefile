# template of Makefile
#
AEM_VERSION=6.5.0

#https://stackoverflow.com/questions/18136918/how-to-get-current-relative-directory-of-your-makefile
MAKE_ROOT:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PREPARED_DOCKER_COMPOSE_YML=.prepared.docker-compose.yml

PROJECT=test

test: ## print test message
	@echo 20180508
	@echo 2018/05/09
	@echo 2018-05-11

prepare-docker-compose-yml:
	@cp -f docker-compose.yml ${PREPARED_DOCKER_COMPOSE_YML}
	@sed -i.back -e 's/{{AEM_VERSION}}/${AEM_VERSION}/' ${PREPARED_DOCKER_COMPOSE_YML}
	@sed -i.back -e 's|{{MAKE_ROOT}}|${MAKE_ROOT}|' ${PREPARED_DOCKER_COMPOSE_YML}
	@cat .prepared.docker-compose.yml >&2

build:
	@make -s prepare-docker-compose-yml
#	@cat /tmp/docker-compose.yml
	@docker-compose -f ${PREPARED_DOCKER_COMPOSE_YML} build --build-arg AEM_IMAGE=aem${AEM_VERSION}

up:
	@make -s prepare-docker-compose-yml
	@mkdir -p custom/${PROJECT} && \
		cd custom/${PROJECT} && \
		pwd && \
		cp -rav ${MAKE_ROOT}/${PREPARED_DOCKER_COMPOSE_YML} ./docker-compose.yml && \
		dir=author; mkdir $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		dir=publish; mkdir $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		dir=dispatcher; mkdir $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		docker-compose up

tup: #Temporary UP
	@make -s prepare-docker-compose-yml
	@cd `mktemp -d` && \
		pwd && \
		cp -rav ${MAKE_ROOT}/${PREPARED_DOCKER_COMPOSE_YML} ./docker-compose.yml && \
		dir=author; mkdir $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		dir=publish; mkdir $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		dir=dispatcher; mkdir $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		docker-compose up

rmtmp:
	@docker ps -a | grep -E ' tmp.+' | awk '{print $$NF}' | xargs docker rm

disposable: # Create such images & containers & up
	@make -s prepare-docker-compose-yml
	@./clone-containers.sh "${PROJECT}"


.PHONY: help

help: ## print about the targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
#.DEFAULT_GOAL := help
# https://postd.cc/auto-documented-makefile/
# https://www.gnu.org/software/make/manual/make.html#Standard-Targets

#https://kanasys.com/tech/522
##!/bin/bash
#make -j -f <(tail -n+$(expr $LINENO + 1) $0) $@ ;exit 0

