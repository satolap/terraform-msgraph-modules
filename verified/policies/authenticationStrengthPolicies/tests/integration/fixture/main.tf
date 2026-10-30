terraform {
  required_version = ">= 1.11.0"
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.6.0, < 0.7.0"
    }
  }
}
variable "enabled" {
  type    = bool
  default = true
}
variable "description" {
  type    = string
  default = "Created by terraform test; safe to delete"
}
# Persist a unique test name without adding a provider dependency.
resource "terraform_data" "suffix" {
  input = substr(uuid(), 0, 8)
  lifecycle {
    ignore_changes = [input]
  }
}
variable "combinations" {
  type    = set(string)
  default = ["fido2"]
}
variable "removed_id" {
  type    = string
  default = null
}
module "policy" {
  source              = "../../.."
  count               = var.enabled ? 1 : 0
  displayName         = "tftest-strength-${terraform_data.suffix.output}"
  description         = var.description
  allowedCombinations = var.combinations
  # No CA policy references this disposable strength; no restriction configurations.
  detached_maintenance = true
}
data "msgraph_resource" "policy" {
  count                  = var.enabled ? 1 : 0
  url                    = "policies/authenticationStrengthPolicies/${module.policy[0].id}"
  response_export_values = { policy = "@" }
  depends_on             = [module.policy]
}
data "msgraph_resource" "remaining" {
  count                  = var.enabled ? 0 : 1
  url                    = "policies/authenticationStrengthPolicies"
  response_export_values = { collection = "@" }
  depends_on             = [module.policy]
}
output "id" {
  value = var.enabled ? module.policy[0].id : null
}
output "policy" {
  value = var.enabled ? data.msgraph_resource.policy[0].output.policy : null
}
output "absent" {
  value = var.enabled ? false : alltrue([
    try(data.msgraph_resource.remaining[0].output.collection["@odata.nextLink"], null) == null,
    !contains([for item in data.msgraph_resource.remaining[0].output.collection.value : item.id], var.removed_id),
  ])
}
