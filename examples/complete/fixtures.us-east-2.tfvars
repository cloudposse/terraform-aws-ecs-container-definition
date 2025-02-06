region = "us-east-2"

namespace = "eg"

stage = "test"

name = "container-definition"

container_name               = "app"
container_image              = "cloudposse/geodesic"
container_memory             = 256
container_memory_reservation = 128
container_cpu                = 256
essential                    = true
readonly_root_filesystem     = false
restart_policy = {
  enabled          = true
  ignoredExitCodes = [0]
}

container_environment = [
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
    name          = "http"
    appProtocol   = "http"
  },
  {
    containerPort = 8081
    hostPort      = 443
    protocol      = "udp"
    name          = "https"
    appProtocol   = "http"
  }
]

log_configuration = {
  logDriver = "json-file"
  options = {
    max-size = "10m"
    max-file = "3"
  }
  secretOptions = null
}

privileged = false

extra_hosts = [
  {
    ipAddress = "127.0.0.1"
    hostname  = "app.local"
  },
]

hostname        = "hostname"
pseudo_terminal = true
interactive     = true
