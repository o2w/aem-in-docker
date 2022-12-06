#!/bin/bash

mkdir -p custom/$1

cp -rav ./author custom/$1/
cp -rav ./publish custom/$1/
cp -rav ./dispatcher custom/$1/
cp -avu ./docker-compose.yml custom/$1/
cp -avu ./disposable.sh custom/$1/
cp -avu ./install_packages.sh custom/$1/

cd custom/$1/
sed -i.back -e  's|default\-|'"${1}"'\-|g' ./disposable.sh
sed -i.back -e  's|default\-|'"${1}"'\-|g' ./docker-compose.yml
