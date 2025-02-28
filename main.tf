locals {
  # Sort environment variables & secrets so terraform will not try to recreate on each plan/apply
  env_as_map     = var.map_environment != null ? var.map_environment : var.environment != null ? { for m in var.environment : m.name => m.value } : null
  secrets_as_map = var.map_secrets != null ? var.map_secrets : var.secrets != null ? { for m in var.secrets : m.name => m.valueFrom } : null

  # https://www.terraform.io/docs/configuration/expressions.html#null
  final_environment_vars = local.env_as_map != null ? [
    for k, v in local.env_as_map :
    {
      name  = k
      value = v
    }
  ] : null
  final_secrets_vars = local.secrets_as_map != null ? [
    for k, v in local.secrets_as_map :
    {
      name      = k
      valueFrom = v
    }
  ] : null

  log_configuration_without_null = var.log_configuration == null ? null : {
    for k, v in var.log_configuration :
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
    mountPoints            = var.mount_points
    dnsServers             = var.dns_servers
    dnsSearchDomains       = var.dns_search_domains
    ulimits                = var.ulimits
    repositoryCredentials  = var.repository_credentials
    links                  = var.links
    volumesFrom            = var.volumes_from
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
    restartPolicy          = var.restart_policy
    versionConsistency     = var.version_consistency
  }

  container_definition_without_null = {
    for k, v in local.container_definition :
    k => v
    if v != null
  }

  container_definition_override_without_null = {
    for k, v in var.container_definition :
    k => v
    if v != null
  }

  final_container_definition = merge(local.container_definition_without_null, local.container_definition_override_without_null)
  json_map                   = jsonencode(local.final_container_definition)
}
