#!/bin/bash

docker build -t aem6.5.0 ./aem6.5.0
docker build -t default-auther ./author
docker build -t default-publish ./publish
docker build -t default-dispatcher ./dispatcher
