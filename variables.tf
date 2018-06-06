variable "container_name" {
  description = "The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed)."
}

variable "container_image" {
  description = "The image used to start the container. Images in the Docker Hub registry available by default."
}

variable "container_memory" {
  description = "The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value."
  default     = 256
}

variable "container_memory_reservation" {
  description = "The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit."
  default     = 128
}

variable "container_port" {
  description = "The port number on the container bound to assigned host_port."
  default     = 80
}

variable "host_port" {
  description = "The port number on the container instance (host) to reserve for the container_port. If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort."
  default     = 80
}

variable "protocol" {
  description = "The protocol used for the port mapping. Options: tcp or udp."
  default     = "tcp"
}

variable "healthcheck" {
  description = "A map containing command (string), interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy, and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries)"
  default     = {}
}

variable "container_cpu" {
  description = "The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value."
  default     = 256
}

variable "essential" {
  description = "Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value."
  default     = "true"
}

variable "entrypoint" {
  description = "The entry point that is passed to the container."
  default     = [""]
}

variable "command" {
  description = "The command that is passed to the container."
  default     = [""]
}

variable "working_directory" {
  description = "The working directory to run commands inside the container."
  default     = ""
}

variable "environment" {
  description = "The environment variables to pas to the container. This is a list of maps."
  default     = []
}

variable "readonly_root_filesystem" {
  description = "Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value."
  default     = "false"
}

variable "log_driver" {
  description = "The log driver to use for the container. If using Fargate launch type, only supported value is awslogs."
  default     = "awslogs"
}

variable "log_options" {
  description = "The configuration options to send to the log_driver."

  default = {
    "awslogs-region" = "us-west-2"

    "awslogs-group" = "default"

    "awslogs-stream-prefix" = "default"
  }
}
