# Local AEM Buildup

* Builds set of AEM instances of author, publish, dispatcher based on Docker container
* Can easily build separate sets by projects
* Auto installation of preconfigured packages through scripting

* So each set of instances can be dedicated to project instead of multi tenants in single AEM
* So each set can be reproduced by minmized effort
* So such sets can be more disposable
* So instances can be reproduced from scratch with the latest SDK jar or SP installations, in minmized effort. Especially with Cloud SDK quickstart jar which is recommended to keep updated

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
