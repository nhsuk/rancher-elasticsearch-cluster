# ElasticSearch on Rancher

> Rancher configuration for running an Elasticsearch cluster

## Services deployed:

- *es-master*: Elasticsearch nodes, part of the Elasticsearch cluster, one runs on every host that has an `escluster=true` tag defined.
- *es-sysctl*: Rancher Sidekick service, which updates the sysctl value for `vm.max_map_count` on the hosts running Elasticsearch. See [rawmind/alpine-sysctl].
- *es-client*: Rancher cattle DNS service, which points the `es-client` domain name to `es-master`, for backwards compatibility with existing services.
- *es-exporter*: Justwatch [Exporter] - Exposes Prometheus metrics on the cluster status.

## Deployment

Deployment is driven by [Travis] (Dev and PR review deployments) and TeamCity (staging and production deployments). We use the NHS.UK [CI-Deployment] repo for deployment to the Rancher environment, this sets the following ENV variables.

## Environment variables

| Variable | Description | Default | 
| -------- | ----------- | ------- |
| `ES_MIN_MASTER_NODES` | The minimum nodes required to run the cluster | `2` |
| `ES_DATA_VOL` | The name of the local volume on the host to use | `esdata` |

## How it works

The number of containers running is determined by the number of hosts that have the `escluster` flag set in the Rancher environment. The minimum number should be `3`.

When the containers start they do a DNS A record lookup for `es-master` to get the current hosts in the cluster, ElasticSearch uses this information to build the cluster and for communication.

## How to use the cluster

The cluster is currently setup to only be available inside of the Rancher environment, so your application will have to be deployed to that environment also.

After the application is deployed, you can access the cluster by using the domain name `es-client.elasticsearch-cluster` as the Elasticsearch host.

   [Rancher]: <https://rancher.com/>
   [ElasticSearch]: <https://www.elastic.co/>
   [Exporter]: <https://github.com/justwatchcom/elasticsearch_exporter>
   [Ci-Deployment]: <https://github.com/nhsuk/ci-deployment>
   [rawmind/alpine-sysctl]: <https://hub.docker.com/r/rawmind/alpine-sysctl/>
   [Travis]: <https://travis-ci.org/nhsuk/rancher-elasticsearch-cluster>
