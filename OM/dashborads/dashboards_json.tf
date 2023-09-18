module "dashboardsAccessCard" {
  source         = "./modules/dashboardsJson"
  file = "test.json"
  folder = "./dashboards"
}