module "syntethics" {
  count            = length(local.stack_instances)
  source           = "../../../modules/syntethicsBrowser"
  name             = local.stack_instances[count.index].stack_name
  file             = local.stack_instances[count.index].stack_js
  status           = "ENABLED"
  period           = "EVERY_10_MINUTES"
  locations_public = ["US_EAST_1"]
  folder           = "./scripts/"
  type             = "SCRIPT_API"
  policy_id        = 4142478
}

