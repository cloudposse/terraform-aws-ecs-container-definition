module "container" {
  source          = "../../"
  container_name  = "name"
  container_image = "cloudposse/geodesic"

  environment = [
    {
      name  = "string_var"
      value = "123"
    },
    {
      name  = "another_string_var"
      value = "true"
    },
    {
      name  = "yet_another_string_var"
      value = "false"
    }
  ]
}

output "json" {
  description = "Container definition in JSON format"
  value       = module.container.json
}
