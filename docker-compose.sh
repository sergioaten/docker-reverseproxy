#!/bin/bash

#Load variables from .env file
source .env
#Copy sites base file to sites
cp -r sites-base/. sites/ 
#Replace the hostname in the site base file
sed -i "s/#PY_HOSTNAME#/${APP_HOSTNAME}/g" sites/default
#Docker compose
docker compose up -d