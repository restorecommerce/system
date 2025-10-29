# Docker

Resources are collected here related to launch a
[Restorecommerce](https://github.com/restorecommerce) system using
Docker Compose.

## Prerequisites

- [`docker`](https://docs.docker.com/)
- [`docker compose`](https://docs.docker.com/compose/)

## Complete System

A complete system can be launched with:

```sh
./all.bash up -d
```

where `-d` stands for detached mode.

Stopped with:

```sh
./all.bash stop
```

### Optional, the system can be lauched with a project prefix:

```sh
./all.bash -p [PROJECT_PREFIX] up -d
```

where `-d` stands for detached mode.

Stopped with:

```sh
./all.bash -p [PROJECT_PREFIX] stop
```

To remove all containers (except volumes):

```sh
./all.bash rm
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
- [Elasticsearch/ Kibana](https://www.elastic.co/)
- [Cloudserver](https://www.zenko.io/cloudserver/)

These can be launched with:

```sh
./backing.bash up -d
```

where `-d` stands for detached mode.

Stopped with:

```sh
./backing.bash stop
```

To remove backing containers (except volumes):

```sh
./backing rm
```

To remove **all** volumes (delete the data):

```sh
docker volume prune
```

## Configuration

Create a file named `.env` in `system/docker/`.
Copy the following section into your personal `.env` file and set your preferences and credentials for:

```sh
# General
ENV_FILE='.env'
RESTART=always #Enable or disable automatic restart of all services (always/no)

# Service Config
logger__console__level=silly #Overrides the log level of all services (silly/debug/verbose/warn/error/crit)
redis__offsetStoreInterval=15000

# Fulfillment Service
defaults__Couriers__DHLRest__configuration__value__ordering__username='user-valid' #For sandbox
defaults__Couriers__DHLRest__configuration__value__ordering__password='SandboxPasswort2023!' #For sandbox
defaults__Couriers__DHLRest__configuration__value__ordering__client_id='' #Set your DHL account information here
defaults__Couriers__DHLRest__configuration__value__ordering__client_secret='' #Set your DHL account information here
defaults__Couriers__DHLRest__configuration__value__tracking__username='' #Set your DHL account information here
defaults__Couriers__DHLRest__configuration__value__tracking__password='' #Set your DHL account information here
defaults__Couriers__DHLRest__configuration__value__tracking__client_id='' #Set your DHL account information here
defaults__Couriers__DHLRest__configuration__value__tracking__client_secret='' #Set your DHL account information here

# Notification Service
server__mailer__host='' #Set your mail server information here
server__mailer__port='' #Set your mail server information here
server__mailer__auth__user='' #Set your mail server information here
server__mailer__auth__pass='' #Set your mail server information here
server__mailer__tls__rejectUnauthorized='' #Set your mail server information here
server__mailer__address='' #Set your mail server information here
```


## Troubleshooting

In case the ElasticSearch container suddenly stops, just add `vm.max_map_count=262144` to your
`/etc/sysctl.conf` file and reload the configuration file with:

```sh
sudo sysctl -p
```
