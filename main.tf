locals {
  container_definitions = [{
    name                   = "${var.container_name}"
    image                  = "${var.container_image}"
    memory                 = "${var.container_memory}"
    memoryReservation      = "${var.container_memory_reservation}"
    cpu                    = "${var.container_cpu}"
    essential              = "${var.essential}"
    entryPoint             = "${var.entrypoint}"
    command                = "${var.command}"
    workingDirectory       = "${var.working_directory}"
    readonlyRootFilesystem = "${var.readonly_root_filesystem}"

    environment = "${var.environment}"

    portMappings = [
      {
        containerPort = "${var.container_port}"
        hostPort      = "${var.host_port}"
        protocol      = "${var.protocol}"
      },
    ]

    healthCheck = {
      command     = "${var.healthcheck_command}"
      interval    = "${var.healthcheck_interval}"
      retries     = "${var.healthcheck_retries}"
      startPeriod = "${var.healthcheck_start_period}"
    }

    logConfiguration = {
      logDriver = "${var.log_driver}"
      options   = "${var.log_options}"
    }
  }]
}
