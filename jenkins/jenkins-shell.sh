# Stop the existing container with the same name
docker stop <container_name> || true
docker rm <container_name> || true

# Remove the existing image with the same name
docker rmi <image_name> || true

# Build and run the new container
docker build -t <image_name> .
docker run --name <container_name> -d <image_name>
