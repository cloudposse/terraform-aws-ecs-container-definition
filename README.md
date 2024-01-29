
<!-- markdownlint-disable -->
# terraform-aws-ecs-container-definition<a href="https://cpco.io/homepage"><img align="right" src="https://cloudposse.com/logo-300x69.svg" width="150" /></a>

 [![Latest Release](https://img.shields.io/github/release/cloudposse/terraform-aws-ecs-container-definition.svg)](https://github.com/cloudposse/terraform-aws-ecs-container-definition/releases/latest) [![Slack Community](https://slack.cloudposse.com/badge.svg)](https://slack.cloudposse.com)
<!-- markdownlint-restore -->


<!--




  ** DO NOT EDIT THIS FILE
  **
  ** This file was automatically generated by the `build-harness`.
  ** 1) Make all changes to `README.yaml`
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **





-->

Terraform module to generate well-formed JSON documents that are passed to the `aws_ecs_task_definition` Terraform resource as [container definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definitions).


---
> [!NOTE]
> This project is part of Cloud Posse's comprehensive ["SweetOps"](https://cpco.io/sweetops) approach towards DevOps.
> <a href="https://cpco.io/terraform-modules"><img src="https://docs.cloudposse.com/images/terraform-open-source-modules.svg" align="right" /></a>
>
> It's 100% Open Source and licensed under the [APACHE2](LICENSE).
>
> We literally have [*hundreds of terraform modules*][terraform_modules] that are Open Source and well-maintained. Check them out!

[![README Header][readme_header_img]][readme_header_link]




## Usage



> **Important**
> We do not pin modules to versions in Cloud Posse's examples because of the
> difficulty of keeping the versions in the documentation in sync with the latest released versions.
> We highly recommend that in your code you pin the version to the exact version you are
> using so that your infrastructure remains stable, and update versions in a
> systematic way so that they do not catch you by surprise.



This module is meant to be used as output only, meaning it will be used to create outputs which are consumed as a parameter by Terraform resources or other modules.

Caution: This module, unlike nearly all other Cloud Posse Terraform modules, does not use [terraform-null-label](https://github.com/cloudposse/terraform-null-label/).
Furthermore, it has an input named `environment` which has a completely different meaning than the one in `terraform-null-label`.
Do not call this module with the conventional `context = module.this.context`. See the documentation below for the usage of `environment`.

For complete examples, see

- [multi-port mappings](examples/multi_port_mappings)
- [multi-type env vars](examples/multi_type_env_vars)
- [multiple definitions](examples/multiple_definitions)
- [string env vars](examples/string_env_vars)

For a complete example with automated tests, see [examples/complete](examples/complete) with `bats` and `Terratest` for the example [test](test).

```hcl
module "container_definition" {
  source = "cloudposse/ecs-container-definition/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"

  container_name  = "geodesic"
  container_image = "cloudposse/geodesic"
}
```

The output of this module can then be used with one of our other modules.

```hcl
module "ecs_alb_service_task" {
  source = "cloudposse/ecs-alb-service-task/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"

  # ...
  container_definition_json = module.container_definition.json_map_encoded_list
  # ...
}
```






<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint terraform code

```
<!-- markdownlint-restore -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.2 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command"></a> [command](#input\_command) | The command that is passed to the container | `list(string)` | `null` | no |
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container\_cpu of all containers in a task will need to be lower than the task-level cpu value | `number` | `0` | no |
| <a name="input_container_definition"></a> [container\_definition](#input\_container\_definition) | Container definition overrides which allows for extra keys or overriding existing keys. | <pre>object({<br>    command = optional(list(string))<br>    cpu     = optional(number)<br>    dependsOn = optional(list(object({<br>      condition     = string<br>      containerName = string<br>    })))<br>    disableNetworking     = optional(bool)<br>    dnsSearchDomains      = optional(list(string))<br>    dnsServers            = optional(list(string))<br>    dockerLabels          = optional(map(string))<br>    dockerSecurityOptions = optional(list(string))<br>    entryPoint            = optional(list(string))<br>    environment = optional(list(object({<br>      name  = string<br>      value = string<br>    })))<br>    environmentFiles = optional(list(object({<br>      type  = string<br>      value = string<br>    })))<br>    essential = optional(bool)<br>    extraHosts = optional(list(object({<br>      hostname  = string<br>      ipAddress = string<br>    })))<br>    firelensConfiguration = optional(object({<br>      options = optional(map(string))<br>      type    = string<br>    }))<br>    healthCheck = optional(object({<br>      command     = list(string)<br>      interval    = optional(number)<br>      retries     = optional(number)<br>      startPeriod = optional(number)<br>      timeout     = optional(number)<br>    }))<br>    hostname    = optional(string)<br>    image       = optional(string)<br>    interactive = optional(bool)<br>    links       = optional(list(string))<br>    linuxParameters = optional(object({<br>      capabilities = optional(object({<br>        add  = optional(list(string))<br>        drop = optional(list(string))<br>      }))<br>      devices = optional(list(object({<br>        containerPath = string<br>        hostPath      = string<br>        permissions   = optional(list(string))<br>      })))<br>      initProcessEnabled = optional(bool)<br>      maxSwap            = optional(number)<br>      sharedMemorySize   = optional(number)<br>      swappiness         = optional(number)<br>      tmpfs = optional(list(object({<br>        containerPath = string<br>        mountOptions  = optional(list(string))<br>        size          = number<br>      })))<br>    }))<br>    logConfiguration = optional(object({<br>      logDriver = string<br>      options   = optional(map(string))<br>      secretOptions = optional(list(object({<br>        name      = string<br>        valueFrom = string<br>      })))<br>    }))<br>    memory            = optional(number)<br>    memoryReservation = optional(number)<br>    mountPoints = optional(list(object({<br>      containerPath = optional(string)<br>      readOnly      = optional(bool)<br>      sourceVolume  = optional(string)<br>    })))<br>    name = optional(string)<br>    portMappings = optional(list(object({<br>      containerPort      = optional(number)<br>      hostPort           = optional(number)<br>      protocol           = optional(string)<br>      name               = optional(string)<br>      appProtocol        = optional(string)<br>      containerPortRange = optional(string)<br>    })))<br>    privileged             = optional(bool)<br>    pseudoTerminal         = optional(bool)<br>    readonlyRootFilesystem = optional(bool)<br>    repositoryCredentials = optional(object({<br>      credentialsParameter = string<br>    }))<br>    resourceRequirements = optional(list(object({<br>      type  = string<br>      value = string<br>    })))<br>    secrets = optional(list(object({<br>      name      = string<br>      valueFrom = string<br>    })))<br>    startTimeout = optional(number)<br>    stopTimeout  = optional(number)<br>    systemControls = optional(list(object({<br>      namespace = string<br>      value     = string<br>    })))<br>    ulimits = optional(list(object({<br>      hardLimit = number<br>      name      = string<br>      softLimit = number<br>    })))<br>    user = optional(string)<br>    volumesFrom = optional(list(object({<br>      readOnly        = optional(bool)<br>      sourceContainer = string<br>    })))<br>    workingDirectory = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_container_depends_on"></a> [container\_depends\_on](#input\_container\_depends\_on) | The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed. The condition can be one of START, COMPLETE, SUCCESS or HEALTHY | <pre>list(object({<br>    condition     = string<br>    containerName = string<br>  }))</pre> | `null` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | The image used to start the container. Images in the Docker Hub registry available by default | `string` | n/a | yes |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container\_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container\_memory of all containers in a task will need to be lower than the task memory value | `number` | `null` | no |
| <a name="input_container_memory_reservation"></a> [container\_memory\_reservation](#input\_container\_memory\_reservation) | The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container\_memory hard limit | `number` | `null` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, \_ allowed) | `string` | n/a | yes |
| <a name="input_disable_networking"></a> [disable\_networking](#input\_disable\_networking) | When this parameter is true, networking is disabled within the container. | `bool` | `null` | no |
| <a name="input_dns_search_domains"></a> [dns\_search\_domains](#input\_dns\_search\_domains) | Container DNS search domains. A list of DNS search domains that are presented to the container | `list(string)` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers | `list(string)` | `null` | no |
| <a name="input_docker_labels"></a> [docker\_labels](#input\_docker\_labels) | The configuration options to send to the `docker_labels` | `map(string)` | `null` | no |
| <a name="input_docker_security_options"></a> [docker\_security\_options](#input\_docker\_security\_options) | A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems. | `list(string)` | `null` | no |
| <a name="input_entrypoint"></a> [entrypoint](#input\_entrypoint) | The entry point that is passed to the container | `list(string)` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment variables to pass to the container. This is a list of maps. map\_environment overrides environment | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `null` | no |
| <a name="input_environment_files"></a> [environment\_files](#input\_environment\_files) | One or more files containing the environment variables to pass to the container. This maps to the --env-file option to docker run. The file must be hosted in Amazon S3. This option is only available to tasks using the EC2 launch type. This is a list of maps | <pre>list(object({<br>    type  = string<br>    value = string<br>  }))</pre> | `null` | no |
| <a name="input_essential"></a> [essential](#input\_essential) | Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value | `bool` | `true` | no |
| <a name="input_extra_hosts"></a> [extra\_hosts](#input\_extra\_hosts) | A list of hostnames and IP address mappings to append to the /etc/hosts file on the container. This is a list of maps | <pre>list(object({<br>    hostname  = string<br>    ipAddress = string<br>  }))</pre> | `null` | no |
| <a name="input_firelens_configuration"></a> [firelens\_configuration](#input\_firelens\_configuration) | The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html | <pre>object({<br>    options = optional(map(string))<br>    type    = string<br>  })</pre> | `null` | no |
| <a name="input_healthcheck"></a> [healthcheck](#input\_healthcheck) | A map containing command (string), timeout, interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy), and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries) | <pre>object({<br>    command     = list(string)<br>    interval    = optional(number)<br>    retries     = optional(number)<br>    startPeriod = optional(number)<br>    timeout     = optional(number)<br>  })</pre> | `null` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The hostname to use for your container. | `string` | `null` | no |
| <a name="input_interactive"></a> [interactive](#input\_interactive) | When this parameter is true, this allows you to deploy containerized applications that require stdin or a tty to be allocated. | `bool` | `null` | no |
| <a name="input_links"></a> [links](#input\_links) | List of container names this container can communicate with without port mappings | `list(string)` | `null` | no |
| <a name="input_linux_parameters"></a> [linux\_parameters](#input\_linux\_parameters) | Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html | <pre>object({<br>    capabilities = optional(object({<br>      add  = optional(list(string))<br>      drop = optional(list(string))<br>    }))<br>    devices = optional(list(object({<br>      containerPath = string<br>      hostPath      = string<br>      permissions   = optional(list(string))<br>    })))<br>    initProcessEnabled = optional(bool)<br>    maxSwap            = optional(number)<br>    sharedMemorySize   = optional(number)<br>    swappiness         = optional(number)<br>    tmpfs = optional(list(object({<br>      containerPath = string<br>      mountOptions  = optional(list(string))<br>      size          = number<br>    })))<br>  })</pre> | `null` | no |
| <a name="input_log_configuration"></a> [log\_configuration](#input\_log\_configuration) | Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html | <pre>object({<br>    logDriver = string<br>    options   = optional(map(string))<br>    secretOptions = optional(list(object({<br>      name      = string<br>      valueFrom = string<br>    })))<br>  })</pre> | `null` | no |
| <a name="input_map_environment"></a> [map\_environment](#input\_map\_environment) | The environment variables to pass to the container. This is a map of string: {key: value}. map\_environment overrides environment | `map(string)` | `null` | no |
| <a name="input_map_secrets"></a> [map\_secrets](#input\_map\_secrets) | The secrets variables to pass to the container. This is a map of string: {key: value}. map\_secrets overrides secrets | `map(string)` | `null` | no |
| <a name="input_mount_points"></a> [mount\_points](#input\_mount\_points) | Container mount points. This is a list of maps, where each map should contain `containerPath`, `sourceVolume` and `readOnly` | <pre>list(object({<br>    containerPath = optional(string)<br>    readOnly      = optional(bool)<br>    sourceVolume  = optional(string)<br>  }))</pre> | `null` | no |
| <a name="input_port_mappings"></a> [port\_mappings](#input\_port\_mappings) | The port mappings to configure for the container. This is a list of maps. Each map should contain "containerPort", "hostPort", and "protocol", where "protocol" is one of "tcp" or "udp". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort | <pre>list(object({<br>    containerPort = number<br>    hostPort      = optional(number)<br>    protocol      = optional(string)<br>    name          = optional(string)<br>    appProtocol   = optional(string)<br>  }))</pre> | `null` | no |
| <a name="input_privileged"></a> [privileged](#input\_privileged) | When this variable is `true`, the container is given elevated privileges on the host container instance (similar to the root user). This parameter is not supported for Windows containers or tasks using the Fargate launch type. | `bool` | `null` | no |
| <a name="input_pseudo_terminal"></a> [pseudo\_terminal](#input\_pseudo\_terminal) | When this parameter is true, a TTY is allocated. | `bool` | `null` | no |
| <a name="input_readonly_root_filesystem"></a> [readonly\_root\_filesystem](#input\_readonly\_root\_filesystem) | Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value | `bool` | `false` | no |
| <a name="input_repository_credentials"></a> [repository\_credentials](#input\_repository\_credentials) | Container repository credentials; required when using a private repo.  This map currently supports a single key; "credentialsParameter", which should be the ARN of a Secrets Manager's secret holding the credentials | <pre>object({<br>    credentialsParameter = string<br>  })</pre> | `null` | no |
| <a name="input_resource_requirements"></a> [resource\_requirements](#input\_resource\_requirements) | The type and amount of a resource to assign to a container. The only supported resource is a GPU. | <pre>list(object({<br>    type  = string<br>    value = string<br>  }))</pre> | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | The secrets to pass to the container. This is a list of maps | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `null` | no |
| <a name="input_start_timeout"></a> [start\_timeout](#input\_start\_timeout) | Time duration (in seconds) to wait before giving up on resolving dependencies for a container | `number` | `null` | no |
| <a name="input_stop_timeout"></a> [stop\_timeout](#input\_stop\_timeout) | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own | `number` | `null` | no |
| <a name="input_system_controls"></a> [system\_controls](#input\_system\_controls) | A list of namespaced kernel parameters to set in the container, mapping to the --sysctl option to docker run. This is a list of maps: { namespace = "", value = ""} | <pre>list(object({<br>    namespace = string<br>    value     = string<br>  }))</pre> | `null` | no |
| <a name="input_ulimits"></a> [ulimits](#input\_ulimits) | Container ulimit settings. This is a list of maps, where each map should contain "name", "hardLimit" and "softLimit" | <pre>list(object({<br>    hardLimit = number<br>    name      = string<br>    softLimit = number<br>  }))</pre> | `null` | no |
| <a name="input_user"></a> [user](#input\_user) | The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group. The default (null) will use the container's configured `USER` directive or root if not set. | `string` | `null` | no |
| <a name="input_volumes_from"></a> [volumes\_from](#input\_volumes\_from) | A list of VolumesFrom maps which contain "sourceContainer" (name of the container that has the volumes to mount) and "readOnly" (whether the container can write to the volume) | <pre>list(object({<br>    readOnly        = optional(bool)<br>    sourceContainer = string<br>  }))</pre> | `null` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | The working directory to run commands inside the container | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_json_map_encoded"></a> [json\_map\_encoded](#output\_json\_map\_encoded) | JSON string encoded container definitions for use with other terraform resources such as aws\_ecs\_task\_definition |
| <a name="output_json_map_encoded_list"></a> [json\_map\_encoded\_list](#output\_json\_map\_encoded\_list) | JSON string encoded list of container definitions for use with other terraform resources such as aws\_ecs\_task\_definition |
| <a name="output_json_map_object"></a> [json\_map\_object](#output\_json\_map\_object) | JSON map encoded container definition |
| <a name="output_sensitive_json_map_encoded"></a> [sensitive\_json\_map\_encoded](#output\_sensitive\_json\_map\_encoded) | JSON string encoded container definitions for use with other terraform resources such as aws\_ecs\_task\_definition (sensitive) |
| <a name="output_sensitive_json_map_encoded_list"></a> [sensitive\_json\_map\_encoded\_list](#output\_sensitive\_json\_map\_encoded\_list) | JSON string encoded list of container definitions for use with other terraform resources such as aws\_ecs\_task\_definition (sensitive) |
| <a name="output_sensitive_json_map_object"></a> [sensitive\_json\_map\_object](#output\_sensitive\_json\_map\_object) | JSON map encoded container definition (sensitive) |
<!-- markdownlint-restore -->


## Related Projects

Check out these related projects.

- [terraform-aws-ecs-codepipeline](https://github.com/cloudposse/terraform-aws-ecs-codepipeline) - Terraform module for CI/CD with AWS Code Pipeline and Code Build for ECS
- [terraform-aws-ecs-events](https://github.com/cloudposse/terraform-aws-ecs-events) - Provides a standard set of ECS events that notify an SNS topic
- [terraform-aws-ecs-cloudwatch-autoscaling](https://github.com/cloudposse/terraform-aws-ecs-cloudwatch-autoscaling) - Terraform module to autoscale ECS Service based on CloudWatch metrics
- [terraform-aws-ecs-container-definition](https://github.com/cloudposse/terraform-aws-ecs-container-definition) - Terraform module to generate well-formed JSON documents (container definitions) that are passed to the aws_ecs_task_definition Terraform resource
- [terraform-aws-ecs-launch-template](https://github.com/cloudposse/terraform-aws-ecs-launch-template) - Terraform module for generating an AWS Launch Template for ECS that handles draining on Spot Termination Requests
- [terraform-aws-ecs-web-app](https://github.com/cloudposse/terraform-aws-ecs-web-app) - Terraform module that implements a web app on ECS and supporting AWS resources
- [terraform-aws-ecs-spot-fleet](https://github.com/cloudposse/terraform-aws-ecs-spot-fleet) - Terraform module to create a diversified spot fleet for ECS clusters
- [terraform-aws-ecs-cloudwatch-sns-alarms](https://github.com/cloudposse/terraform-aws-ecs-cloudwatch-sns-alarms) - Terraform module to create CloudWatch Alarms on ECS Service level metrics
- [terraform-aws-ecs-alb-service-task](https://github.com/cloudposse/terraform-aws-ecs-alb-service-task) - Terraform module which implements an ECS service which exposes a web service via ALB

## ✨ Contributing

This project is under active development, and we encourage contributions from our community. 
Many thanks to our outstanding contributors:

<a href="https://github.com/cloudposse/terraform-aws-ecs-container-definition/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudposse/terraform-aws-ecs-container-definition&max=24" />
</a>

### 🐛 Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/terraform-aws-ecs-container-definition/issues) to report any bugs or file feature requests.

### 💻 Developing

If you are interested in being a contributor and want to get involved in developing this project or [help out](https://cpco.io/help-out) with Cloud Posse's other projects, we would love to hear from you! Shoot us an [email][email].

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!

### 🌎 Slack Community

Join our [Open Source Community][slack] on Slack. It's **FREE** for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build totally *sweet* infrastructure.

### 📰 Newsletter

Sign up for [our newsletter][newsletter] that covers everything on our technology radar.  Receive updates on what we're up to on GitHub as well as awesome new projects we discover.

### 📆 Office Hours <img src="https://img.cloudposse.com/fit-in/200x200/https://cloudposse.com/wp-content/uploads/2019/08/Powered-by-Zoom.png" align="right" />

[Join us every Wednesday via Zoom][office_hours] for our weekly "Lunch & Learn" sessions. It's **FREE** for everyone!

## About 

This project is maintained and funded by [Cloud Posse, LLC][website]. 
<a href="https://cpco.io/homepage"><img src="https://cloudposse.com/logo-300x69.svg" align="right" /></a>

We are a [**DevOps Accelerator**][commercial_support]. We'll help you build your cloud infrastructure from the ground up so you can own it. Then we'll show you how to operate it and stick around for as long as you need us.

[![Learn More](https://img.shields.io/badge/learn%20more-success.svg?style=for-the-badge)][commercial_support]

Work directly with our team of DevOps experts via email, slack, and video conferencing.

We deliver 10x the value for a fraction of the cost of a full-time engineer. Our track record is not even funny. If you want things done right and you need it done FAST, then we're your best bet.

- **Reference Architecture.** You'll get everything you need from the ground up built using 100% infrastructure as code.
- **Release Engineering.** You'll have end-to-end CI/CD with unlimited staging environments.
- **Site Reliability Engineering.** You'll have total visibility into your apps and microservices.
- **Security Baseline.** You'll have built-in governance with accountability and audit logs for all changes.
- **GitOps.** You'll be able to operate your infrastructure via Pull Requests.
- **Training.** You'll receive hands-on training so your team can operate what we build.
- **Questions.** You'll have a direct line of communication between our teams via a Shared Slack channel.
- **Troubleshooting.** You'll get help to triage when things aren't working.
- **Code Reviews.** You'll receive constructive feedback on Pull Requests.
- **Bug Fixes.** We'll rapidly work with you to fix any bugs in our projects.

[![README Commercial Support][readme_commercial_support_img]][readme_commercial_support_link]
## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```

## Trademarks

All other trademarks referenced herein are the property of their respective owners.
---
Copyright © 2017-2024 [Cloud Posse, LLC](https://cpco.io/copyright)
[![README Footer][readme_footer_img]][readme_footer_link]
[![Beacon][beacon]][website]
<!-- markdownlint-disable -->
  [logo]: https://cloudposse.com/logo-300x69.svg
  [docs]: https://cpco.io/docs?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=docs
  [website]: https://cpco.io/homepage?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=website
  [github]: https://cpco.io/github?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=github
  [jobs]: https://cpco.io/jobs?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=jobs
  [hire]: https://cpco.io/hire?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=hire
  [slack]: https://cpco.io/slack?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=slack
  [twitter]: https://cpco.io/twitter?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=twitter
  [office_hours]: https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=office_hours
  [newsletter]: https://cpco.io/newsletter?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=newsletter
  [email]: https://cpco.io/email?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=email
  [commercial_support]: https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=commercial_support
  [we_love_open_source]: https://cpco.io/we-love-open-source?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=we_love_open_source
  [terraform_modules]: https://cpco.io/terraform-modules?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=terraform_modules
  [readme_header_img]: https://cloudposse.com/readme/header/img
  [readme_header_link]: https://cloudposse.com/readme/header/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=readme_header_link
  [readme_footer_img]: https://cloudposse.com/readme/footer/img
  [readme_footer_link]: https://cloudposse.com/readme/footer/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=readme_footer_link
  [readme_commercial_support_img]: https://cloudposse.com/readme/commercial-support/img
  [readme_commercial_support_link]: https://cloudposse.com/readme/commercial-support/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ecs-container-definition&utm_content=readme_commercial_support_link
  [beacon]: https://ga-beacon.cloudposse.com/UA-76589703-4/cloudposse/terraform-aws-ecs-container-definition?pixel&cs=github&cm=readme&an=terraform-aws-ecs-container-definition
<!-- markdownlint-restore -->
