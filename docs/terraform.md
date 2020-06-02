## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| command | The command that is passed to the container | list(string) | `null` | no |
| container_cpu | The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value | number | `256` | no |
| container_depends_on | The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed. The condition can be one of START, COMPLETE, SUCCESS or HEALTHY | object | `null` | no |
| container_image | The image used to start the container. Images in the Docker Hub registry available by default | string | - | yes |
| container_memory | The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value | number | `256` | no |
| container_memory_reservation | The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit | number | `128` | no |
| container_name | The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed) | string | - | yes |
| dns_servers | Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers | list(string) | `null` | no |
| docker_labels | The configuration options to send to the `docker_labels` | map(string) | `null` | no |
| entrypoint | The entry point that is passed to the container | list(string) | `null` | no |
| environment | The environment variables to pass to the container. This is a list of maps | object | `null` | no |
| environment_files | One or more files containing the environment variables to pass to the container. This maps to the --env-file option to docker run. The file must be hosted in Amazon S3. This option is only available to tasks using the EC2 launch type. This is a list of maps | object | `null` | no |
| essential | Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value | bool | `true` | no |
| firelens_configuration | The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html | object | `null` | no |
| healthcheck | A map containing command (string), timeout, interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy), and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries) | object | `null` | no |
| links | List of container names this container can communicate with without port mappings | list(string) | `null` | no |
| linux_parameters | Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html | object | `null` | no |
| log_configuration | Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html | object | `null` | no |
| map_environment | The environment variables to pass to the container. This is a map of string: {key: value}, environment override map_environment | map(string) | `null` | no |
| mount_points | Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume` | object | `null` | no |
| port_mappings | The port mappings to configure for the container. This is a list of maps. Each map should contain "containerPort", "hostPort", and "protocol", where "protocol" is one of "tcp" or "udp". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort | object | `<list>` | no |
| privileged | When this variable is `true`, the container is given elevated privileges on the host container instance (similar to the root user). This parameter is not supported for Windows containers or tasks using the Fargate launch type. | bool | `null` | no |
| readonly_root_filesystem | Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value | bool | `false` | no |
| repository_credentials | Container repository credentials; required when using a private repo.  This map currently supports a single key; "credentialsParameter", which should be the ARN of a Secrets Manager's secret holding the credentials | map(string) | `null` | no |
| secrets | The secrets to pass to the container. This is a list of maps | object | `null` | no |
| start_timeout | Time duration (in seconds) to wait before giving up on resolving dependencies for a container | number | `30` | no |
| stop_timeout | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own | number | `30` | no |
| system_controls | A list of namespaced kernel parameters to set in the container, mapping to the --sysctl option to docker run. This is a list of maps: { namespace = "", value = ""} | list(map(string)) | `null` | no |
| ulimits | Container ulimit settings. This is a list of maps, where each map should contain "name", "hardLimit" and "softLimit" | object | `null` | no |
| user | The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group | string | `null` | no |
| volumes_from | A list of VolumesFrom maps which contain "sourceContainer" (name of the container that has the volumes to mount) and "readOnly" (whether the container can write to the volume) | object | `null` | no |
| working_directory | The working directory to run commands inside the container | string | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| json | JSON encoded list of container definitions for use with other terraform resources such as aws_ecs_task_definition |
| json_map | JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition |

