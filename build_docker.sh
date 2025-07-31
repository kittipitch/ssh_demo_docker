#!/bin/bash

echo "Bringing up container using docker-compose..."
docker-compose up -d --build

echo "Container started with fixed IP 172.20.0.100"

