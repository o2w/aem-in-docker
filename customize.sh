#!/bin/bash

mkdir -p custom/$1

cp -rav ./author custom/$1/
cp -rav ./publish custom/$1/
cp -rav ./dispatcher custom/$1/
cp -avu ./docker-compose.yml custom/$1/
cp -avu ./disposable.sh custom/$1/

cd custom/$1/
sed -e -i '.bak' "s|default\-|${1}\-|g" ./disposable.sh
sed -e -i '.bak' "s|default\-|${1}\-|g" ./docker-compose.yml
