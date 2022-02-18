#!/bin/bash
set -e 

echo "building jenkins-iac image ..."
docker build --tag jenkins-iac .
echo "Done"

echo "running dind and jenkins-iac containers ..."
docker-compose up -d 
echo "Done"