resource "newrelic_alert_policy" "custom_nrql" {
  name = "OM - Name"
  incident_preference = "PER_CONDITION_AND_TARGET"
}