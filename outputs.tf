output "json" {
  description = "JSON encoded list of container definitions for use with other terraform resources such as aws_ecs_task_definition"
  value       = "[${local.json_map}]"
}

output "json_map" {
  description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition"
  value       = local.json_map
}

output "container_name" {
  description = "The name of the container defined by this defintion"
  value = var.container_name
}

output "image_root" {
  value = local.image_root
  description = "The root of the image url  for example nginx or quay.io/assuemblyline/ubuntu"
}

output "image_version" {
  value = local.image_version
  description = "The image tag/version referenced by this defintion."
}