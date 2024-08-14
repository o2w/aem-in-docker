# template of Makefile
#
#AEM=6.5.0
AEM=acs

#https://stackoverflow.com/questions/18136918/how-to-get-current-relative-directory-of-your-makefile
MAKE_ROOT:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PREPARED_DOCKER_COMPOSE_YML=.prepared.docker-compose.yml

PROJECT=default-${AEM}

test: ## print test message
	@echo 20180508
	@echo 2018/05/09
	@echo 2018-05-11
	@dir=hoge; echo $$dir

aem:
	@cd ./aem${AEM}; ls aem-sdk-2*.zip | xargs -I{} unzip -n {}
#	@javadeb=`cat <(ls ./aem${AEM}) <(ls ./default) | sort -u | grep -E '(jdk-11.*\.deb|jdk-8.*\.tar\.gz)' | tail -n1`
	@javadeb=`cd ./aem${AEM}; ls | sort | grep -E '(jdk-11.*\.deb|jdk-8.*\.tar\.gz)' | tail -n1` && \
		acssdk=`cd ./aemacs; ls | sort | grep 'aem-sdk-quickstart' | tail -n1` && \
		echo $$javadeb && \
		echo $$acssdk && \
		docker build -t aem${AEM} ./aem${AEM} --build-arg JAVADEB="$${javadeb}" --build-arg ACSSDK="$${acssdk}"
#		echo ''
#	@docker build -t aem${AEM} ./aem${AEM}
#

prepare-docker-compose-yml:
	@cp -f docker-compose.yml ${PREPARED_DOCKER_COMPOSE_YML}
	@sed -i.back -e 's/{{AEM_VERSION}}/${AEM}/' ${PREPARED_DOCKER_COMPOSE_YML}
	@sed -i.back -e 's|{{MAKE_ROOT}}|${MAKE_ROOT}|' ${PREPARED_DOCKER_COMPOSE_YML}
	@cat .prepared.docker-compose.yml >&2

build:
	@make -s prepare-docker-compose-yml
#	@cat /tmp/docker-compose.yml
	@docker compose -f ${PREPARED_DOCKER_COMPOSE_YML} build --build-arg AEM=aem${AEM}

init:
	@make -s aem
	@make -s build
	@make -s prepare-docker-compose-yml
	@./install_packages.sh author custom/${PROJECT} &
	@./install_packages.sh publish custom/${PROJECT} &
	@echo "${AEM}" | grep '6.4' || ./install_wknd.sh &
	@mkdir -p custom/${PROJECT} && \
		cd custom/${PROJECT} && \
		pwd && \
		cp -av ${MAKE_ROOT}/${PREPARED_DOCKER_COMPOSE_YML} ./docker-compose.yml && \
		dir=author; mkdir -p $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		dir=publish; mkdir -p $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		dir=dispatcher; mkdir -p $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		docker compose up

#http://localhost:4502/libs/granite/operations/content/systemoverview.html

tup: #Temporary UP
	@make -s prepare-docker-compose-yml
	@cd `mktemp -d` && \
		pwd && \
		cp -rav ${MAKE_ROOT}/${PREPARED_DOCKER_COMPOSE_YML} ./docker-compose.yml && \
		dir=author; mkdir $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		dir=publish; mkdir $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		dir=dispatcher; mkdir $$dir && cp -a ${MAKE_ROOT}/$$dir/Dockerfile ./$$dir && \
		docker compose up; docker compose rm

rmtmp:
	@docker ps -a | grep -E ' tmp.+' | awk '{print $$NF}' | xargs docker rm

#https://forums.docker.com/t/how-to-delete-cache/5753/14
#https://stackoverflow.com/questions/45357771/stop-and-remove-all-docker-containers
rm:
	-@docker stop $(shell docker ps -a -q)
	-@docker rm $(shell docker ps -a -q)
	-@docker rmi $(shell docker images -a --filter=dangling=true -q)
	-@docker rm $(shell docker ps --filter=status=exited --filter=status=created -q)
	-@docker system prune -a
	-@docker builder prune

login:
	@docker exec -it $(shell docker ps | grep author | awk '{print $$1}') /bin/bash

up: # Create such images & containers & up
	@make -s prepare-docker-compose-yml
	-@docker ps -a | grep  -E 'tmp.*${PROJECT}' | awk '{print $$1}' | xargs docker rm
	@./disposable.sh "${PROJECT}"

local-author:
	@cd `mktemp -d` && \
		pwd && \
		echo ${MAKE_ROOT} && \
		export JAVA_HOME="/usr/lib/jvm/jdk-11" && \
		/usr/lib/jvm/jdk-11/bin/java -version && \
		cp ${MAKE_ROOT}/aemacs/aem-sdk-quickstart.jar ./cq-quickstart.jar && \
		/usr/lib/jvm/jdk-11/bin/java -jar cq-quickstart.jar -unpack && \
		cp -r ${MAKE_ROOT}/aemacs/install ./crx-quickstart/ && \
		mv ./cq-quickstart.jar ./aem-author-p4502.jar && \
		/usr/lib/jvm/jdk-11/bin/java -Xms4096m -Xmx4096m -XX:MaxPermSize=2034m -Djava.awt.headless=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=1089 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar ./aem-author-p4502.jar -nofork

local-author-mac:
	@cd `mktemp -d` && \
		pwd && \
		echo ${MAKE_ROOT} && \
		java -version && \
		cp ${MAKE_ROOT}/aemacs/aem-sdk-quickstart.jar ./cq-quickstart.jar && \
		java -jar cq-quickstart.jar -unpack && \
		cp -r ${MAKE_ROOT}/aemacs/install ./crx-quickstart/ && \
		mv ./cq-quickstart.jar ./aem-author-p4502.jar && \
		java -jar ./aem-author-p4502.jar -forkargs -- -Xmx2024m

exec-author:
	docker exec -it `docker ps | grep author | awk '{print $$1}'` /bin/bash

wknd:
	@cd /tmp/ && git clone https://github.com/adobe/aem-guides-wknd && cd aem-guides-wknd && mvn clean install -PautoInstallSinglePackage -Pclassic

.PHONY: help

help: ## print about the targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
#.DEFAULT_GOAL := help
# https://postd.cc/auto-documented-makefile/
# https://www.gnu.org/software/make/manual/make.html#Standard-Targets

#https://kanasys.com/tech/522
##!/bin/bash
#make -j -f <(tail -n+$(expr $LINENO + 1) $0) $@ ;exit 0

