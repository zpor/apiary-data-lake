//add ocunt to not create paid metrics when not desired

resource "random_integer" "graph_id" {
  min     = 1
  max     = 50000
}

//variable "apiary_data_buckets" {
//  type = "list"
//  default = [
//    { bucket1 = "egsp-kafkaconnect" },
//    { bucket2 = "lz-egsp" },
//    { bucket3 = "s3-inventory" },
//  ]
//}

data "template_file" "graphs" {
  template = "${file("${path.module}/templates/graph.tpl")}"
  count = "${length(local.apiary_data_buckets)}"
  vars = {
    bucket_name = "${local.apiary_data_buckets[count.index]}"
    graph_id = "${range(0, length(local.apiary_data_buckets) * 2, 2)[count.index]}"
  }
}

data "template_file" "dashboard" {
  template = "${file("${path.module}/templates/dashboards.tpl")}"
  vars = {
    panels = "[${join(",", data.template_file.graphs.*.rendered)}]"
  }
}

//resource "local_file" "print_dashboard" {
//  content = data.template_file.dashboard.rendered
//  filename = "/Users/zporobic/eg/zpor/apiary-data-lake/template-test/dashboard-rendered.tpl"
//}

output "grafana-graph2" {
  value = data.template_file.dashboard.rendered
}