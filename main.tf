# Environment variables are composed into the container definition at output generation time. See outputs.tf for more information.
locals {
  container_definition = {
    name                   = var.container_name
    image                  = var.container_image
    memory                 = var.container_cpu > 0 ? var.container_cpu : null
    memoryReservation      = var.container_memory_reservation > 0 ? var.container_memory_reservation : null
    cpu                    = var.container_cpu > 0 ? var.container_cpu : null
    essential              = var.essential
    entryPoint             = var.entrypoint
    command                = var.command
    workingDirectory       = var.working_directory
    readonlyRootFilesystem = var.readonly_root_filesystem
    mountPoints            = var.mount_points
    dnsServers             = var.dns_servers
    ulimits                = var.ulimits
    repositoryCredentials  = var.repository_credentials
    links                  = var.links
    volumesFrom            = var.volumes_from
    user                   = var.user
    dependsOn              = var.container_depends_on
    stopTimeout            = var.stop_timeout > 0 ? var.stop_timeout : null
    portMappings           = var.port_mappings
    healthCheck            = var.healthcheck
    logConfiguration = {
      logDriver = var.log_driver
      options   = var.log_options
    }
    environment = var.environment
    secrets     = var.secrets
  }
}
