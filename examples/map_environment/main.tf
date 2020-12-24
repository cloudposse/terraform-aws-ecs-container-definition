module "container" {
  source          = "../../"
  container_name  = "name"
  container_image = "cloudposse/geodesic"

  map_environment = {
    "string_var"        = "I am a string"
    "true_boolean_var"  = true
    "false_boolean_var" = false
    "integer_var"       = 42
  }
}

output "json" {
  description = "Container definition in JSON format"
  value       = module.container.json_map_encoded_list
}
