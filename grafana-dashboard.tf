provider "grafana" {
  url = "https://grafana.egdl-eks-us-east-1.egdp-dev.aws.away.black"
}

resource "grafana_dashboard" "metrics" {
  config_json = "${file("${path.module}/templates/grafana-dashboard.json")}"
}