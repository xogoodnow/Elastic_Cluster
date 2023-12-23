
<div align="center">
    <h1>Production Ready Clickhouse Cluster</h1>
    <i>A Clickhouse-cluster implementation for production use</i>

</div>

### Components Used

| Name:Version                  | Documentation                                                                                     | Purpose                                          | Alternatives                      | Advantages                                                                                                                                                                              |
|-------------------------------|---------------------------------------------------------------------------------------------------|--------------------------------------------------|-----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Terraform 1.5.4               | [Docs](https://developer.hashicorp.com/terraform?product_intent=terraform)                        | Hardware Provisioner <br/>Initial Setup          | `Salt` `Ansible`                  | 1. Easy syntax<br/>2. Sufficient community and documentation<br/>3. Much better suited for hardware provisioning                                                                        |
| Hetzner Provider 1.42.1       | [Docs](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs)                   | Deploying servers                                | `Vultr` `DigitalOcean`            | 1. Cheaper :)<br/>2. Good community overlooking provider                                                                                                                                |
| Ansible 2.15.2                | [Docs](https://docs.ansible.com/)                                                                 | Automating Tasks                                 | `Salt`                            | 1. No footprint on target hosts                                                                                                                                                         |
| Ubuntu  22.04                 | [Docs](https://www.google.com/search?client=safari&rls=en&q=ubuntu+image+22.04&ie=UTF-8&oe=UTF-8) | Operating system                                 | `Debian` `Centos`                 | 1. Bigger community<br/>2. Faster releases than debian<br/>3. Bigger community than any other OS<br/>4. Not cash grapping like centos (Yet :))                                          |
| Victoriametrics latest        | [Docs](https://victoriametrics.github.io/)                                                        | Time-series Database                             | `InfluxDB` `Prometheus`           | 1. High performance<br/>2. Cost-effective<br/>3. Scalable<br/>4. Handles massive volumes of data <br/>5. Good community and documentation                                               |
| vmalert latest                | [Docs](https://victoriametrics.github.io/vmalert.html)                                            | Evaluating Alerting Rules                        | `Prometheus Alertmanager`         | 1. Works well with VictoriaMetrics<br/>2. Supports different datasource types                                                                                                           |
| vmagent latest                | [Docs](https://victoriametrics.github.io/vmagent.html)                                            | Collecting Time-series Data                      | `Prometheus`                      | 1. Works well with VictoriaMetrics<br/>2. Supports different data source types                                                                                                          |
| Alertmanager latest           | [Docs](https://prometheus.io/docs/alerting/latest/alertmanager/)                                  | Handling Alerts                                  | `ElastAlert` `Grafana Alerts`     | 1. Handles alerts from multiple client applications<br/>2. Deduplicates, groups, and routes alerts<br/>3. Can be plugged to multiple endpoints (Slack, Email, Telegram, Squadcast, ...) |
| Grafana latest                | [Docs](https://grafana.com/docs/grafana/latest/)                                                  | Monitoring and Observability                     | `Prometheus` `Datadog` `New Relic` | 1. Create, explore, and share dashboards with ease  <br/>2.Huge community and documentation<br/>3. Easy to setup and manage<br/>4. Many out of the box solutions for visualization      |
| Elasticsearch latest          | [Docs](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)                                                                                          | Document based database, Full-text search engine | `Loki` `Mongo`               | 1. Full indexing capability on the content<br/>2. Great community and documentation<br/>3. Production proven                                                                            |
| Nodeexporter latest           | [Docs](https://prometheus.io/docs/guides/node-exporter/)                                          | Hardware and OS Metrics                          | `cAdvisor` `Collectd`             | 1. Measure various machine resources<br/>2. Pluggable metric collectors <br/>3. Basic standard for node monitoing                                                                       |
| Elasticsearch exporter latest | [Docs](https://github.com/prometheus-community/elasticsearch_exporter)                                          | Elastic metrics                                  | `metricbeat`                      | 1. Much easier to setup than metricbeat<br/>2. Easily adoptable for monitoring stack <br/>3. The project has solid place in prometheus-community                                        |
| Kibana   latest               | [Docs](https://www.elastic.co/guide/en/kibana/index.html)                                         | Data visualization tool                          | `Grafana`, `Power BI`             | 1. Perfect integration with Elasticsearch<br/>2. Godd community and documentation <br/>3. Perfect for log analysis whcih is my purpose here (not metric analysis) <br/>                 |
| Docker latest                 | [Docs](https://docs.docker.com/)                                                                  | Application Deployment and Management            | `containerd` `podman`             | 1. Much more bells and wistels are included out of the box comparing to alternatives<br/>2. Awsome community and documentation <br/>3. Easy to work with                                |



## Before you begin
> **Note**
> Each ansible role has a general and a specific Readme file. It is encouraged to read them before firing off
> 
> p.s: Start with the readme file of main setup playbook
* Create an Api on hetzner
* Create a server as terraform and ansible provisioner (Needless to say that ansible and terraform must be installed)
* Clone the project
* In modular_terraform folder create a terraform.tfvars 
    - The file must contain the following variables
      - hcloud_token "APIKEY"
      - image_name = "ubuntu-22.04"
      - server_type = "cpx31"
      - location = "hel1"
* Run terraform init to create the required lock file
* Before firing off, run terraform plan to see if everything is alright
* Run terraform apply
* Go Drink a cup of coffe and come back in 10 minutes or so (Hopefully everything must be up and running by then (: )


## Known issues
* No automation for scaling or maintenance (after the initial set up)
* Terraform is limited to Hetzner
* Grafana datasource must be set manually <http://IP_ADDRESS_:8428>




## Work flow
* Run the following command for terraform to install dependencies and create the lock file
``` bash
terraform init
```
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangelastic/elastic_clsuter_terraform_init.gif)


* Run the following command and check if there are any problems with terraform
``` bash
terraform plan
```
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangelastic/Elastic_Cluster_Terraform_Plan.gif)

* Apply terraform modules and get started
``` bash
terraform apply
```
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangelastic/elastic_cluster_terraform_apply.gif)


* Check if kibana works and elastic indices are created as intended
> **Note**
> Keep in mind that in this demo, a sample data is being routed to elastic for demonstration purpose
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangelastic/elastic_cluster_kibana_works.gif)


* Check if snapshotting and index life cycle works (SLM and ILM)

> **Note**
> Keep in mind that in Operation guide section of this project you can see every step for setting up SLM and ILM
> 
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangelastic/elastic_cluster_snapshotting_works.gif)


* Check if snapshots are properly stored in the bucket
> **Note**
> Seeing if the cluster is properly using the s3 bucket which has been set as the repository for snapshots

![image](https://s3.ir-thr-at1.arvanstorage.ir/kangelastic/elasrtic_cluster_s3_content.png)



* Checking the monitoring stack
> **Note**
> All dashboard are provisioned 
> To add custom dashbaord on load, add it to /Ansible/roles/Victoria_Metrics/files/Grafana/provisioning/dashboards as a .json file. It would automatically be loaded to Grafana
> Just keep in mind that you have to also copy the dashbaord using ansible to the remote destination
>
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangelastic/elastic_cluster_grafana_works.gif)


* To Clean up everything (including the nodes themselvs)
``` bash
terraform destroy
```
![image](http://s3.ir-thr-at1.arvanstorage.ir/kangelastic/elastic_cluster_terraform_destroy.gif)






