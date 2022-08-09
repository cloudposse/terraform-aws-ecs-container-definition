terraform {
  required_version = ">= 0.15.0"

  # https://www.terraform.io/language/expressions/type-constraints#experimental-optional-object-type-attributes
  experiments = [module_variable_optional_attrs]

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 1.2"
    }
  }
}
