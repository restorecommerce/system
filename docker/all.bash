#!/bin/bash

source .default.env
source .env
docker compose -f backingservices-docker-compose.yml -f restoreservices-docker-compose.yml $@
