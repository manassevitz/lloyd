locals {
  json_content    = file("./stack.json")
  stack_instances = jsondecode(local.json_content)
}