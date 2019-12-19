resource "kubernetes_config_map" "grafana-dashboard" {
 metadata {
  name = "z-dashboard"
 }

 data = {
  config = "${path.module}/templates/grafana-dashboard.json"
 }

 labels = {
  "grafana_dashboard"=true
 }
}