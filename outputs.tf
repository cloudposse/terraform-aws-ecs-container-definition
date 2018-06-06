output "container_definitions" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."
  value       = "${replace(replace(replace(jsonencode(local.container_definitions), "/(\\[\"\"\\]|\"\"|{})/", "null"), "/\"(false|true)\"/", "$1"), "/\"([0-9]+\\.?[0-9]*)\"/", "$1")}"
}
