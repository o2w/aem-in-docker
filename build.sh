#!/bin/bash

docker build -t aem-base-image ./aem-base-image
docker build -t default-auther ./author
docker build -t default-publish ./publish
docker build -t default-dispatcher ./dispatcher
