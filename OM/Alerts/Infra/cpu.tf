resource "newrelic_nrql_alert_condition" "prd_cpupercent_MO_critical" {
  account_id = var.account_id
  policy_id = newrelic_alert_policy.custom_nrql.id
  type = "static"
  name = "PRD | CPU"

  description = <<-EOT
  Description
  EOT

  enabled = true
  violation_time_limit_seconds = 86400

  nrql {
    query = "SELECT average(host.cpuPercent) AS 'CPU used %' FROM Metric WHERE `entity.name` like 'xxxx%' facet entity.name"
  }

  critical {
    operator = "above"
    threshold = 90
    threshold_duration = 600
    threshold_occurrences = "at_least_once"
  }

  warning {
    operator = "above"
    threshold = 70
    threshold_duration = 300
    threshold_occurrences = "at_least_once"
  }

  fill_option = "none"
  aggregation_window = 300
  aggregation_method = "event_flow"
  aggregation_delay = 180
}
