#! /bin/bash

docker image prune -f

docker logs autobuildnode
docker stop autobuildnode
docker rm autobuildnode

cd /home/project-cli && docker build --force-rm=true -t ct/node-web-app .
docker run --name autobuildnode -v /home/sources:/sources/workspace -p 8888:7777 -d ct/node-web-app