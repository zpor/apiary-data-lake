resource "kubernetes_config_map" "grafana-dashboard" {
 metadata {
  name = "z-dashboard"
  labels = {
   grafana_dashboard=true
   "grafana_dashboard"=true
   "grafana_dashboard"="1"
   grafana_dashboard="1"
   grafana_dashboard=1
  }
 }

 data = {
  config = file("${path.module}/templates/grafana-dashboard.json")
 }
}