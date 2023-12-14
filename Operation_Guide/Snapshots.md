
<div align="center">
    <h1>Snapshotting On Elastic</h1>

</div>




## Installing s3-repo module on elastic
* Run the following command on every elastic node (container)
``` bash
 bin/elasticsearch-plugin install repository-s3
```


## Add S3 credentials 
* Run the following command on every elastic node (container)
* The commands prompt for access-key and secret-key 
``` bash
 bin/elasticsearch-keystore add s3.client.default.access_key
 bin/elasticsearch-keystore add s3.client.default.secret_key
```

## Restart elastic
* Run the following command on every elastic node (container)
> **Note:**
> When restarting each elastic node (container), wait for te clsuter to become green and then proceed to the other node.

``` bash
 systemctl restart elasticsearch
 or
 docker restart elastic
```


## Registering the s3 repository
* You may run the following request on your elastic to create the registry
* Also you may register registry on kibana through the following path
* Kibana >> Management >> Snapshot and Restore >> Repositories

> **Note:**
> Keep in mind that the bucket must already exist.
> Also each bucket is for one clsuter only and they can not be shared

``` bash
curl -X PUT "localhost:9200/_snapshot/<Repository_Name>" -H "Content-Type: application/json" -d'
{
  "type": "s3",
  "settings": {
    "bucket": "<Bucket_Name>",
    "endpoint": "s3.custom.endpoint"
  }
}'
```

## Set snapshot policy
* You can use the API as below or you may go through kibana to set snapshot policy like the following
* Kibana >> Management >> Snapshot and Restore >> Policies
> **Note:**
> To test if your policy works, you may run the policy on kibana "run policy now" to check if everything works as intended
``` bash
PUT /_slm/policy/<snapshot-lifecycle-policy-name>
{
  "schedule": "0 30 1 * * ?", 
  "name": "<daily-snap-{now/d}>", 
  "master_timeout": "15m",
  "repository": "my_repository", 
  "config": { 
    "indices": ["*", "important"], 
    "ignore_unavailable": false,
    "include_global_state": false
  },
  "retention": { 
    "expire_after": "10d", 
    "min_count": 5, 
    "max_count": 50 
  }
}
```

## Restore snapshot
* Go through your snapshots on kibana and restore any given moment on your clsuter
> **Note:**
> Keep in mind that snapshotting is the only way to back up elastic and there is no other way
> Do not back up a directory on the node. It would be useless.