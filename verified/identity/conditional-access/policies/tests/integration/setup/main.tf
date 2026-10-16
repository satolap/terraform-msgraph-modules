# Integration-test helper: a random suffix, a disabled disposable user that
# stands in for an emergency access account, an empty include group, an empty
# stand-in emergency access group, and one IP and one country named location
# for the policy to reference. This state is destroyed after the policy's, so
# the locations outlive the policy that references them. The policy module retries
# the not-yet-replicated named location error, so the policy created right after
# these locations waits for them; this fixture needs no sleep of its own.
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
    }
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.5.0"
    }
  }
}

variable "verified_domain" {
  type        = string
  description = "Verified domain of the commissioned disposable tenant."
}

# The stand-in emergency access user is disabled and nothing signs in as it. Its own
# random password keeps it from sharing one with any other fixture user, and stays in
# this run's state, which terraform test destroys with the user.
resource "random_password" "break_glass_user" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}

resource "random_string" "suffix" {
  length  = 8
  lower   = true
  upper   = false
  numeric = true
  special = false
}

module "break_glass_user" {
  # modules/verified/users, relative to this setup module
  source = "../../../../../../users"

  user_principal_name = "tftest-ca-bg-${random_string.suffix.result}@${var.verified_domain}"
  display_name        = "tftest-ca-break-glass-${random_string.suffix.result}"
  mail_nickname       = "tftest-ca-bg-${random_string.suffix.result}"
  password            = random_password.break_glass_user.result
  account_enabled     = false
}

module "target_group" {
  # modules/verified/groups; no members, so the policy applies to nobody
  source = "../../../../../../groups"

  display_name  = "tftest-ca-target-${random_string.suffix.result}"
  mail_nickname = "tftest-ca-target-${random_string.suffix.result}"
  description   = "Created by terraform test; safe to delete"
}

module "break_glass_group" {
  source = "../../../../../../groups"

  display_name  = "tftest-ca-bg-group-${random_string.suffix.result}"
  mail_nickname = "tftest-ca-bg-group-${random_string.suffix.result}"
  description   = "Created by terraform test; safe to delete"
}

module "ip_location" {
  # modules/verified/identity/conditional-access/named-locations/ip-ranges
  source = "../../../../named-locations/ip-ranges"

  display_name = "tftest-ca-policy-ip-${random_string.suffix.result}"
  ip_ranges    = ["192.0.2.0/24"]
}

module "country_location" {
  # modules/verified/identity/conditional-access/named-locations/countries
  source = "../../../../named-locations/countries"

  display_name          = "tftest-ca-policy-country-${random_string.suffix.result}"
  countries_and_regions = ["CA"]
}

output "suffix" {
  value = random_string.suffix.result
}

output "break_glass_user_id" {
  value = lower(module.break_glass_user.id)
}

output "target_group_id" {
  value = lower(module.target_group.id)
}

output "break_glass_group_id" {
  value = lower(module.break_glass_group.id)
}

output "ip_location_id" {
  value = lower(module.ip_location.id)
}

output "country_location_id" {
  value = lower(module.country_location.id)
}
