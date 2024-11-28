#!/bin/bash

# Kill existing inner_prover processes
pids=$(ps -ef | grep inner_prover | grep -v grep | awk '{print $2}')
if [ -n "$pids" ]; then
    echo "Stopping existing inner_prover processes: $pids"
    echo "$pids" | xargs kill
    sleep 5
fi

# Start inner_prover.sh in the background
echo "Starting inner_prover.sh..."
nohup ./inner_prover.sh >> prover.log 2>&1 &
sleep 2  # Allow some time for the script to initialize

# Check if docker-compose.yml exists in the current directory
if [ ! -f "docker-compose.yml" ]; then
    echo "docker-compose.yml not found in the current directory. Exiting..."
    exit 1
fi

# Start Docker Compose services using the newer syntax
echo "Starting Docker Compose services..."
docker compose up -d

# Check the status of Docker Compose services
echo "Checking Docker Compose services status..."
docker compose ps

echo "All processes have been started."
