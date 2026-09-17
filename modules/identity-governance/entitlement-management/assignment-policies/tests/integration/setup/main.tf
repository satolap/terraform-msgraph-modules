# Integration-test helper: provisions the catalog and access package an
# assignment policy needs, with a random suffix so runs against the shared
# test tenant don't collide.
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

  display_name = "tftest-pol-catalog-${random_string.suffix.result}"
  description  = "Created by terraform test; safe to delete"
}

module "access_package" {
  # modules/identity-governance/entitlement-management/access-packages, relative to this setup module
  source = "../../../../access-packages"

  catalog_id   = module.catalog.id
  display_name = "tftest-pol-package-${random_string.suffix.result}"
  description  = "Created by terraform test; safe to delete"
}

output "suffix" {
  value = random_string.suffix.result
}

output "access_package_id" {
  value = module.access_package.id
}
