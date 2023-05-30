# Docker Container Commands

## Working with Images

### Pull an image
```
docker pull <image-name>
```

### List all downloaded images
docker images

### Remove an image
docker rmi <image-name>

## Creating and Managing Containers

### Create a container
docker create <image-name>

### Start a container
docker start <container-id/name>

### Stop a container
docker stop <container-id/name>

### Restart a container
docker restart <container-id/name>

### Remove a container
docker rm <container-id/name>

### List all running containers
docker ps

### List all containers including stopped containers
docker ps -a

### Attach to a container
docker attach <container-id/name>

### Exec into a container
docker exec -it <container-id/name> /bin/bash

### Copy files/folders between host and container
docker cp <local-path> <container-id/name>:<container-path>

## Container Logs and Stats

### View container logs
docker logs <container-id/name>

### View real-time logs of a container
docker logs -f <container-id/name>

### Display container statistics
docker stats <container-id/name>

## Container Networking

### List all available networks
docker network ls

### Create a new network
docker network create <network-name>

### Attach a container to a network
docker network connect <network-name> <container-id/name>

### Disconnect a container from a network
docker network disconnect <network-name> <container-id/name>

## Docker Compose

### Start a Docker Compose stack
docker-compose up

### Stop a Docker Compose stack
docker-compose down

### View the status of a Docker Compose stack
docker-compose ps

### View the logs of a Docker Compose stack
docker-compose logs

# Docker Image Commands

## Building Images

### Build an image
docker build -t <image-name> .

### Build an image from a Dockerfile located in a different directory
docker build -t <image-name> -f <path/to/Dockerfile> .

## Pushing and Pulling Images

### Push an image to a registry
docker push <image-name>

### Pull an image from a registry
docker pull <image-name>

## Managing Images

### List all downloaded images
docker images

### Remove an image
docker rmi <image-name>

### Tag an image
docker tag <source-image-name> <target-image-name>

## Docker Registry

### Login to a Docker registry
docker login <registry-url>

### Logout from a Docker registry
docker logout <registry-url>

# Docker Swarm

## Creating and Managing Services

### Create a new service
docker service create <service-name>

### Scale a service
docker service scale <service-name>=<number-of-replicas>

### List all services
docker service ls

### List tasks of a service
docker service ps <service-name>

### Update a service
docker service update <service-name> --image <new-image-name>

### Remove a service
docker service rm <service-name>

## Managing Swarm Nodes

### List all nodes in the swarm
docker node ls

### Update a node in the swarm
docker node update <node-id>

### Remove a node from the swarm
docker node rm <node-id>

## Docker Stack

### Deploy a stack
docker stack deploy -c <path/to/docker-compose.yml> <stack-name>

### Remove a stack
docker stack rm <stack-name>

