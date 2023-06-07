variable "container_name" {
  type        = string
  description = "The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed)"
}

variable "container_image" {
  type        = string
  description = "The image used to start the container. Images in the Docker Hub registry available by default"
}

variable "container_memory" {
  type        = number
  description = "The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
  default     = null
}

variable "container_memory_reservation" {
  type        = number
  description = "The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit"
  default     = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html
#variable "container_definition" {
#  type = object({
#    command = optional(list(string))
#    cpu     = optional(number)
#    dependsOn = optional(list(object({
#      condition     = string
#      containerName = string
#    })))
#    disableNetworking     = optional(bool)
#    dnsSearchDomains      = optional(list(string))
#    dnsServers            = optional(list(string))
#    dockerLabels          = optional(map(string))
#    dockerSecurityOptions = optional(list(string))
#    entryPoint            = optional(list(string))
#    environment = optional(list(object({
#      name  = string
#      value = string
#    })))
#    environmentFiles = optional(list(object({
#      type  = string
#      value = string
#    })))
#    essential = optional(bool)
#    extraHosts = optional(list(object({
#      hostname  = string
#      ipAddress = string
#    })))
#    firelensConfiguration = optional(object({
#      options = optional(map(string))
#      type    = string
#    }))
#    healthCheck = optional(object({
#      command     = list(string)
#      interval    = optional(number)
#      retries     = optional(number)
#      startPeriod = optional(number)
#      timeout     = optional(number)
#    }))
#    hostname    = optional(string)
#    image       = optional(string)
#    interactive = optional(bool)
#    links       = optional(list(string))
#    linuxParameters = optional(object({
#      capabilities = optional(object({
#        add  = optional(list(string))
#        drop = optional(list(string))
#      }))
#      devices = optional(list(object({
#        containerPath = string
#        hostPath      = string
#        permissions   = optional(list(string))
#      })))
#      initProcessEnabled = optional(bool)
#      maxSwap            = optional(number)
#      sharedMemorySize   = optional(number)
#      swappiness         = optional(number)
#      tmpfs = optional(list(object({
#        containerPath = string
#        mountOptions  = optional(list(string))
#        size          = number
#      })))
#    }))
#    logConfiguration = optional(object({
#      logDriver = string
#      options   = optional(map(string))
#      secretOptions = optional(list(object({
#        name      = string
#        valueFrom = string
#      })))
#    }))
#    memory            = optional(number)
#    memoryReservation = optional(number)
#    mountPoints = optional(list(object({
#      containerPath = optional(string)
#      readOnly      = optional(bool)
#      sourceVolume  = optional(string)
#    })))
#    name = optional(string)
#    portMappings = optional(list(object({
#      containerPort = number
#      hostPort      = optional(number)
#      protocol      = optional(string)
#    })))
#    privileged             = optional(bool)
#    pseudoTerminal         = optional(bool)
#    readonlyRootFilesystem = optional(bool)
#    repositoryCredentials = optional(object({
#      credentialsParameter = string
#    }))
#    resourceRequirements = optional(list(object({
#      type  = string
#      value = string
#    })))
#    secrets = optional(list(object({
#      name      = string
#      valueFrom = string
#    })))
#    startTimeout = optional(number)
#    stopTimeout  = optional(number)
#    systemControls = optional(list(object({
#      namespace = string
#      value     = string
#    })))
#    ulimits = optional(list(object({
#      hardLimit = number
#      name      = string
#      softLimit = number
#    })))
#    user = optional(string)
#    volumesFrom = optional(list(object({
#      readOnly        = optional(bool)
#      sourceContainer = string
#    })))
#    workingDirectory = optional(string)
#  })
#  description = "Container definition overrides which allows for extra keys or overriding existing keys."
#  default     = {}
#}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PortMapping.html
variable "port_mappings" {
  type = list(object({
    containerPort = number
    hostPort      = optional(number)
    protocol      = optional(string)
  }))
  description = "The port mappings to configure for the container. This is a list of maps. Each map should contain \"containerPort\", \"hostPort\", and \"protocol\", where \"protocol\" is one of \"tcp\" or \"udp\". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort"
  default     = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HealthCheck.html
#variable "healthcheck" {
#  type = object({
#    command     = list(string)
#    interval    = optional(number)
#    retries     = optional(number)
#    startPeriod = optional(number)
#    timeout     = optional(number)
#  })
#  description = "A map containing command (string), timeout, interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy), and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries)"
#  default     = null
#}

variable "container_cpu" {
  type        = number
  description = "The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
  default     = 0
}

variable "essential" {
  type        = bool
  description = "Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value"
  default     = true
}

variable "entrypoint" {
  type        = list(string)
  description = "The entry point that is passed to the container"
  default     = null
}

variable "command" {
  type        = list(string)
  description = "The command that is passed to the container"
  default     = null
}

variable "working_directory" {
  type        = string
  description = "The working directory to run commands inside the container"
  default     = null
}

variable "container_environment" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "The environment variables to pass to the container. This is a list of maps. map_environment overrides environment"
  default     = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HostEntry.html
variable "extra_hosts" {
  type = list(object({
    hostname  = string
    ipAddress = string
  }))
  description = "A list of hostnames and IP address mappings to append to the /etc/hosts file on the container. This is a list of maps"
  default     = null
}

variable "map_environment" {
  type        = map(string)
  description = "The environment variables to pass to the container. This is a map of string: {key: value}. map_environment overrides environment"
  default     = null
}

#variable "map_secrets" {
#  type        = map(string)
#  description = "The secrets variables to pass to the container. This is a map of string: {key: value}. map_secrets overrides secrets"
#  default     = null
#}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_EnvironmentFile.html
#variable "environment_files" {
#  type = list(object({
#    type  = string
#    value = string
#  }))
#  description = "One or more files containing the environment variables to pass to the container. This maps to the --env-file option to docker run. The file must be hosted in Amazon S3. This option is only available to tasks using the EC2 launch type. This is a list of maps"
#  default     = null
#}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_Secret.html
#variable "secrets" {
#  type = list(object({
#    name      = string
#    valueFrom = string
#  }))
#  description = "The secrets to pass to the container. This is a list of maps"
#  default     = null
#}

variable "readonly_root_filesystem" {
  type        = bool
  description = "Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value"
  default     = false
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html
#variable "linux_parameters" {
#  type = object({
#    capabilities = optional(object({
#      add  = optional(list(string))
#      drop = optional(list(string))
#    }))
#    devices = optional(list(object({
#      containerPath = string
#      hostPath      = string
#      permissions   = optional(list(string))
#    })))
#    initProcessEnabled = optional(bool)
#    maxSwap            = optional(number)
#    sharedMemorySize   = optional(number)
#    swappiness         = optional(number)
#    tmpfs = optional(list(object({
#      containerPath = string
#      mountOptions  = optional(list(string))
#      size          = number
#    })))
#  })
#  description = "Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html"
#  default     = null
#}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html
variable "log_configuration" {
  type = object({
    logDriver = string
    options   = optional(map(string))
    secretOptions = optional(list(object({
      name      = string
      valueFrom = string
    })))
  })
  description = "Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html"
  default     = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html
#variable "firelens_configuration" {
#  type = object({
#    options = optional(map(string))
#    type    = string
#  })
#  description = "The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html"
#  default     = null
#}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_MountPoint.html
#variable "mount_points" {
#  type = list(object({
#    containerPath = optional(string)
#    readOnly      = optional(bool)
#    sourceVolume  = optional(string)
#  }))
#  description = "Container mount points. This is a list of maps, where each map should contain `containerPath`, `sourceVolume` and `readOnly`"
#  default     = null
#}

#variable "dns_servers" {
#  type        = list(string)
#  description = "Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers"
#  default     = null
#}

#variable "dns_search_domains" {
#  type        = list(string)
#  description = "Container DNS search domains. A list of DNS search domains that are presented to the container"
#  default     = null
#}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_Ulimit.html
#variable "ulimits" {
#  type = list(object({
#    hardLimit = number
#    name      = string
#    softLimit = number
#  }))
#  description = "Container ulimit settings. This is a list of maps, where each map should contain \"name\", \"hardLimit\" and \"softLimit\""
#  default     = null
#}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_RepositoryCredentials.html
#variable "repository_credentials" {
#  type = object({
#    credentialsParameter = string
#  })
#  description = "Container repository credentials; required when using a private repo.  This map currently supports a single key; \"credentialsParameter\", which should be the ARN of a Secrets Manager's secret holding the credentials"
#  default     = null
#}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_VolumeFrom.html
#variable "volumes_from" {
#  type = list(object({
#    readOnly        = optional(bool)
#    sourceContainer = string
#  }))
#  description = "A list of VolumesFrom maps which contain \"sourceContainer\" (name of the container that has the volumes to mount) and \"readOnly\" (whether the container can write to the volume)"
#  default     = null
#}

#variable "links" {
#  type        = list(string)
#  description = "List of container names this container can communicate with without port mappings"
#  default     = null
#}

#variable "user" {
#  type        = string
#  description = "The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group. The default (null) will use the container's configured `USER` directive or root if not set."
#  default     = null
#}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDependency.html
#variable "container_depends_on" {
#  type = list(object({
#    condition     = string
#    containerName = string
#  }))
#  description = "The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed. The condition can be one of START, COMPLETE, SUCCESS or HEALTHY"
#  default     = null
#}

#variable "docker_labels" {
#  type        = map(string)
#  description = "The configuration options to send to the `docker_labels`"
#  default     = null
#}

#variable "start_timeout" {
#  type        = number
#  description = "Time duration (in seconds) to wait before giving up on resolving dependencies for a container"
#  default     = null
#}

#variable "stop_timeout" {
#  type        = number
#  description = "Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own"
#  default     = null
#}

variable "privileged" {
  type        = bool
  description = "When this variable is `true`, the container is given elevated privileges on the host container instance (similar to the root user). This parameter is not supported for Windows containers or tasks using the Fargate launch type."
  default     = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_SystemControl.html
#variable "system_controls" {
#  type = list(object({
#    namespace = string
#    value     = string
#  }))
#  description = "A list of namespaced kernel parameters to set in the container, mapping to the --sysctl option to docker run. This is a list of maps: { namespace = \"\", value = \"\"}"
#  default     = null
#}

variable "hostname" {
  type        = string
  description = "The hostname to use for your container."
  default     = null
}

variable "disable_networking" {
  type        = bool
  description = "When this parameter is true, networking is disabled within the container."
  default     = null
}

variable "interactive" {
  type        = bool
  description = "When this parameter is true, this allows you to deploy containerized applications that require stdin or a tty to be allocated."
  default     = null
}

variable "pseudo_terminal" {
  type        = bool
  description = "When this parameter is true, a TTY is allocated. "
  default     = null
}

variable "docker_security_options" {
  type        = list(string)
  description = "A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems."
  default     = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ResourceRequirement.html
#variable "resource_requirements" {
#  type = list(object({
#    type  = string
#    value = string
#  }))
#  description = "The type and amount of a resource to assign to a container. The only supported resource is a GPU."
#  default     = null
#}
