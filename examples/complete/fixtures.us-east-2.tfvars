region = "us-east-2"

container_name               = "app"
container_image              = "cloudposse/geodesic"
container_memory             = 256
container_memory_reservation = 128
container_cpu                = 256
essential                    = true
readonly_root_filesystem     = false

environment = [
  {
    name  = "string_var"
    value = "I am a string"
  },
  {
    name  = "true_boolean_var"
    value = true
  },
  {
    name  = "false_boolean_var"
    value = false
  },
  {
    name  = "integer_var"
    value = 42
  }
]

port_mappings = [
  {
    containerPort = 8080
    hostPort      = 80
    protocol      = "tcp"
  },
  {
    containerPort = 8081
    hostPort      = 443
    protocol      = "udp"
  }
]
