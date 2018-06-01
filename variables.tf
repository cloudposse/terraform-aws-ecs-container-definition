variable "container_name" {
  description = "The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed)."
}

variable "container_image" {
  description = "The image used to start the container. Images in the Docker Hub registry available by default."
}

variable "container_cpu" {
  description = "The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value."
  default     = "256"
}

variable "container_memory" {
  description = "The amount of memory (in MiB) to allow the container to use. If container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value."
  default     = "256"
}

variable "essential" {
  description = "Boolean to determine whether all other containers in a tasks are stopped if this container fails or stops for any reason."
  default     = true
}

variable "container_port" {
  description = "The port number on the container bound to assigned host_port."
  default     = "80"
}

variable "host_port" {
  description = "The port number on the container instance (host) to reserve for the container_port."
  default     = "80"
}

variable "protocol" {
  description = "The protocol used for the port mapping. Options: tcp or udp."
  default     = "tcp"
}

variable "log_driver" {
  description = "The log driver to use for the container. If using Fargate launch type, only supported value is awslogs."
  default     = "awslogs"
}

variable "log_options" {
  description = "The configuration options to send to the log_driver"
  default     = ""
}
