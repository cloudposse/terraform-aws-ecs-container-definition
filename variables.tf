variable "container_name" {
  default = "apache"
}

variable "container_image" {
  default = "apache:latest"
}

variable "network_mode" {
  default = "awsvpc"
}

variable "container_cpu" {
  default = "256"
}

variable "container_memory" {
  default = "256"
}

variable "family" {
  default = "apache"
}

variable "container_port" {
  default = "80"
}

variable "host_port" {
  default = "80"
}

variable "protocol" {
  default = "tcp"
}
