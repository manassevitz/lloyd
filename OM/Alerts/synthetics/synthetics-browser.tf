module "syntethics" {
  count            = length(local.stack_instances)
  source           = "../../../modules/syntethicsBrowser"
  name             = local.stack_instances[count.index].stack_name
  file             = local.stack_instances[count.index].stack_js
  status           = "ENABLED"
  period           = "EVERY_10_MINUTES"
  locations_public = ["US_EAST_1"]
  folder           = "./scripts/"
  type             = local.stack_instances[count.index].type // SCRIPT_BROWSER or SCRIPT_API
  runtime_type_version = local.stack_instances[count.index].runtime_type_version // 1 for chrome 100+ - 2 form 72 legacy .. you can join to 2 to 1 but no 1 to 2 
  policy_id        = 4142478
}

