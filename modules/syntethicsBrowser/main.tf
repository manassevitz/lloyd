resource "newrelic_synthetics_script_monitor" "synthetics_browser" {
  name = var.name
  type = "SCRIPT_BROWSER"
  locations_public     = var.locations_public
  period               = var.period //EVERY_6_HOURS
  status               = var.status //DISABLED
  script               = file("${var.folder}/${var.file}")


  runtime_type_version = "100"
  runtime_type         = "CHROME_BROWSER"
  script_language      = "JAVASCRIPT"

}
