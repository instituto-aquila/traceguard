#!/bin/bash

cd home/ubuntu/repo/traceguard/

docker stop $(docker ps --filter ancestor=traceguard-app -q)

docker-compose -f docker-compose.yml up -d --build