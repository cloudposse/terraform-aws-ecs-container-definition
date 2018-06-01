locals {
  container_definitions = [{
    name      = "${var.container_name}"
    image     = "${var.container_image}"
    memory    = "${var.container_memory}"
    cpu       = "${var.container_cpu}"
    essential = true
    networkMode = "${var.network_mode}"

    portMappings = [
      {
        containerPort = "${var.container_port}"
        hostPort = "${var.host_port}"
        protocol      = "${var.protocol}"
      },
    ]

    logConfiguration = {}
  }]
}
