# The following hacks are required to overcome TF automatic type conversions which lead to issues with the resulting json types.
# Conversion happens by using the built-in `replace` function in this order:
#  - Convert `""`, `{}`, `[]`, and `[""]` to `null`
#  - Convert `"true"` and `"false"` to `true` and `false`
#  - Convert quoted numbers (e.g. `"123"`) to `123`.
# Environment variables are kept as strings.
locals {
  encoded_environment_variables = "${jsonencode(local.environment)}"

  # append the secrets key if any are defined
  # empty lists in the container definition cause :
  # ClientException: When you are specifying container secrets, you must also specify a value for 'executionRoleArn'.
  encoded_secrets = "${jsonencode(local.secrets)}"

  encoded_container_definition = "${replace(replace(replace(jsonencode(merge(local.container_definition, map("secrets", "secrets_sentinel_value"))), "/(\\[\\]|\\[\"\"\\]|\"\"|{})/", "null"), "/\"(true|false)\"/", "$1"), "/\"([0-9]+\\.?[0-9]*)\"/", "$1")}"
  json_map                     = "${replace(replace(local.encoded_container_definition, "/\"environment_sentinel_value\"/", local.encoded_environment_variables), "/\"secrets_sentinel_value\"/", local.encoded_secrets)}"
}

output "json" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."

  value = "[${local.json_map}]"
}

output "json_map" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."

  value = "${local.json_map}"
}
