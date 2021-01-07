<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| local | >= 1.2 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| command | The command that is passed to the container | `list(string)` | `null` | no |
| container\_cpu | The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container\_cpu of all containers in a task will need to be lower than the task-level cpu value | `number` | `0` | no |
| container\_definition | Container definition overrides which allows for extra keys or overriding existing keys. | `map(any)` | `{}` | no |
| container\_depends\_on | The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed. The condition can be one of START, COMPLETE, SUCCESS or HEALTHY | <pre>list(object({<br>    containerName = string<br>    condition     = string<br>  }))</pre> | `null` | no |
| container\_image | The image used to start the container. Images in the Docker Hub registry available by default | `string` | n/a | yes |
| container\_memory | The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container\_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container\_memory of all containers in a task will need to be lower than the task memory value | `number` | `null` | no |
| container\_memory\_reservation | The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container\_memory hard limit | `number` | `null` | no |
| container\_name | The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, \_ allowed) | `string` | n/a | yes |
| disable\_networking | When this parameter is true, networking is disabled within the container. | `bool` | `null` | no |
| dns\_search\_domains | Container DNS search domains. A list of DNS search domains that are presented to the container | `list(string)` | `null` | no |
| dns\_servers | Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers | `list(string)` | `null` | no |
| docker\_labels | The configuration options to send to the `docker_labels` | `map(string)` | `null` | no |
| docker\_security\_options | A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems. | `list(string)` | `null` | no |
| entrypoint | The entry point that is passed to the container | `list(string)` | `null` | no |
| environment | The environment variables to pass to the container. This is a list of maps. map\_environment overrides environment | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| environment\_files | One or more files containing the environment variables to pass to the container. This maps to the --env-file option to docker run. The file must be hosted in Amazon S3. This option is only available to tasks using the EC2 launch type. This is a list of maps | <pre>list(object({<br>    value = string<br>    type  = string<br>  }))</pre> | `null` | no |
| essential | Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value | `bool` | `true` | no |
| extra\_hosts | A list of hostnames and IP address mappings to append to the /etc/hosts file on the container. This is a list of maps | <pre>list(object({<br>    ipAddress = string<br>    hostname  = string<br>  }))</pre> | `null` | no |
| firelens\_configuration | The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html | <pre>object({<br>    type    = string<br>    options = map(string)<br>  })</pre> | `null` | no |
| healthcheck | A map containing command (string), timeout, interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy), and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries) | <pre>object({<br>    command     = list(string)<br>    retries     = number<br>    timeout     = number<br>    interval    = number<br>    startPeriod = number<br>  })</pre> | `null` | no |
| hostname | The hostname to use for your container. | `string` | `null` | no |
| interactive | When this parameter is true, this allows you to deploy containerized applications that require stdin or a tty to be allocated. | `bool` | `null` | no |
| links | List of container names this container can communicate with without port mappings | `list(string)` | `null` | no |
| linux\_parameters | Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html | <pre>object({<br>    capabilities = object({<br>      add  = list(string)<br>      drop = list(string)<br>    })<br>    devices = list(object({<br>      containerPath = string<br>      hostPath      = string<br>      permissions   = list(string)<br>    }))<br>    initProcessEnabled = bool<br>    maxSwap            = number<br>    sharedMemorySize   = number<br>    swappiness         = number<br>    tmpfs = list(object({<br>      containerPath = string<br>      mountOptions  = list(string)<br>      size          = number<br>    }))<br>  })</pre> | `null` | no |
| log\_configuration | Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html | `any` | `null` | no |
| map\_environment | The environment variables to pass to the container. This is a map of string: {key: value}. map\_environment overrides environment | `map(string)` | `null` | no |
| mount\_points | Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`. The `readOnly` key is optional. | `list(any)` | `[]` | no |
| port\_mappings | The port mappings to configure for the container. This is a list of maps. Each map should contain "containerPort", "hostPort", and "protocol", where "protocol" is one of "tcp" or "udp". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort | <pre>list(object({<br>    containerPort = number<br>    hostPort      = number<br>    protocol      = string<br>  }))</pre> | `[]` | no |
| privileged | When this variable is `true`, the container is given elevated privileges on the host container instance (similar to the root user). This parameter is not supported for Windows containers or tasks using the Fargate launch type. | `bool` | `null` | no |
| pseudo\_terminal | When this parameter is true, a TTY is allocated. | `bool` | `null` | no |
| readonly\_root\_filesystem | Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value | `bool` | `false` | no |
| repository\_credentials | Container repository credentials; required when using a private repo.  This map currently supports a single key; "credentialsParameter", which should be the ARN of a Secrets Manager's secret holding the credentials | `map(string)` | `null` | no |
| resource\_requirements | The type and amount of a resource to assign to a container. The only supported resource is a GPU. | <pre>list(object({<br>    type  = string<br>    value = string<br>  }))</pre> | `null` | no |
| secrets | The secrets to pass to the container. This is a list of maps | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `null` | no |
| start\_timeout | Time duration (in seconds) to wait before giving up on resolving dependencies for a container | `number` | `null` | no |
| stop\_timeout | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own | `number` | `null` | no |
| system\_controls | A list of namespaced kernel parameters to set in the container, mapping to the --sysctl option to docker run. This is a list of maps: { namespace = "", value = ""} | `list(map(string))` | `null` | no |
| ulimits | Container ulimit settings. This is a list of maps, where each map should contain "name", "hardLimit" and "softLimit" | <pre>list(object({<br>    name      = string<br>    hardLimit = number<br>    softLimit = number<br>  }))</pre> | `null` | no |
| user | The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group. The default (null) will use the container's configured `USER` directive or root if not set. | `string` | `null` | no |
| volumes\_from | A list of VolumesFrom maps which contain "sourceContainer" (name of the container that has the volumes to mount) and "readOnly" (whether the container can write to the volume) | <pre>list(object({<br>    sourceContainer = string<br>    readOnly        = bool<br>  }))</pre> | `[]` | no |
| working\_directory | The working directory to run commands inside the container | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| json\_map\_encoded | JSON string encoded container definitions for use with other terraform resources such as aws\_ecs\_task\_definition |
| json\_map\_encoded\_list | JSON string encoded list of container definitions for use with other terraform resources such as aws\_ecs\_task\_definition |
| json\_map\_object | JSON map encoded container definition |

<!-- markdownlint-restore -->
