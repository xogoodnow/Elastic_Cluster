resource "hcloud_server" "elastic" {
  count = 3
  name         = "elastic-${count.index}"
  image        = var.image_name
  server_type  = "cpx31"
  ssh_keys = [data.hcloud_ssh_key.key1.id]
  location = var.location
  network {
    network_id = data.hcloud_network.private-network.id
  }

}



resource "hcloud_server" "monitoring" {
  count = 1
  name         = "monitoring-${count.index}"
  image        = var.image_name
  server_type  = "cx21"
  ssh_keys = [data.hcloud_ssh_key.key1.id]
  location = var.location
  network {
    network_id = data.hcloud_network.private-network.id
  }
}


data "hcloud_network" "private-network" {
  name = "elastic-internal"

}


data "hcloud_ssh_key" "key1"  {
  name = "ssh_key_bastion"

}



resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tpl",
    {
      elastic_ips = hcloud_server.elastic.*.ipv4_address
      monitoring_ips = hcloud_server.monitoring.*.ipv4_address
    }
  )
  filename = "${path.module}/../../inventory.yaml"
}


resource "local_file" "etc-hosts" {
  content  = templatefile("${path.module}/etchost.tpl",
    {
      elastic_0_private_ips = hcloud_server.elastic.0.network[*].ip
      elastic_1_private_ips = hcloud_server.elastic.1.network[*].ip
      elastic_2_private_ips = hcloud_server.elastic.2.network[*].ip
      elastic_ips = hcloud_server.elastic.*.ipv4_address
      monitoring_ips = hcloud_server.monitoring.*.ipv4_address
      monitoring_private_ips = hcloud_server.monitoring.0.network[*].ip

    }
  )
  filename = "${path.module}/../../../Ansible/roles/pre_setup/files/etchost.yaml"
}


resource "local_file" "instances" {
  content = templatefile("${path.module}/instances.yaml.tpl",
    {
      elastic_ips = hcloud_server.elastic.*.ipv4_address
      monitoring_ips = hcloud_server.monitoring.*.ipv4_address
    }
  )
  filename = "${path.module}/../../../Ansible/roles/elasticsearch_cert_generation/files/instances.yaml"
}


