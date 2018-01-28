#!/bin/bash
if [ $(id -u) == 0 ] ; then
  echo Nao vai rodar como root
  echo Adicione seu usuario no grupo docker
  exit 1
fi

if ! ( which docker &>/dev/null && which docker-compose &>/dev/null ) ; then
	echo Faltando dependencias...
	echo
	echo Para instalar o docker use:
	echo \'sudo apt-get install docker.io -y\' em variantes do debian  ou \'sudo yum install -y docker\' em variantes do redhat
	echo Para instalar o docker-compose use:
	echo \'"sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose"\'
	exit 1
fi

docker start wsbb  &>/dev/null || (
docker ps -a  | grep -i 'wsbb' | awk '{print $1}'|  xargs  -r -n1 docker stop
docker ps -a  | grep -i 'wsbb' | awk '{print $1}'|  xargs  -r -n1 docker rm
docker images | grep -i 'wsbb' | awk '{print $3}'|  xargs  -r -n1 docker rmi
docker-compose build wsbb && docker-compose run --name wsbb wsbb && cp -v wsbb.desktop ~/.local/share/applications/
)
