# Docker

Resources are collected here related to launch a
[Restorecommerce](https://github.com/restorecommerce) system using Docker.

## Prerequisites

- [`docker`](https://docs.docker.com/)
- [`docker-compose`](https://docs.docker.com/compose/)

## Complete System

TODO

## Backing Services

The backing services for a Restorecommerce system comprise:

- [Apache Kafka](https://kafka.apache.org/)
- [Redis](https://redis.io/)
- [AranagoDB](https://www.arangodb.com/)
- [ZooKeeper](https://zookeeper.apache.org/).

These can be started with:

```sh
docker-compose -f backingservices-docker-compose.yml up
```

...and stopped with:

```sh
docker-compose -f backingservices-docker-compose.yml down
```
