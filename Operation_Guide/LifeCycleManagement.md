<div align="center">
    <h1>Lifecycle Management On Elastic</h1>

</div>




## Creating a new lifecycle policy
### Step 1:
* Go throught the following path and hit "Create Policy"
* Kibana >> Management >> Index Lifecycle Policies

### Step 2:
> **Note:**
> Keep in mind that we have 3 data tiers 
>> Hot Phase: Usually for newly indexed data which is going to be queried and used in near future
> 
>> Warm Phase: Usually for data which is not being queried as much but still might be used in the future
> 
>> Cold Phase: Data which is not going to be queried but it would be better to keep it rather than removing it completely (Searchable snapshots are a good example for cold tier data storage)
* In this section you can enable warm and cold phase (if both are needed) and then just hit "Create Policy"
  * Keep in mind that you must set the number of days after which the index would be transferred to another data tier

### Points to consider on each data tire

#### Hot:
In advanded setting:
* Rollover: The smaller the indices (reasonable), the better elastic would be able to rebalance the whole thing. So you can set a policy to keep the size of your indidec sizes in check.
  * For example you can set that if an indice grows larger than a certain size, the data (up to that point) would be saved into another indice.
  * This policy requires the indice to have an alias
  * Keep the index priority of hot data to the highest on cluster so when the recovery is happening the hot data would be rcovered faster (100 by default)

#### Cold:
In advanced setting:
* Set the number of replicas to 1 (the data is not worth the storage cost)
* Make the index read only so it would not be tempered with

### Step 3:
* Go throught the following path and hit "Create Template"
* Kibana >> Management >> Index Management >> Index Templates
  * Now set a name for the template
  * Using wild cards, define the template for your indexes ("Index patterns")
  * You may hit next till the template is created :) (the reset is optional)

### Step 4: 
* Go throught the following path 
* Kibana >> Management >> Index Lifecycle Policies
* On the right side of your policy, there is a delete and add button. Click on the add button ("Add policy to index template")
* Select your desired template and add the policy to it.

### Step 5: 
* To confirm your policy has been added properly:
  * Go through the follwoing path
  * Kibana >> Management >> Index Management
  * Click on one of the indexes
  * There should be a field called "Index lifecycle management" that shows everything about the policy which is controlling this index