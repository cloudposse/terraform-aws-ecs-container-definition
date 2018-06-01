locals {
  container_definitions = [{
    name      = "${var.container_name}"
    image     = "${var.container_image}"
    memory    = "${var.container_memory}"
    cpu       = "${var.container_cpu}"
    essential = "${var.essential}"

    portMappings = [
      {
        containerPort = "${var.container_port}"
        hostPort      = "${var.host_port}"
        protocol      = "${var.protocol}"
      },
    ]

    logConfiguration = {
      logDriver = "${var.log_driver}"
      options   = "${var.log_options}"
    }
  }]
}
