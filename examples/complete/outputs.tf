output "json_map_encoded_list" {
  description = "JSON encoded list of container definitions for use with other terraform resources such as aws_ecs_task_definition"
  value       = module.container.json_map_encoded_list
}

output "json_map_encoded" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition"
  value       = module.container.json_map_encoded
}

output "json_map_object" {
  description = "JSON map encoded container definition"
  value       = module.container.json_map_object
}

output "task_definition_container_definition" {
  description = "The aws_ecs_task_definition container definition"
  value       = jsondecode(aws_ecs_task_definition.task.container_definitions)[0]
}