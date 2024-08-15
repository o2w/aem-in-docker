# Local AEM Buildup

* Builds set of AEM instances of author, publish, dispatcher based on Docker containers
* Can easily build separate sets project by project
* Prespecified packages can automatically be installed via curl script kicks package manager

* So each set of instances can be dedicated to project instead of multi tenants in single AEM
* So each set can be more disposable and reproduced cleanly against any changes have made, by minmized effort

## Prerequisites

## Usage

### Initiate

#### AEM as a Cloud Service

make init [AEM=acs PROJECT=default-acs]

#### AEM6.5.0 

make init AEM=6.5.0 PROJECT=default-6.5.0

#### AEM6.4.0 

make init AEM=6.4.0 PROJECT=default-6.4.0

### Re-launch existing sets

make up [PROJECT=existing-project-name]

## Note

Forked from aem-in-docker but now this is incompatible and having big different. Only inherits the idea, local AEMs in Docker.

## links

https://digitalvarys.com/create-aem-in-docker-with-docker-compose/
https://www.aemcq5tutorials.com/tutorials/adobe-cq5-aem-curl-commands/
https://experienceleague.adobe.com/docs/experience-cloud-kcs/kbarticles/KA-17456.html?lang=en
https://experienceleague.adobe.com/docs/experience-manager-65/administering/operations/curl.html?lang=ja
