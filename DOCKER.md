# Docker

Resources are collected here related to running an orchestration of the various [restorecommerce](https://github.com/restorecommerce) services and their backing services (dependent services).

## Prerequisites

This requires Docker and [`docker`](https://docs.docker.com/) and [`docker-compose`](https://docs.docker.com/compose/) to be installed.

## Backing Services

The backing services for a Restore Commerce system comprise:

- [Apache Kafka](https://kafka.apache.org/)
- [Redis](https://redis.io/)
- [AranagoDB](https://www.arangodb.com/) 
- [ZooKeeper](https://zookeeper.apache.org/).

These can be started with:

```sh
docker-compose -f backingservices-docker-compose.yml up
```

...and stopped:

```sh
docker-compose -f backingservices-docker-compose.yml down
```
