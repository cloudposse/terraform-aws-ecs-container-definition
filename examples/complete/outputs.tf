output "json" {
  description = "Container definition in JSON format"
  value       = module.container.json
}

output "json_map" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition"
  value       = module.container.json_map
}
