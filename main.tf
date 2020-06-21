locals {
  # Sort environment variables so terraform will not try to recreate on each plan/apply
  env_vars             = var.environment != null ? var.environment : []
  env_vars_keys        = var.map_environment != null ? keys(var.map_environment) : [for m in local.env_vars : lookup(m, "name")]
  env_vars_values      = var.map_environment != null ? values(var.map_environment) : [for m in local.env_vars : lookup(m, "value")]
  env_vars_as_map      = zipmap(local.env_vars_keys, local.env_vars_values)
  sorted_env_vars_keys = sort(local.env_vars_keys)

  sorted_environment_vars = [
    for key in local.sorted_env_vars_keys :
    {
      name  = key
      value = lookup(local.env_vars_as_map, key)
    }
  ]

  # This strange-looking variable is needed because terraform (currently) does not support explicit `null` in ternary operator,
  # so this does not work: final_environment_vars = length(local.sorted_environment_vars) > 0 ? local.sorted_environment_vars : null
  null_value = var.environment == null ? var.environment : null

  # https://www.terraform.io/docs/configuration/expressions.html#null
  final_environment_vars = length(local.sorted_environment_vars) > 0 ? local.sorted_environment_vars : local.null_value

  mount_points = length(var.mount_points) > 0 ? [
    for mount_point in var.mount_points : {
      containerPath = lookup(mount_point, "containerPath")
      sourceVolume  = lookup(mount_point, "sourceVolume")
      readOnly      = tobool(lookup(mount_point, "readOnly", false))
    }
  ] : var.mount_points

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
    ulimits                = var.ulimits
    repositoryCredentials  = var.repository_credentials
    links                  = var.links
    volumesFrom            = var.volumes_from
    user                   = var.user
    dependsOn              = var.container_depends_on
    privileged             = var.privileged
    portMappings           = var.port_mappings
    healthCheck            = var.healthcheck
    firelensConfiguration  = var.firelens_configuration
    linuxParameters        = var.linux_parameters
    logConfiguration       = var.log_configuration
    memory                 = var.container_memory
    memoryReservation      = var.container_memory_reservation
    cpu                    = var.container_cpu
    environment            = local.final_environment_vars
    environmentFiles       = var.environment_files
    secrets                = var.secrets
    dockerLabels           = var.docker_labels
    startTimeout           = var.start_timeout
    stopTimeout            = var.stop_timeout
    systemControls         = var.system_controls
    extraHosts             = var.extra_hosts
  }

  container_definition_without_null = {
    for k, v in local.container_definition :
    k => v
    if v != null
  }
  json_map = jsonencode(merge(local.container_definition_without_null, var.container_definition))
}
