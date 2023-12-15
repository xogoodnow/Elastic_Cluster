
<div align="center">
    <h1>Graceful Shutdown of Elasticsearch Node for Maintenance</h1>
</div>


## Pre-Shutdown Preparation

### Disable Shard Allocation
Prevent Elasticsearch from rebalancing shards during the shutdown process.
```bash
curl -X PUT "localhost:9200/_cluster/settings" -H "Content-Type: application/json" -d'
{
  "persistent": {
    "cluster.routing.allocation.enable": "none"
  }
}'
```

### Perform a Synced Flush (Optional)
Speed up shard recovery upon node restart. This step is optional but recommended.
```bash
curl -X POST "localhost:9200/_flush/synced"
```

## Shutting Down the Node

### Stop the Elasticsearch Docker Container
Gracefully stop the Elasticsearch service in the Docker container.
```bash
docker stop <container_name>
```
Replace `<container_name>` with your Elasticsearch container's name.

### Perform Maintenance
Conduct your required maintenance activities now that the node is safely shut down.

## Post-Maintenance Steps

### Restart the Elasticsearch Node
Once maintenance is complete, restart the Elasticsearch Docker container.
```bash
docker start <container_name>
```

### Re-enable Shard Allocation
Allow the cluster to rebalance and allocate shards again.
```bash
curl -X PUT "localhost:9200/_cluster/settings" -H "Content-Type: application/json" -d'
{
  "persistent": {
    "cluster.routing.allocation.enable": "all"
  }
}'
```

### Monitor Cluster Health
Check the cluster’s health and ensure it returns to a green state.
```bash
curl -X GET "localhost:9200/_cluster/health?wait_for_status=green&timeout=50s"
```

> **Note:**
> - Ensure that each step is successful before proceeding to the next.
> - Adjust timings and settings according to your cluster configuration and size :).
