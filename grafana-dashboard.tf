locals {
  graph_id_base = 100
  number_of_graphs = 5
}

data "template_file" "grafana_graphs" {
  template = file("${path.module}/templates/grafana_graph.tpl")
  count = length(local.apiary_data_buckets)
  vars = {
    bucket_name = local.apiary_data_buckets[count.index]
    title_bucket_name = local.apiary_managed_schema_names_replaced[count.index]
    graph_id = range(local.graph_id_base, local.graph_id_base + length(local.apiary_data_buckets) * local.number_of_graphs, local.number_of_graphs)[count.index]
    aws_region = data.aws_region.current.name
    y_position = range(1, 10 * length(local.apiary_data_buckets), 10)[count.index]
  }
}

data "template_file" "grafana_dashboard_data" {
  template = file("${path.module}/templates/grafana_dashboards.tpl")
  vars = {
    panels = "[${join(",", data.template_file.grafana_graphs.*.rendered)}]"
  }
}

output "grafana-dashboard" {
  value = data.template_file.grafana_dashboard_data.rendered
}

resource "kubernetes_config_map" "grafana_dashboard" {
  count = var.hms_instance_type == "k8s" ? 1 : 0
  metadata {
    name = "apiary-data-lake-dashboard"
    namespace = "monitoring"
    labels = {
      grafana_dashboard="true"
    }
  }

  data = {
    "dashboard.json" = data.template_file.grafana_dashboard_data.rendered
  }
}