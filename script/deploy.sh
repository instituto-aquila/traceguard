#!/bin/bash

cd ../

docker stop traceguard-app-1

docker-compose -f /home/ubuntu/repo/traceguard/docker-compose.yml up -d --build