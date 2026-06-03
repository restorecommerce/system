#!/bin/bash

export ENV_FILE='.default.env'
export NODE_ENV='production'
export RESTART=${RESTART:-unless-stopped}
source .env
docker compose -f restoreservices-docker-compose.yml $@
