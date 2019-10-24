module "first_container" {
  source          = "../../"
  container_name  = "name"
  container_image = "cloudposse/geodesic"

  port_mappings = [
    {
      containerPort = 8080
      hostPort      = 80
      protocol      = "tcp"
    },
    {
      containerPort = 8081
      hostPort      = 443
      protocol      = "udp"
    }
  ]
}

module "second_container" {
  source          = "../../"
  container_name  = "name2"
  container_image = "cloudposse/geodesic"

  port_mappings = [
    {
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
    },
    {
      containerPort = 8081
      hostPort      = 444
      protocol      = "udp"
    }
  ]
}

output "first_container_json" {
  description = "Container definition in JSON format"
  value       = module.first_container.json
}

output "second_container_json" {
  description = "Container definition in JSON format"
  value       = module.second_container.json
}

resource "aws_ecs_task_definition" "task" {
  family                = "foo"
  container_definitions = "[${module.first_container.json_map},${module.second_container.json_map}]"
}
