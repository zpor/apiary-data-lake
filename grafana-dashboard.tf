resource "kubernetes_config_map" "grafanadashboard" {
 metadata {
  name = "z-dashboard"
 }

 data = {
  config = "${path.module}/templates/grafana-dashboard.json"
 }
}