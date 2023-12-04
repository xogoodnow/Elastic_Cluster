output "elastic_ips" {
  value = hcloud_server.elastic[*].ipv4_address
}

output "elastic_private_ips" {
  value = hcloud_server.elastic[*].network[*].ip
}

output "monitoring_ips" {
  value = hcloud_server.monitoring[*].network[*].ip
}


output "monitoring_private_ips" {
  value = hcloud_server.monitoring[*].network[*].ip
}

