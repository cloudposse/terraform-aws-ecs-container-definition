## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| command | The command that is passed to the container | list(string) | `"null"` | no |
| container\_cpu | The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value | number | `"256"` | no |
| container\_depends\_on | The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed | list(string) | `"null"` | no |
| container\_image | The image used to start the container. Images in the Docker Hub registry available by default | string | n/a | yes |
| container\_memory | The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value | number | `"256"` | no |
| container\_memory\_reservation | The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit | number | `"128"` | no |
| container\_name | The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed) | string | n/a | yes |
| dns\_servers | Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers. | list(string) | `"null"` | no |
| entrypoint | The entry point that is passed to the container | list(string) | `"null"` | no |
| environment | The environment variables to pass to the container. This is a list of maps | list(map(string)) | `"null"` | no |
| essential | Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value | bool | `"true"` | no |
| healthcheck | A map containing command (string), interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy, and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries) | map(string) | `"null"` | no |
| links | List of container names this container can communicate with without port mappings. | list(string) | `"null"` | no |
| log\_driver | The log driver to use for the container. If using Fargate launch type, only supported value is awslogs | string | `"awslogs"` | no |
| log\_options | The configuration options to send to the `log_driver` | map(string) | `{ "awslogs-group": "default", "awslogs-region": "us-west-2", "awslogs-stream-prefix": "default" }` | no |
| mount\_points | Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume` | list( | `"null"` | no |
| port\_mappings | The port mappings to configure for the container. This is a list of maps. Each map should contain "containerPort", "hostPort", and "protocol", where "protocol" is one of "tcp" or "udp". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort | list( | `[ { "containerPort": 80, "hostPort": 80, "protocol": "tcp" } ]` | no |
| readonly\_root\_filesystem | Determines whether a container is given read-only access to its root filesystem. | bool | `"false"` | no |
| repository\_credentials | Container repository credentials; required when using a private repo.  This map currently supports a single key; "credentialsParameter", which should be the ARN of a Secrets Manager's secret holding the credentials | map(string) | `"null"` | no |
| secrets | The secrets to pass to the container. This is a list of maps | list(string) | `"null"` | no |
| stop\_timeout | Timeout in seconds between sending SIGTERM and SIGKILL to container | number | `"30"` | no |
| ulimits | Container ulimit settings. This is a list of maps, where each map should contain "name", "hardLimit" and "softLimit" | list(string) | `"null"` | no |
| user | The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group | string | `"null"` | no |
| volumes\_from | A list of VolumesFrom maps which contain "sourceContainer" (name of the container that has the volumes to mount) and "readOnly" (whether the container can write to the volume). | list(string) | `"null"` | no |
| working\_directory | The working directory to run commands inside the container | string | `"null"` | no |

## Outputs

| Name | Description |
|------|-------------|
| json | JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition. |
| json\_map | JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition. |
