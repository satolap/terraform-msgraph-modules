# Integration-test helper: generates a random suffix so repeated or concurrent
# test runs against the shared test tenant don't collide on names.
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
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

output "suffix" {
  value = random_string.suffix.result
}
