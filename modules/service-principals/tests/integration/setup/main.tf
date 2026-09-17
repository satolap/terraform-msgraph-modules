# Integration-test helper: provisions the application a service principal
# needs, with a random suffix so runs against the shared test tenant don't
# collide on names.
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
    }
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.3.0"
    }
  }
}

resource "random_string" "suffix" {
  length  = 8
  lower   = true
  upper   = false
  numeric = true
  special = false
}

module "application" {
  # modules/applications, relative to this setup module
  source = "../../../../applications"

  display_name = "tftest-sp-app-${random_string.suffix.result}"
  description  = "Created by terraform test; safe to delete"
}

output "suffix" {
  value = random_string.suffix.result
}

output "app_id" {
  value = module.application.app_id
}
