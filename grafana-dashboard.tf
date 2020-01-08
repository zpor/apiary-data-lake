resource "kubernetes_consdafasdffig_map" "grafana-dashboard" {
 metadata {
  name = "z-dashboard"
  labels = {
   grafana_dashboard=true
   "grafana_dashboard"=true
  }
 }

 data = {
  config = file("${path.module}/templates/grafana-dashboard.json")
 }
}