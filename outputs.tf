# The following hacks are required to overcome TF automatic type conversions which lead to issues with the resulting json types.
# Conversion happens by using the built-in `replace` function in this order:
#  - Convert `""`, `{}`, `[]`, and `[""]` to `null`
#  - Convert `"true"` and `"false"` to `true` and `false`
#  - Convert quoted numbers (e.g. `"123"`) to `123`.
# Environment variables are kept as strings.
locals {
  encoded_environment_variables = "${jsonencode(local.environment)}"
  encoded_container_definition  = "${replace(replace(replace(jsonencode(local.container_definition), "/(\\[\\]|\\[\"\"\\]|\"\"|{})/", "null"), "/\"(true|false)\"/", "$1"), "/\"([0-9]+\\.?[0-9]*)\"/", "$1")}"
  json_map                      = "${replace(local.encoded_container_definition, "/\"environment_sentinel_value\"/", local.encoded_environment_variables)}"
}

output "json" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."

  value = "[${local.json_map}]"
}

output "json_map" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."

  value = "${local.json_map}"
}
