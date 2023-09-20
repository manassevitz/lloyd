
# Alert Policies

resource "newrelic_alert_policy" "synthetics_policy" {
  name                = "Synthetics Violations"
  incident_preference = "PER_CONDITION_AND_TARGET"
}

resource "newrelic_nrql_alert_condition" "ping_monitor_failure_condition" {
  account_id                   = var.account_id
  policy_id                    = newrelic_alert_policy.synthetics_policy.id
  type                         = "static"
  name                         = "Ping Monitor Failures"
  enabled                      = true
  violation_time_limit_seconds = 259200

  nrql {
    query = "SELECT uniqueCount(location) from SyntheticCheck where result != 'SUCCESS' AND typeLabel = 'Ping' FACET monitorName"
  }

  critical {
    operator              = "above_or_equals"
    threshold             = 2
    threshold_duration    = 300
    threshold_occurrences = "all"
  }
  fill_option        = "none"
  aggregation_window = 300
  aggregation_method = "event_flow"
  aggregation_delay  = 120
}

resource "newrelic_nrql_alert_condition" "browser_step_monitor_failure_condition" {
  account_id                   = var.account_id
  policy_id                    = newrelic_alert_policy.synthetics_policy.id
  type                         = "static"
  name                         = "Browser Step Monitor Failures"
  enabled                      = true
  violation_time_limit_seconds = 259200

  nrql {
    query = "SELECT  uniqueCount(location) from SyntheticCheck where result != 'SUCCESS' AND typeLabel = 'Scripted Browser' FACET monitorName"
  }

  critical {
    operator              = "above_or_equals"
    threshold             = 2
    threshold_duration    = 300
    threshold_occurrences = "all"
  }
  fill_option        = "none"
  aggregation_window = 300
  aggregation_method = "event_flow"
  aggregation_delay  = 120
}