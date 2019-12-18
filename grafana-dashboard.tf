provider "grafana" {
  url = "http://localhost:3000"
  auth = "admin:admin"
}

resource "grafana_dashboard" "metrics" {
  config_json = file("grafana-dashboard.json")
}