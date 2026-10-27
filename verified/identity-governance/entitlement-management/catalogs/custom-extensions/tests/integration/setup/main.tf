# Integration-test helper: provisions the catalog the extension lives in, with a
# random suffix so runs against the shared test tenant don't collide.
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

module "catalog" {
  # modules/verified/identity-governance/entitlement-management/catalogs, relative to this setup module
  source = "../../../.."

  display_name = "tftest-extension-catalog-${random_string.suffix.result}"
  description  = "Created by terraform test; safe to delete"
}

output "suffix" {
  value = random_string.suffix.result
}

output "catalog_id" {
  value = module.catalog.id
}
