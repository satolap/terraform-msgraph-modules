# Integration-test helper: provisions an isolated test population, catalog and access package an
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

variable "verified_domain" {
  type        = string
  description = "Verified domain of the commissioned disposable tenant."
}

# Each user gets its own random initial password. A password shared with the approver
# would let the requestor sign in as the approver, set a new password at the forced
# change prompt and approve its own request. Nothing signs in as these users, so the
# passwords stay in this run's state, which terraform test destroys with the users.
resource "random_password" "requestor" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}

resource "random_password" "approver" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}

module "requestor" {
  source = "../../../../../../users"

  userPrincipalName = "tftest-pol-requestor-${random_string.suffix.result}@${var.verified_domain}"
  displayName       = "tftest-policy-requestor-${random_string.suffix.result}"
  mailNickname      = "tftest-pol-requestor-${random_string.suffix.result}"
  password          = random_password.requestor.result
  usageLocation     = "US"
}

module "approver" {
  source = "../../../../../../users"

  userPrincipalName = "tftest-pol-approver-${random_string.suffix.result}@${var.verified_domain}"
  displayName       = "tftest-policy-approver-${random_string.suffix.result}"
  mailNickname      = "tftest-pol-approver-${random_string.suffix.result}"
  password          = random_password.approver.result
  usageLocation     = "US"
}

module "test_population" {
  source = "../../../../../../groups"

  displayName     = "tftest-policy-population-${random_string.suffix.result}"
  mailNickname    = "tftest-pol-population-${random_string.suffix.result}"
  securityEnabled = true
  member_ids      = [module.requestor.id]
}

output "test_population_id" {
  value = module.test_population.id
}

output "approver_id" {
  value = module.approver.id
}

module "catalog" {
  # modules/verified/identityGovernance/entitlementManagement/catalogs, relative to this setup module
  source = "../../../../catalogs"

  displayName = "tftest-pol-catalog-${random_string.suffix.result}"
  description = "Created by terraform test; safe to delete"
}

module "access_package" {
  # modules/verified/identityGovernance/entitlementManagement/accessPackages, relative to this setup module
  source = "../../../../accessPackages"

  catalog_id  = module.catalog.id
  displayName = "tftest-pol-package-${random_string.suffix.result}"
  description = "Created by terraform test; safe to delete"
}

output "suffix" {
  value = random_string.suffix.result
}

output "access_package_id" {
  value = module.access_package.id
}
