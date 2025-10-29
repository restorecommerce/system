#!/bin/bash

export ENV_FILE='.default.env'
export NODE_ENV='production'
export RESTART='always'
source .env
docker compose -f backingservices-docker-compose.yml -f restoreservices-docker-compose.yml $@
