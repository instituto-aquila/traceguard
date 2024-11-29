#!/bin/bash

cd ../

docker stop traceguard-app-1

docker-compose -f docker-compose.yml up -d --build