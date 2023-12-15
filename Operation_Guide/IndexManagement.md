
<div align="center">
    <h1>Elasticsearch Index Management Guide</h1>
</div>


## Index Relocation
Relocating an index involves moving shards from one node to another. This might be necessary for load balancing or maintenance.

### Manual Shard Relocation
To manually relocate shards, use the Cluster Reroute API:
```bash
POST /_cluster/reroute
{
  "commands": [
    {
      "move": {
        "index": "<index_name>", "shard": <shard_number>,
        "from_node": "<source_node>", "to_node": "<target_node>"
      }
    }
  ]
}
```
Replace `<index_name>`, `<shard_number>`, `<source_node>`, and `<target_node>` with your specific details.

## Index Rebalancing
Rebalancing is the process of evenly distributing data across the cluster.

### Enable/Disable Shard Allocation
Shard allocation needs to be managed during rebalancing:
```bash
# Disable shard allocation
PUT /_cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.enable": "none"
  }
}

# Enable shard allocation
PUT /_cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.enable": "all"
  }
}
```

## Deleting an Index
To delete an index, use the Delete Index API:
```bash
DELETE /<index_name>
```
Replace `<index_name>` with the name of the index you want to delete.

> **Warning:**
> Deleting an index is irreversible. Make sure you have a backup or snapshot if needed.

## Additional Index Management Operations

### Index Settings Update
Update settings of an index:
```bash
PUT /<index_name>/_settings
{
  "index": {
    "<setting_name>": "<new_value>"
  }
}
```

### Index Health Check
Monitor the health of an index:
```bash
GET /<index_name>/_health
```

### Index Templates
Use index templates to define settings and mappings that will automatically apply to new indices:
```bash
PUT /_index_template/<template_name>
{
  "template": {
    "settings": { ... },
    "mappings": { ... }
  }
}
```

### Index Lifecycle Management (ILM)
Automate index lifecycle management with ILM policies:
```bash
PUT /_ilm/policy/<policy_name>
{
  "policy": {
    "phases": {
      "hot": { ... },
      "warm": { ... },
      "cold": { ... },
      "delete": { ... }
    }
  }
}
```

> **Note:**
> - Always ensure your cluster health is green before and after performing index management tasks.
> - Adjust configurations and commands according to your specific Elasticsearch setup and version.
