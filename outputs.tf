output "json_map_encoded_list" {
  description = "JSON string encoded list of container definitions for use with other terraform resources such as aws_ecs_task_definition"
  value       = "[${local.json_map}]"
  sensitive   = true
}

output "json_map_encoded" {
  description = "JSON string encoded container definitions for use with other terraform resources such as aws_ecs_task_definition"
  value       = local.json_map
  sensitive   = true
}

output "json_map_object" {
  description = "JSON map encoded container definition"
  value       = jsondecode(local.json_map)
  sensitive   = true
}
