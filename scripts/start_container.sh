#!/bin/bash
set -e

# Define constants
DOCKER_IMAGE="sahil3105/simple-python-flask-app"
CONTAINER_NAME="my-flask-app"
HOST_PORT=5000
CONTAINER_PORT=5000

# Pull the latest Docker image from Docker Hub
echo "Pulling latest Docker image: $DOCKER_IMAGE"
docker pull $DOCKER_IMAGE

# Stop and remove any existing container with the same name (if exists)
if docker ps -a --format '{{.Names}}' | grep -Eq "^$CONTAINER_NAME\$"; then
    echo "Stopping existing container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
    echo "Removing existing container: $CONTAINER_NAME"
    docker rm $CONTAINER_NAME
fi

# Run the Docker container
echo "Starting new container: $CONTAINER_NAME"
docker run -d -p $HOST_PORT:$CONTAINER_PORT --name $CONTAINER_NAME $DOCKER_IMAGE

# Wait for a few seconds to ensure container is up
sleep 5

# Check if the container is running
if docker ps -a --format '{{.Names}}' | grep -Eq "^$CONTAINER_NAME\$"; then
    echo "Container $CONTAINER_NAME started successfully."
else
    echo "Container $CONTAINER_NAME failed to start."
    exit 1
fi
