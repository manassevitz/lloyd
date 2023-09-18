//variable "name" {}
variable "folder" {}
variable "file" {}

resource "newrelic_one_dashboard_json" "bigRed" {
   json = file("${var.folder}/${var.file}")
}
