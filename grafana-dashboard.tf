resource "kubernetes_config_map" "grafana-dashboard" {
 metadata {
  name = "z-dashboard"
  labels = {
   grafana_dashboard=true
   "grafana_dashboard"=true
  }
 }

 data = {
  config = "${path.module}/templates/grafana-dashboard.json"
 }
}