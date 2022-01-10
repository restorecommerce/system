# Docker

Resources are collected here related to launch a
[Restorecommerce](https://github.com/restorecommerce) system using
Docker Compose.

## Prerequisites

- [`docker`](https://docs.docker.com/)
- [`docker-compose`](https://docs.docker.com/compose/)

## Complete System

A complete system can be launched with:

```sh
./all up
```
...stopped with:

```sh
./all stop
```

To remove all containers (except volumes):

```sh
./all rm
```

To remove **all** volumes (delete the data):

```sh
docker volume prune
```

## Backing Services

The backing services for a Restorecommerce system comprise:

- [Apache Kafka](https://kafka.apache.org/)
- [Redis](https://redis.io/)
- [ArangoDB](https://www.arangodb.com/)
- [ZooKeeper](https://zookeeper.apache.org/).

These can be launched with:

```sh
./backing up
```
...stopped with:

```sh
./backing stop
```

To remove backing containers (except volumes):

```sh
./backing rm
```

To remove **all** volumes (delete the data):

```sh
docker volume prune
```

## Troubleshooting

In case the ElasticSearch container suddenly stops, just add `vm.max_map_count=262144` to your 
`/etc/sysctl.conf` file and reload the configuration file with:

```sh
sudo sysctl -p
```
