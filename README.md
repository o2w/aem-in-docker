# Creating AEM in Docker

* Created Base Image out of Ubuntu Image
* Created Dockerfile Author, Publisher, Dispacher with respective configuration files
* Run `docker-compose up` to create Docker containers running all the AEM instances together  

## Usage

### AEM as a Cloud Service

make init

variables would be set as AEM=acs PROJECT=default-acs


### AEM6.5.0 

make init AEM=6.5.0 PROJECT=default-6.5.0

### AEM6.4.0 

make init AEM=6.4.0 PROJECT=default-6.4.0

# links

https://digitalvarys.com/create-aem-in-docker-with-docker-compose/

# Useful

https://www.aemcq5tutorials.com/tutorials/adobe-cq5-aem-curl-commands/
https://experienceleague.adobe.com/docs/experience-cloud-kcs/kbarticles/KA-17456.html?lang=en
https://experienceleague.adobe.com/docs/experience-manager-65/administering/operations/curl.html?lang=ja
 
