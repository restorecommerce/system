#!/bin/bash

export RESTART=${RESTART:-always}
source .env
docker compose -f restoreservices-docker-compose.yml --profile backing $@
