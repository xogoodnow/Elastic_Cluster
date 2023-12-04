resource "hcloud_network" "elastic-internal" {
  name     = "elastic-internal"
  ip_range = "10.0.0.0/8"

}

resource "hcloud_network_subnet" "elastic-internal-network" {
  network_id   = hcloud_network.elastic-internal.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.0.0/8"
}