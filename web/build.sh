#!/bin/bash

docker rm -f web 
docker build -t pullapantangi/ecomm_web:latest .
docker push pullapantangi/ecomm_web:latest 

docker run -dit --name web --restart always --network robo-shop -p 8000:8080 pullapantangi/ecomm_web:latest 
