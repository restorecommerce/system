#!/bin/bash

export NODE_ENV=production
docker compose -f backingservices-docker-compose.yml -f restoreservices-docker-compose.yml $@
