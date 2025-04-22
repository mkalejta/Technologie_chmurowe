#!/bin/bash

docker build -t mkalejta/api-server .
docker tag mkalejta/api-server mkalejta/api-server
docker push mkalejta/api-server
