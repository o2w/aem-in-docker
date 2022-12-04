#!/bin/bash
#https://tailscale.com/learn/ssh-into-docker-container/
docker exec -it "`docker ps | grep aem-author | awk '{print $1}'`" /bin/bash
