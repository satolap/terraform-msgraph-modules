# Integration-test helper: provisions the catalog an access package needs,
# with a random suffix so runs against the shared test tenant don't collide.
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
  # modules/identity-governance/entitlement-management/catalogs, relative to this setup module
  source = "../../../../catalogs"

  display_name = "tftest-ap-catalog-${random_string.suffix.result}"
  description  = "Created by terraform test; safe to delete"
}

output "suffix" {
  value = random_string.suffix.result
}

output "catalog_id" {
  value = module.catalog.id
}
