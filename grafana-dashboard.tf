provider "grafana" {
  url = "https://grafana.egdl-eks-us-east-1.egdp-dev.aws.away.black"
  auth = "admin:admin"
}

resource "grafana_dashboard" "metrics" {
  config_json = file("templates/grafana-dashboard.json")
}