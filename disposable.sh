#!/bin/bash

tmpdir=`mktemp -d`
echo $tmpdir

cp -r ./author $tmpdir/
cp -r ./publish $tmpdir/
cp -r ./dispatcher $tmpdir/
cp docker-compose.yml $tmpdir/

cd $tmpdir

cat docker-compose.yml | grep -iE 'image:.*author'  | awk '{print "FROM "$NF}' | tee ./author/Dockerfile
cat docker-compose.yml | grep -iE 'image:.*publish'  | awk '{print "FROM "$NF}' | tee ./publish/Dockerfile
cat docker-compose.yml | grep -iE 'image:.*dispatcher'  | awk '{print "FROM "$NF}' | tee ./dispatcher/Dockerfile

keyword="default-"
addword="`basename $tmpdir | tr '[:upper:]' '[:lower:]'`"
sed -i.back s/"$keyword"/"$keyword${addword}-"/g docker-compose.yml
cat docker-compose.yml

trap "echo 'killing containers' && cd $tmpdir && docker-compose kill && docker-compose rm" ERR EXIT

docker-compose up

