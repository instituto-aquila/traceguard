#!/bin/bash

cd ../

docker stop $(docker ps --filter ancestor=traceguard-app -q)

docker-compose up -d --build