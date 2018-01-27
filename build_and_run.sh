#!/bin/bash
docker start wsbb  &>/dev/null || (
docker ps -a  | grep -i 'wsbb' | awk '{print $1}'|  xargs  -r -n1 docker stop
docker ps -a  | grep -i 'wsbb' | awk '{print $1}'|  xargs  -r -n1 docker rm
docker images | grep -i 'wsbb' | awk '{print $3}'|  xargs  -r -n1 docker rmi
docker-compose build wsbb && docker-compose run --name wsbb wsbb && cp -v wsbb.desktop ~/.local/share/applications/
)
