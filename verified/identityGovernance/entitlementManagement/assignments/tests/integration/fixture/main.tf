terraform {
  required_version = ">= 1.11.0"
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.6.0, < 0.7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.0, < 1.0.0"
    }
  }
}
variable "enabled" {
  type    = bool
  default = true
}
variable "removed_id" {
  type    = string
  default = null
}
variable "description" {
  type    = string
  default = "Created by terraform test; safe to delete"
}
resource "terraform_data" "suffix" {
  input = substr(uuid(), 0, 8)
  lifecycle {
    ignore_changes = [input]
  }
}
variable "verified_domain" {
  type = string
}
resource "random_password" "recipient" {
  length      = 24
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}
module "recipient" {
  source            = "../../../../../../users"
  userPrincipalName = "tftest-recipient-${terraform_data.suffix.output}@${var.verified_domain}"
  displayName       = "tftest-recipient-${terraform_data.suffix.output}"
  mailNickname      = "tftest-recipient-${terraform_data.suffix.output}"
  password          = random_password.recipient.result
  accountEnabled    = false
}
module "group" {
  source          = "../../../../../../groups"
  displayName     = "tftest-assignment-${terraform_data.suffix.output}"
  mailNickname    = "tftest-assignment-${terraform_data.suffix.output}"
  securityEnabled = true
}
module "catalog" {
  source      = "../../../../catalogs"
  displayName = "tftest-assignment-${terraform_data.suffix.output}"
  description = "Disposable acceptance catalog"
}
module "package" {
  source      = "../../../../accessPackages"
  catalog_id  = module.catalog.id
  displayName = "tftest-assignment-${terraform_data.suffix.output}"
  description = "Disposable group membership only"
  # Destroy the package before the catalog resource: Graph refuses the resource's
  # adminRemove while an access package still exists (GB-live-cleanup-502).
  depends_on = [module.resource]
}
module "resource" {
  source                  = "../../../../catalogs/resources"
  accessPackageCatalog-id = module.catalog.id
  resource_origin_system  = "AadGroup"
  resource_origin_id      = module.group.id
}
module "role_scope" {
  source                 = "../../../../accessPackages/resourceRoleScopes"
  accessPackage-id       = module.package.id
  catalog_id             = module.catalog.id
  catalog_resource_id    = module.resource.resource_id
  resource_origin_system = "AadGroup"
  role_display_name      = "Member"
}
module "policy" {
  source                    = "../../../../assignmentPolicies"
  access_package_id         = module.package.id
  displayName               = "tftest-assignment-${terraform_data.suffix.output}"
  description               = "Only the disabled disposable recipient is eligible"
  allowedTargetScope        = "specificDirectoryUsers"
  specific_allowed_targets  = [{ type = "singleUser", id = module.recipient.id }]
  requestor_settings        = { enableTargetsToSelfAddAccess = false }
  request_approval_settings = { isApprovalRequiredForAdd = false }
  expiration                = { type = "afterDuration", duration_days = 1 }
}
module "assignment" {
  source               = "../../.."
  count                = var.enabled ? 1 : 0
  target_id            = module.recipient.id
  access_package_id    = module.package.id
  assignment_policy_id = module.policy.id
  require_delivery     = true
  depends_on           = [module.role_scope]
}
output "request_id" {
  value = var.enabled ? module.assignment[0].request_id : null
}
output "expected" {
  value = { target = module.recipient.id, package = module.package.id, policy = module.policy.id }
}
# Observe resource membership after the asynchronous grant/revocation; fail closed if it lags.
resource "time_sleep" "settle" {
  create_duration = "30s"
  triggers        = { enabled = tostring(var.enabled) }
  depends_on      = [module.assignment]
}
data "msgraph_resource" "members" {
  url                    = "groups/${module.group.id}/members"
  response_export_values = { collection = "@" }
  depends_on             = [time_sleep.settle]
}
output "member_present" {
  value = contains([for item in data.msgraph_resource.members.output.collection.value : item.id], module.recipient.id)
}
output "membership_complete" {
  value = try(data.msgraph_resource.members.output.collection["@odata.nextLink"], null) == null
}
# Independent GET, separate from the module's create/refresh response.
data "msgraph_resource" "item" {
  count                  = var.enabled ? 1 : 0
  url                    = "identityGovernance/entitlementManagement/assignments/${module.assignment[0].assignment_id}"
  query_parameters       = { "$expand" = ["target,assignmentPolicy,accessPackage"] }
  response_export_values = { item = "@" }
  retry                  = { error_message_regex = ["(?i)Request_ResourceNotFound|NotFound|404"] }
  timeouts { read = "2m" }
  depends_on = [module.assignment]
}
data "msgraph_resource" "remaining" {
  count = var.enabled ? 0 : 1
  url   = "identityGovernance/entitlementManagement/assignments"
  query_parameters = {
    "$filter" = ["accessPackage/id eq '${module.package.id}' and target/objectId eq '${module.recipient.id}'"]
  }
  response_export_values = { collection = "@" }
  depends_on             = [module.assignment]
}
output "id" {
  value = var.enabled ? module.assignment[0].assignment_id : null
}
output "item" {
  value = var.enabled ? data.msgraph_resource.item[0].output.item : null
}
output "absent" {
  value = var.enabled ? false : var.removed_id == null ? false : alltrue([
    try(data.msgraph_resource.remaining[0].output.collection["@odata.nextLink"], null) == null,
    !contains([for item in data.msgraph_resource.remaining[0].output.collection.value : item.id if item.state != "expired"], var.removed_id),
  ])
}
