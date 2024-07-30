#!/bin/bash

# Define image and container names
IMAGE_NAME="alpine-ssh"
CONTAINER_NAME="alpine-ssh-container"
HOST_PORT=2222
CONTAINER_PORT=22

# Build the Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME .

# Remove any existing container with the same name
echo "Removing any existing container with the name $CONTAINER_NAME..."
docker rm -f $CONTAINER_NAME

# Run the Docker container
echo "Running Docker container..."
docker run -d --name $CONTAINER_NAME -p $HOST_PORT:$CONTAINER_PORT $IMAGE_NAME

