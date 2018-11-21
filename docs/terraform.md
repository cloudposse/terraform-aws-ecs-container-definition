
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| command | The command that is passed to the container | list | `<list>` | no |
| container_cpu | The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value | string | `256` | no |
| container_image | The image used to start the container. Images in the Docker Hub registry available by default | string | - | yes |
| container_memory | The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value | string | `256` | no |
| container_memory_reservation | The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit | string | `128` | no |
| container_name | The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed) | string | - | yes |
| entrypoint | The entry point that is passed to the container | list | `<list>` | no |
| environment | The environment variables to pas to the container. This is a list of maps | list | `<list>` | no |
| essential | Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value | string | `true` | no |
| healthcheck | A map containing command (string), interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy, and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries) | map | `<map>` | no |
| log_driver | The log driver to use for the container. If using Fargate launch type, only supported value is awslogs | string | `awslogs` | no |
| log_options | The configuration options to send to the `log_driver` | map | `<map>` | no |
| mount_points | Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume` | list | `<list>` | no |
| port_mappings | The port mappings to configure for the container. This is a list of maps. Each map should contain "containerPort", "hostPort", and "protocol", where "protocol" is one of "tcp" or "udp". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort | list | `<list>` | no |
| readonly_root_filesystem | Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value | string | `false` | no |
| working_directory | The working directory to run commands inside the container | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| json | JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition. |
| json_map | JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition. |

