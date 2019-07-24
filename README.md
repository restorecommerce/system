# System

## Running


The System repository contains a minimal docker compose file needed for running the [restorecommerce](https://github.com/restorecommerce) microservices tests.
This spins up an instance of [Apache Kafka](https://kafka.apache.org/), [Redis](https://redis.io/), [AranagoDB](https://www.arangodb.com/) and [ZooKeeper](https://zookeeper.apache.org/).

To start the backing services execute below command:

```
docker-compose -f backingservices-docker-compose.yml up
```

<small>*Note: this requires you to have [`docker-compose`](https://docs.docker.com/compose/) installed, which comes in a separate package from `docker`*</small>

To stop backing services execute below command:

```
docker-compose -f backingservices-docker-compose.yml down
```
