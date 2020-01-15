//add ocunt to not create paid metrics when not desired


//variable "apiary_data_buckets" {
//  type = "list"
//  default = [
//    { bucket1 = "egsp-kafkaconnect" },
//    { bucket2 = "lz-egsp" },
//    { bucket3 = "s3-inventory" },
//  ]
//}

data "template_file" "graphs" {
  template = file("${path.module}/templates/graph.tpl")
  count = length(local.apiary_data_buckets)
  vars = {
    bucket_name = local.apiary_data_buckets[count.index]
    title_bucket_name = local.apiary_managed_schema_names_replaced[count.index]
    graph_id = range(0, length(local.apiary_data_buckets) * 2, 2)[count.index]
  }
}

data "template_file" "dashboard" {
  template = file("${path.module}/templates/dashboards.tpl")
  vars = {
    panels = "[${join(",", data.template_file.graphs.*.rendered)}]"
  }
}

//resource "local_file" "print_dashboard" {
//  content = data.template_file.dashboard.rendered
//  filename = "/Users/zporobic/eg/zpor/apiary-data-lake/template-test/dashboard-rendered.tpl"
//}

output "grafana-graph-358" {
  value = data.template_file.dashboard.rendered
}

resource "kubernetes_config_map" "grafana-dashboard" {
  metadata {
    name = "tf-generated-dashboard"
    namespace = "monitoring"
    labels = {
      grafana_dashboard="true"
    }
  }

  data = {
    "dashboard-test.json" = data.template_file.dashboard.rendered
  }
}
