# Environment variables are composed into the container definition at output generation time. See outputs.tf for more information.
locals {
  container_definition = {
    name                   = "${var.container_name}"
    image                  = "${var.container_image}"
    memory                 = "memory_sentinel_value"
    memoryReservation      = "memory_reservation_sentinel_value"
    cpu                    = "cpu_sentinel_value"
    essential              = "${var.essential}"
    entryPoint             = "${var.entrypoint}"
    command                = "${var.command}"
    workingDirectory       = "${var.working_directory}"
    readonlyRootFilesystem = "${var.readonly_root_filesystem}"
    mountPoints            = "${var.mount_points}"
    dnsServers             = "${var.dns_servers}"
    ulimits                = "${var.ulimits}"
    repositoryCredentials  = "${var.repository_credentials}"
    links                  = "${var.links}"
    volumesFrom            = "${var.volumes_from}"
    user                   = "${var.user}"
    dependsOn              = "${var.container_depends_on}"
    stopTimeout            = "stop_timeout_sentinel_value"

    portMappings = "${var.port_mappings}"

    healthCheck = "${var.healthcheck}"

    logConfiguration = {
      logDriver = "${var.log_driver}"
      options   = "${var.log_options}"
    }

    environment = "environment_sentinel_value"
    secrets     = "secrets_sentinel_value"
  }

  environment = "${var.environment}"
  secrets     = "${var.secrets}"
}
