#!/bin/bash

export RESTART='always'
source .env
docker compose -f backingservices-docker-compose.yml $@
