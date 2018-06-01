output "container_definitions" {
  value = "${jsonencode(local.container_definitions)}"
}
