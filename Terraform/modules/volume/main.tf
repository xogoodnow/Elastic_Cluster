
data "hcloud_server" "elastic" {
  count = 3
  name = "elastic-${count.index}"

}

resource "hcloud_volume" "elastic_volumes" {
  count = length(data.hcloud_server.elastic)
  name  = "elastic-${count.index}-volume"
  size  = 200
  server_id = data.hcloud_server.elastic[count.index].id
}