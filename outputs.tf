output "container_definitions" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition."

  # The following hack is required to overcome TF automatic type conversions which lead to issues with the resulting json types.
  # Conversion happens by using the built-in `replace` function in this order:
  #  - Convert `""`, `{}`, `[]`, and `[""]` to `null`
  #  - Convert `"true"` and `"false"` to `true` and `false`
  #  - Convert quoted numbers (e.g. `"123"`) to `123`.
  value = "${replace(replace(replace(jsonencode(local.container_definitions), "/(\\[\\]|\\[\"\"\\]|\"\"|{})/", "null"), "/\"(true|false)\"/", "$1"), "/\"([0-9]+\\.?[0-9]*)\"/", "$1")}"
}
