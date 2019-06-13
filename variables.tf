variable "container_name" {
  type        = "string"
  description = "The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed)"
}

variable "container_image" {
  type        = "string"
  description = "The image used to start the container. Images in the Docker Hub registry available by default"
}

variable "container_memory" {
  description = "The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
  default     = 256
}

variable "container_memory_reservation" {
  description = "The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit"
  default     = 128
}

variable "port_mappings" {
  type        = "list"
  description = "The port mappings to configure for the container. This is a list of maps. Each map should contain \"containerPort\", \"hostPort\", and \"protocol\", where \"protocol\" is one of \"tcp\" or \"udp\". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort"

  default = [{
    "containerPort" = 80
    "hostPort"      = 80
    "protocol"      = "tcp"
  }]
}

variable "healthcheck" {
  type        = "map"
  description = "A map containing command (string), interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy, and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries)"
  default     = {}
}

variable "container_cpu" {
  description = "The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
  default     = 256
}

variable "essential" {
  type        = "string"
  description = "Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value"
  default     = "true"
}

variable "entrypoint" {
  type        = "list"
  description = "The entry point that is passed to the container"
  default     = [""]
}

variable "command" {
  type        = "list"
  description = "The command that is passed to the container"
  default     = [""]
}

variable "working_directory" {
  type        = "string"
  description = "The working directory to run commands inside the container"
  default     = ""
}

variable "environment" {
  type        = "list"
  description = "The environment variables to pass to the container. This is a list of maps"
  default     = []
}

variable "secrets" {
  type        = "list"
  description = "The secrets to pass to the container. This is a list of maps"
  default     = []
}

variable "readonly_root_filesystem" {
  type        = "string"
  description = "Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value"
  default     = "false"
}

variable "log_driver" {
  type        = "string"
  description = "The log driver to use for the container. If using Fargate launch type, only supported value is awslogs"
  default     = "awslogs"
}

variable "log_options" {
  type        = "map"
  description = "The configuration options to send to the `log_driver`"

  default = {
    "awslogs-region" = "us-west-2"

    "awslogs-group" = "default"

    "awslogs-stream-prefix" = "default"
  }
}

variable "mount_points" {
  type        = "list"
  description = "Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`"
  default     = []

  #default     = [
  #  {
  #    containerPath  = "/tmp"
  #    sourceVolume = "test-volume"
  #  }
  #]
}

variable "dns_servers" {
  type        = "list"
  description = "Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers."
  default     = []
}

variable "ulimits" {
  type        = "list"
  description = "Container ulimit settings. This is a list of maps, where each map should contain \"name\", \"hardLimit\" and \"softLimit\""
  default     = []
}

variable "repository_credentials" {
  type        = "map"
  description = "Container repository credentials; required when using a private repo.  This map currently supports a single key; \"credentialsParameter\", which should be the ARN of a Secrets Manager's secret holding the credentials"
  default     = {}
}

variable "volumes_from" {
  type        = "list"
  description = "A list of VolumesFrom maps which contain \"sourceContainer\" (name of the container that has the volumes to mount) and \"readOnly\" (whether the container can write to the volume)."
  default     = []
}

variable "links" {
  type        = "list"
  description = "List of container names this container can communicate with without port mappings."
  default     = []
}

variable "user" {
  description = "The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group"
  default     = ""
}

variable "container_depends_on" {
  type        = "list"
  description = "The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed"
  default     = []
}

variable "docker_labels" {
  type        = "map"
  description = "The configuration options to send to the `docker_labels`"
  default = {}
}

variable "stop_timeout" {
  description = "Timeout in seconds between sending SIGTERM and SIGKILL to container"
  default     = 30
}
