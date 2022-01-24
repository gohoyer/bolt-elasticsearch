#! /bin/bash

sleep_time=5
package_version=$1

# Disable shard allocation
curl -s -X PUT "http://$(hostname -f):9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d'
{
  "transient": {
    "cluster.routing.allocation.enable": "primaries"
  }
}
'

# Sync Flush
curl -X POST "http://$(hostname -f):9200/_flush/synced?pretty"

# Stop the service
systemctl stop elasticsearch

# Upgrade the package
yum install elasticsearch-$package_version

# Start the service
systemctl start elasticsearch

# Wait for the node to respond again
until curl -s http://$(hostname -f):9200/_cluster/health?pretty; do
  echo "Waiting for node $(hostname -f) to get back..."
  sleep $sleep_time
done

# Enable shard allocation
curl -s -X PUT "http://$(hostname -f):9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d'
{
  "transient": {
    "cluster.routing.allocation.enable": "all"
  }
}
'

until curl -s http://$(hostname -f):9200/_cluster/health?pretty | grep green; do
  echo "Waiting the cluster get back green..."
  sleep $sleep_time
done