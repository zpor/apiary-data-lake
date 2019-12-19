resource "kubernetes_config_map" "kibana_dashboard" {
 metadata {
   name = "Zs config map"
 }
  data = {
   config = "${path.module}/templates/grafana-dashboard.json"
  }
}