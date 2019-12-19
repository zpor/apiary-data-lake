resource "kubernetes_config_map" "kibana_dashboard" {
 metadata {
   name = "Zs-grafana-dashboard"
 }
  data = {
   config = "${path.module}/templates/grafana-dashboard.json"
  }
}