#!/bin/bash

cd ../

docker stop traceguard-app-1

docker-compose up -d --build