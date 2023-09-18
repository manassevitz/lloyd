module "dashboardTest" {
  source         = "../../modules/dashboardsJson"
  file = "test.json"
  folder = "scripts"
}