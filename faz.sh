echo Vai apagar TODOS os containers ...
echo '^C para cancelar'
read

docker ps -a | grep -v IMAGE | awk '{print $1}'|  xargs  -r -n1 docker stop
docker ps -a | grep -v IMAGE | awk '{print $1}'|  xargs  -r -n1 docker rm
docker images | grep -i 'ws\|none' | awk '{print $3}'|  xargs  -r -n1 docker rmi

docker-compose build wsbb
docker-compose run --name wsbb wsbb 
