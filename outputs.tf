output "json" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."

  value = "[${jsonencode(local.container_definition)}]"
}

output "json_map" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."

  value = jsonencode(local.container_definition)
}
