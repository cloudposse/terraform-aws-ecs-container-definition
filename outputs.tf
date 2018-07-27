output "json" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."

  # The following hack is required to overcome TF automatic type conversions which lead to issues with the resulting json types.
  # Conversion happens by using the built-in `replace` function in this order:
  #  - Convert `""`, `{}`, `[]`, and `[""]` to `null`
  #  - Remove quotes from quoted numbers (e.g. `"123"`), `"true"` and `"false"`, except inside the environment's "value" key
  value = "${replace(replace(jsonencode(local.container_definitions), "/(\\[\\]|\\[\"\"\\]|\"\"|{})/", "null"), "/(\"[^v][[:alpha:]]+\":)\"([0-9]+\\.?[0-9]*|true|false)\"/", "$1$2")}"
}
