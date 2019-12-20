resource "kubernetes_config_map" "grafana-dashboard" {
 metadata {
  name = "z-dashboard"
  namespace = "monitoring"
  labels = {
   grafana_dashboard=true
  }
 }

 data = {
  "dashboard-test.json" = file("${path.module}/templates/grafana-dashboard.json")
 }
}