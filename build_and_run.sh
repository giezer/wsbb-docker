#!/bin/bash

if [ $(id -u) == 0 ] ; then
  echo Esse programa nao deve ser executado como root
  exit 1
fi

if ! ( groups $1 | grep docker &>/dev/null) ; then
	echo Voce nao tem permissao para rodar comandos no docker. Se adicione no grupo docker usando:
	echo \'"sudo usermod -aG docker $USER"\' depois deslogue e logue novamente.
	exit 2
fi

if ! which docker &>/dev/null ; then
	echo docker nao esta instalado. Instale usando:
	echo \'sudo apt-get install docker.io -y\' em variantes do ubuntu  ou \'sudo yum install -y docker.ce\' em variantes do CentOS
	exit 3
fi

if ! which docker-compose &>/dev/null  ; then
	echo docker-compose nao instalado. Instale usando:
	echo \'"sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose"\'
	exit 4
fi

docker start wsbb  &>/dev/null || (
docker ps -a  | grep -i 'wsbb' | awk '{print $1}'|  xargs  -r -n1 docker stop
docker ps -a  | grep -i 'wsbb' | awk '{print $1}'|  xargs  -r -n1 docker rm
docker images | grep -i 'wsbb' | awk '{print $3}'|  xargs  -r -n1 docker rmi
docker-compose build wsbb && docker-compose run --name wsbb wsbb && cp -v wsbb.desktop ~/.local/share/applications/
)
