provider "aws" {
  region = var.region
}

module "container" {
  source                       = "../.."
  container_name               = var.container_name
  container_image              = var.container_image
  container_memory             = var.container_memory
  container_memory_reservation = var.container_memory_reservation
  container_cpu                = var.container_cpu
  essential                    = var.essential
  readonly_root_filesystem     = var.readonly_root_filesystem
  environment                  = var.container_environment
  port_mappings                = var.port_mappings
  log_configuration            = var.log_configuration
  privileged                   = var.privileged
  extra_hosts                  = var.extra_hosts
  hostname                     = var.hostname
  pseudo_terminal              = var.pseudo_terminal
  interactive                  = var.interactive
  restart_policy               = var.restart_policy
}

resource "aws_ecs_task_definition" "task" {
  family                = module.this.id
  container_definitions = module.container.json_map_encoded_list

  tags = module.this.tags
}
