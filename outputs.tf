# The following hacks are required to overcome TF automatic type conversions which lead to issues with the resulting json types.
# Conversion happens by using the built-in `replace` function in this order:
#  - Convert `""`, `{}`, `[]`, and `[""]` to `null`
#  - Convert `"true"` and `"false"` to `true` and `false`
#  - Convert quoted numbers (e.g. `"123"`) to `123`.
# Environment variables are kept as strings.
locals {
  encoded_environment_variables = "${jsonencode(local.environment)}"
  encoded_secrets               = "${length(local.secrets) > 0 ? jsonencode(local.secrets) : "null"}"
  encoded_cpu                   = "${var.container_cpu > 0 ? var.container_cpu : "null"}"
  encoded_memory                = "${var.container_memory > 0 ? var.container_memory : "null"}"
  encoded_memory_reservation    = "${var.container_memory_reservation > 0 ? var.container_memory_reservation : "null"}"
  encoded_stop_timeout          = "${var.stop_timeout > 0 ? var.stop_timeout : "null"}"
  encoded_container_definition  = "${replace(replace(replace(jsonencode(local.container_definition), "/(\\[\\]|\\[\"\"\\]|\"\"|{})/", "null"), "/\"(true|false)\"/", "$1"), "/\"(-?[0-9]+\\.?[0-9]*)\"/", "$1")}"

  json_with_environment        = "${replace(local.encoded_container_definition, "/\"environment_sentinel_value\"/", local.encoded_environment_variables)}"
  json_with_secrets            = "${replace(local.json_with_environment, "/\"secrets_sentinel_value\"/", local.encoded_secrets)}"
  json_with_cpu                = "${replace(local.json_with_secrets, "/\"cpu_sentinel_value\"/", local.encoded_cpu)}"
  json_with_memory             = "${replace(local.json_with_cpu, "/\"memory_sentinel_value\"/", local.encoded_memory)}"
  json_with_memory_reservation = "${replace(local.json_with_memory, "/\"memory_reservation_sentinel_value\"/", local.encoded_memory_reservation)}"
  json_with_stop_timeout       = "${replace(local.json_with_memory_reservation, "/\"stop_timeout_sentinel_value\"/", local.encoded_stop_timeout)}"

  json_map = "${local.json_with_stop_timeout}"
}

output "json" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."

  value = "[${local.json_map}]"
}

output "json_map" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."

  value = "${local.json_map}"
}
