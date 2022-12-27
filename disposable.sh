#!/bin/bash

tmpdir=`mktemp -d`
tmpdirbasename=`basename $tmpdir | tr '[:upper:]' '[:lower:]'`

get_image_id() {
  docker images | awk '{print $3}' | while read image_id; do
    echo $1 | grep "$image_id" > /dev/null && echo $image_id && return 0
  done
}

docker_tag() {
  docker tag $1 "${tmpdirbasename}_${container_keyword}_${2}"
}

get_docker_tag() {
  echo $1 >&2
  echo "${tmpdirbasename}_${container_keyword}_${2}"
}

run_single_container() {
  echo "Initiating disposable $1" >&2
  local readonly container_id=`docker ps -a | grep $1 | awk '{print $1}'`
  echo "container_id=$container_id" >&2
  local readonly image=`docker ps -a | grep $1 | awk '{print $2}'`
  echo 'docker committing. It may take a while..' >&2
  local readonly commit=$(docker commit $container_id)
  docker_tag `get_image_id $commit` 'disposable'
  local readonly tag=$(get_docker_tag `get_image_id $commit` 'disposable')
  echo $tag
  docker run --rm --network="host" --privileged  --cap-add=NET_ADMIN $tag
  docker rmi "`get_image_id $commit`"
  exit 0
}

readonly container_keyword=$1

if docker ps -a | grep "$container_keyword"  | wc -l | xargs -I{} test {} = 1; then
  run_single_container $container_keyword
  exit 0
fi

docker ps -a | grep "$container_keyword" | grep -iE '(author|publish|dispatcher)' | wc -l | xargs -I{} test {} = 3 || exit 1
docker ps -a | grep "$container_keyword" | grep -iE '(author|publish|dispatcher)' | wc -l | xargs -I{} test {} = 3 || exit 1

readonly author_container_id=$(docker ps -a | grep "$container_keyword" | grep -iE 'author' | awk '{print $1}')
readonly publish_container_id=$(docker ps -a | grep "$container_keyword" | grep -iE 'publish' | awk '{print $1}')
readonly dispatcher_container_id=$(docker ps -a | grep "$container_keyword" | grep -iE 'dispatcher' | awk '{print $1}')

echo $author_container_id
echo $publish_container_id
echo $dispatcher_container_id

test -z $author_container_id && exit 2
test -z $publish_container_id && exit 2
test -z $dispatcher_container_id && exit 2

readonly author_commit=$(docker commit $author_container_id)
readonly publish_commit=$(docker commit $publish_container_id)
readonly dispatcher_commit=$(docker commit $dispatcher_container_id)

docker_tag `get_image_id $author_commit` author
docker_tag `get_image_id $publish_commit` publish
docker_tag `get_image_id $dispatcher_commit` dispatcher

author_tag=$(get_docker_tag `get_image_id $author_commit` author)
publish_tag=$(get_docker_tag `get_image_id $publish_commit` publish)
dispatcher_tag=$(get_docker_tag `get_image_id $dispatcher_commit` dispatcher)

cp -rav ./template/* $tmpdir/
cd $tmpdir

sed -i.back -e "s/{{AUTHOR}}/${author_tag}/g" docker-compose.yml
sed -i.back -e "s/{{REPOSITORY}}/${author_tag}/g" ./author/Dockerfile
sed -i.back -e "s/{{PUBLISH}}/${publish_tag}/g" docker-compose.yml
sed -i.back -e "s/{{REPOSITORY}}/${publish_tag}/g" ./publish/Dockerfile
sed -i.back -e "s/{{DISPATCHER}}/${dispatcher_tag}/g" docker-compose.yml
sed -i.back -e "s/{{REPOSITORY}}/${dispatcher_tag}/g" ./dispatcher/Dockerfile


cat docker-compose.yml
cat ./**/Dockerfile

docker-compose up
docker-compose rm -f

docker rmi "`get_image_id $author_commit`"
docker rmi "`get_image_id $publish_commit`"
docker rmi "`get_image_id $dispatcher_commit`"

exit 0
