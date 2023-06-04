# Initializing a swarm
docker swarm init

# Joining a swarm as a worker
docker swarm join --token <worker-token> <manager-IP>:<manager-port>

# Joining a swarm as a manager
docker swarm join-token manager

# Creating a service
docker service create --name <service-name> <image-name>

# Updating a service
docker service update --image <new-image-name> <service-name>

# Scaling a service
docker service scale <service-name>=<number-of-replicas>

# Inspecting a service
docker service inspect <service-name>

# Listing services
docker service ls

# Removing a service
docker service rm <service-name>

# Creating a secret
echo "<secret-value>" | docker secret create <secret-name> -

# Listing secrets
docker secret ls

# Inspecting a secret
docker secret inspect <secret-name>

# Removing a secret
docker secret rm <secret-name>

# Creating a configuration
docker config create <config-name> <file-path>

# Listing configurations
docker config ls

# Inspecting a configuration
docker config inspect <config-name>

# Removing a configuration
docker config rm <config-name>

# Deploying a stack
docker stack deploy --compose-file <compose-file-path> <stack-name>

# Listing stacks
docker stack ls

# Inspecting a stack
docker stack ps <stack-name>

# Removing a stack
docker stack rm <stack-name>

# Setting node labels
docker node update --label-add <label-key>=<label-value> <node-name>

# Removing node labels
docker node update --label-rm <label-key> <node-name>

# Draining a node
docker node update --availability drain <node-name>

# Bringing a drained node back online
docker node update --availability active <node-name>

# Promoting a worker node to manager
docker node promote <node-name>

# Demoting a manager node to worker
docker node demote <node-name>

# Listing nodes
docker node ls

# Inspecting a node
docker node inspect <node-name>

# Removing a node
docker node rm <node-name>

# Creating a network
docker network create <network-name>

# Listing networks
docker network ls

# Inspecting a network
docker network inspect <network-name>

# Removing a network
docker network rm <network-name>

# Creating a volume
docker volume create <volume-name>

# Listing volumes
docker volume ls

# Inspecting a volume
docker volume inspect <volume-name>

# Removing a volume
docker volume rm <volume-name>

# Starting a stack deploy
docker stack deploy <stack-name>

# Listing stacks
docker stack ls

# Listing services in a stack
docker stack services <stack-name>

# Listing tasks in a stack
docker stack ps <stack-name>

# Scaling a service in a stack
docker service scale <stack-name>_<service-name>=<number-of-replicas>

# Updating a service in a stack
docker service update <stack-name>_<service-name> --image <new-image-name>

# Removing a stack
docker stack rm <stack-name>

# Creating an overlay network
docker network create --driver overlay <network-name>

# Listing overlay networks
docker network ls --filter driver=overlay

# Creating a secret for a service
echo "<secret-value>" | docker secret create <secret-name> -

# Deploying a service with a secret
docker service create --name <service-name> --secret <secret-name> <image-name>

# Creating a config for a service
docker config create <config-name> <file-path>

# Deploying a service with a config
docker

