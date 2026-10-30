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
variable "removed_id" {
  type    = string
  default = null
}
resource "terraform_data" "suffix" {
  input = substr(uuid(), 0, 8)
  lifecycle {
    ignore_changes = [input]
  }
}
# No keys, passwords, redirect URIs, federated credentials or Graph permissions.
module "client_application" {
  source       = "../../../../../applications"
  display_name = "tftest-client-${terraform_data.suffix.output}"
}
module "client" {
  source = "../../../../../service-principals"
  app_id = module.client_application.app_id
}
resource "terraform_data" "role_id" {
  input = uuid()
  lifecycle {
    ignore_changes = [input]
  }
}
module "resource_application" {
  source       = "../../../../../applications"
  display_name = "tftest-api-${terraform_data.suffix.output}"
  app_roles = [{
    id                   = terraform_data.role_id.output
    display_name         = "tftest read"
    description          = "Disposable API only; no downstream access"
    value                = "tftest.read"
    allowed_member_types = ["Application"]
    is_enabled           = true
  }]
}
module "resource" {
  source = "../../../../../service-principals"
  app_id = module.resource_application.app_id
}
module "assignment" {
  source       = "../../.."
  count        = var.enabled ? 1 : 0
  resourceId   = module.resource.id
  principalId  = module.client.id
  appRoleValue = "tftest.read"
}
output "expected" {
  value = { resourceId = module.resource.id, principalId = module.client.id, appRoleId = terraform_data.role_id.output }
}
# Independent item GET; do not infer identity from the module's POST response.
data "msgraph_resource" "item" {
  count                  = var.enabled ? 1 : 0
  url                    = "servicePrincipals/${module.resource.id}/appRoleAssignedTo/${module.assignment[0].id}"
  response_export_values = { item = "@" }
  retry = {
    error_message_regex = ["(?i)Request_ResourceNotFound|NotFound|404"]
  }
  timeouts {
    read = "2m"
  }
  depends_on = [module.assignment]
}
# A complete, independently fetched collection proves absence of the saved ID.
# Refuse pagination rather than accepting an incomplete absence check.
data "msgraph_resource" "remaining" {
  count                  = var.enabled ? 0 : 1
  url                    = "servicePrincipals/${module.resource.id}/appRoleAssignedTo"
  response_export_values = { collection = "@" }
  depends_on             = [module.assignment, module.resource]
}
output "id" {
  value = var.enabled ? module.assignment[0].id : null
}
output "item" {
  value = var.enabled ? data.msgraph_resource.item[0].output.item : null
}
output "absent" {
  value = var.enabled ? false : var.removed_id == null ? false : alltrue([
    try(data.msgraph_resource.remaining[0].output.collection["@odata.nextLink"], null) == null,
    !contains([for item in data.msgraph_resource.remaining[0].output.collection.value : item.id], var.removed_id),
  ])
}
