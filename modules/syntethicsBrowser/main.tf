resource "newrelic_synthetics_script_monitor" "synthetics_browser" {
  name = var.name
  type = var.type
  locations_public     = var.locations_public
  period               = var.period //EVERY_6_HOURS
  status               = var.status //DISABLED
  script               = file("${var.folder}/${var.file}")

  runtime_type_version = var.type == "SCRIPT_API" ? "16.10" : var.runtime_type_version == 1 ? "100" : null
  runtime_type         = var.type == "SCRIPT_API" ? "NODE_API" : var.runtime_type_version == 1 ? "CHROME_BROWSER" : null
  script_language      = var.type == "SCRIPT_API" ? "JAVASCRIPT" : var.runtime_type_version == 1 ? "JAVASCRIPT" : null


}


resource "newrelic_synthetics_alert_condition" "synthetics_browser" {
  policy_id = var.policy_id
  name        = var.name
  monitor_id  = newrelic_synthetics_script_monitor.synthetics_browser.id
  runbook_url = ""
}
