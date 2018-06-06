output "container_definitions" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."
  value       = "${replace(replace(jsonencode(local.container_definitions), "/\"0\"/", "false"), "/\"([0-9]+\\.?[0-9]*)\"/", "$1")}"
}
