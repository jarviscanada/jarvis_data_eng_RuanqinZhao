#! /bin/sh

#capture CLI arguments
cmd=$1
db_username=$2
db_password=$3

#Start docker
#start docker if docker server is not running
sudo systemctl status docker || sodu systemctl start docker

# check container status(try the following cmds on terminal)
inspect_info=$(docker container inspect jrvs-psql)
container_status=$(echo "$inspect_info" | egrep "Status" | awk '{print $2}' | cut -f1 -d"," | xargs)

#User switch case to handle create|stop|start options
case $cmd in
  create)

    #check if the container is already created
    if [ "$container_status" == "running" ] || [ "$container_status" == "exited" ]; then
      echo 'Container already exists'
      exit 1
    fi

    #check number of CLI arguments
    if [ $# -ne 3 ]; then
      echo 'Create requires username and password'
      exit 1
    fi

    #Create container
    #create a new volume if not exist
    docker volume create pgdata
    #create a container using psql image with name=jrvs-psql
    docker run --name jrvs-psql -e POSTGRES_PASSWORD="${db_password}" -e POSTGRES_USER="${db_username}" -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine
    exit 0
    ;;

  start|stop)
  #check instance status; exit 1 if container has not been created
  if [ "$container_status" == "" ]; then
    echo 'Container not exist'
    exit 1
  fi

  #Start or stop the container
  docker container $cmd jrvs-psql
  exit 0
  ;;

  *)
  echo 'Illegal command'
  echo 'Commands: start|stop|create'
  exit 1
  ;;
esac




