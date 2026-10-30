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
variable "description" {
  type    = string
  default = "Created by terraform test; safe to delete"
}
module "definition" {
  source      = "../../.."
  count       = var.enabled ? 1 : 0
  displayName = "tftest-reader-${terraform_data.suffix.output}"
  description = var.description
  isEnabled   = true
  rolePermissions = [{
    allowedResourceActions = ["microsoft.directory/applications/standard/read"]
  }]
}
# Independent item GET; do not infer identity from the module's POST response.
data "msgraph_resource" "item" {
  count                  = var.enabled ? 1 : 0
  url                    = "roleManagement/directory/roleDefinitions/${module.definition[0].id}"
  response_export_values = { item = "@" }
  retry = {
    error_message_regex = ["(?i)Request_ResourceNotFound|NotFound|404"]
  }
  timeouts {
    read = "2m"
  }
  depends_on = [module.definition]
}
# A complete, independently fetched collection proves absence of the saved ID.
# Refuse pagination rather than accepting an incomplete absence check.
data "msgraph_resource" "remaining" {
  count = var.enabled ? 0 : 1
  url   = "roleManagement/directory/roleDefinitions"
  query_parameters = {
    "$filter" = ["displayName eq 'tftest-reader-${terraform_data.suffix.output}'"]
  }
  response_export_values = { collection = "@" }
  depends_on             = [module.definition]
}
output "id" {
  value = var.enabled ? module.definition[0].id : null
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
