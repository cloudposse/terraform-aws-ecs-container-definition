locals {
  # Sort environment variables so terraform will not try to recreate on each plan/apply
  env_vars_keys        = var.map_environment != null ? keys(var.map_environment) : var.environment != null ? [for m in var.environment : lookup(m, "name")] : []
  env_vars_values      = var.map_environment != null ? values(var.map_environment) : var.environment != null ? [for m in var.environment : lookup(m, "value")] : []
  env_vars_as_map      = zipmap(local.env_vars_keys, local.env_vars_values)
  sorted_env_vars_keys = sort(local.env_vars_keys)

  sorted_environment_vars = [
    for key in local.sorted_env_vars_keys :
    {
      name  = key
      value = lookup(local.env_vars_as_map, key)
    }
  ]

  # Sort secrets so terraform will not try to recreate on each plan/apply
  secrets_keys        = var.map_secrets != null ? keys(var.map_secrets) : var.secrets != null ? [for m in var.secrets : lookup(m, "name")] : []
  secrets_values      = var.map_secrets != null ? values(var.map_secrets) : var.secrets != null ? [for m in var.secrets : lookup(m, "valueFrom")] : []
  secrets_as_map      = zipmap(local.secrets_keys, local.secrets_values)
  sorted_secrets_keys = sort(local.secrets_keys)

  sorted_secrets_vars = [
    for key in local.sorted_secrets_keys :
    {
      name      = key
      valueFrom = lookup(local.secrets_as_map, key)
    }
  ]

  mount_points = length(var.mount_points) > 0 ? [
    for mount_point in var.mount_points : {
      containerPath = lookup(mount_point, "containerPath")
      sourceVolume  = lookup(mount_point, "sourceVolume")
      readOnly      = tobool(lookup(mount_point, "readOnly", false))
    }
  ] : var.mount_points

  dynamic "volume" {
    for_each = var.volumes
    content {
      name      = volume.value.name
      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
          scope         = lookup(docker_volume_configuration.value, "scope", null)
        }
      }
    }
  }

  # https://www.terraform.io/docs/configuration/expressions.html#null
  final_environment_vars = length(local.sorted_environment_vars) > 0 ? local.sorted_environment_vars : null
  final_secrets_vars     = length(local.sorted_secrets_vars) > 0 ? local.sorted_secrets_vars : null

  log_configuration_secret_options = var.log_configuration != null ? lookup(var.log_configuration, "secretOptions", null) : null
  log_configuration_with_null = var.log_configuration == null ? null : {
    logDriver = tostring(lookup(var.log_configuration, "logDriver"))
    options   = tomap(lookup(var.log_configuration, "options"))
    secretOptions = local.log_configuration_secret_options == null ? null : [
      for secret_option in tolist(local.log_configuration_secret_options) : {
        name      = tostring(lookup(secret_option, "name"))
        valueFrom = tostring(lookup(secret_option, "valueFrom"))
      }
    ]
  }
  log_configuration_without_null = local.log_configuration_with_null == null ? null : {
    for k, v in local.log_configuration_with_null :
    k => v
    if v != null
  }
  user = var.firelens_configuration != null ? "0" : var.user

  container_definition = {
    name                   = var.container_name
    image                  = var.container_image
    essential              = var.essential
    entryPoint             = var.entrypoint
    command                = var.command
    workingDirectory       = var.working_directory
    readonlyRootFilesystem = var.readonly_root_filesystem
    mountPoints            = local.mount_points
    dnsServers             = var.dns_servers
    dnsSearchDomains       = var.dns_search_domains
    ulimits                = var.ulimits
    repositoryCredentials  = var.repository_credentials
    links                  = var.links
    volumesFrom            = var.volumes_from
    volume                 = local.volumes
    user                   = local.user
    dependsOn              = var.container_depends_on
    privileged             = var.privileged
    portMappings           = var.port_mappings
    healthCheck            = var.healthcheck
    firelensConfiguration  = var.firelens_configuration
    linuxParameters        = var.linux_parameters
    logConfiguration       = local.log_configuration_without_null
    memory                 = var.container_memory
    memoryReservation      = var.container_memory_reservation
    cpu                    = var.container_cpu
    environment            = local.final_environment_vars
    environmentFiles       = var.environment_files
    secrets                = local.final_secrets_vars
    dockerLabels           = var.docker_labels
    startTimeout           = var.start_timeout
    stopTimeout            = var.stop_timeout
    systemControls         = var.system_controls
    extraHosts             = var.extra_hosts
    hostname               = var.hostname
    disableNetworking      = var.disable_networking
    interactive            = var.interactive
    pseudoTerminal         = var.pseudo_terminal
    dockerSecurityOptions  = var.docker_security_options
    resourceRequirements   = var.resource_requirements
  }

  container_definition_without_null = {
    for k, v in local.container_definition :
    k => v
    if v != null
  }
  json_map = jsonencode(merge(local.container_definition_without_null, var.container_definition))
}
