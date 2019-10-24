module "container" {
  source          = "../../"
  container_name  = "name"
  container_image = "cloudposse/geodesic"

  environment = [
    {
      name  = "string_var"
      value = "I am a string"
    },
    {
      name  = "true_boolean_var"
      value = true
    },
    {
      name  = "false_boolean_var"
      value = false
    },
    {
      name  = "integer_var"
      value = 42
    },
  ]
}

output "json" {
  description = "Container definition in JSON format"
  value       = module.container.json
}

