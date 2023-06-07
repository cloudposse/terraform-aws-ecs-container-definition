output "json_map_encoded_list" {
  description = "JSON string encoded list of container definitions for use with other terraform resources such as aws_ecs_task_definition"
  value       = "[${local.json_map}]"
}

output "json_map_encoded" {
  description = "JSON string encoded container definitions for use with other terraform resources such as aws_ecs_task_definition"
  value       = local.json_map
}

output "json_map_object" {
  description = "JSON map encoded container definition"
  value       = local.final_container_definition
}

output "sensitive_json_map_encoded_list" {
  description = "JSON string encoded list of container definitions for use with other terraform resources such as aws_ecs_task_definition (sensitive)"
  value       = "[${local.json_map}]"
  sensitive   = true
}

output "sensitive_json_map_encoded" {
  description = "JSON string encoded container definitions for use with other terraform resources such as aws_ecs_task_definition (sensitive)"
  value       = local.json_map
  sensitive   = true
}

output "sensitive_json_map_object" {
  description = "JSON map encoded container definition (sensitive)"
  value       = local.final_container_definition
  sensitive   = true
}
