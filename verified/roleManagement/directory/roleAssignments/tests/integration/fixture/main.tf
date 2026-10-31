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
  source      = "../../../../../../applications"
  displayName = "tftest-client-${terraform_data.suffix.output}"
}
module "client" {
  source = "../../../../../../servicePrincipals"
  appId  = module.client_application.app_id
}
# Organization.Read.All is the governance baseline; no tenant ID input or secret is logged.
data "msgraph_resource" "organization" {
  url                    = "organization"
  response_export_values = { tenants = "value" }
}
# Fixed-name lookup keeps even the replacement selector inside Directory Readers.
data "msgraph_resource" "reader" {
  url = "roleManagement/directory/roleDefinitions"
  query_parameters = {
    "$filter" = ["displayName eq 'Directory Readers'"]
  }
  response_export_values = { roles = "value" }
}
variable "use_role_id" {
  type    = bool
  default = false
}
# Supplied by the completed setup run so the module's lookup count is plan-known.
variable "second_role_definition_id" {
  type     = string
  nullable = false
}
# A second safe tuple permits multiple results; only a Graph nextLink proves pagination.
module "second_assignment" {
  source           = "../../.."
  count            = var.enabled ? 1 : 0
  tenant_id        = one(data.msgraph_resource.organization.output.tenants).id
  principalId      = module.client.id
  roleDefinitionId = var.second_role_definition_id
  role_type        = "custom"
  directoryScopeId = "/"
  scope_type       = "tenant"
}
module "assignment" {
  source            = "../../.."
  count             = var.enabled ? 1 : 0
  tenant_id         = one(data.msgraph_resource.organization.output.tenants).id
  principalId       = module.client.id
  role_display_name = var.use_role_id ? null : "Directory Readers"
  roleDefinitionId  = var.use_role_id ? one(data.msgraph_resource.reader.output.roles).id : null
  role_type         = "built_in"
  directoryScopeId  = "/"
  scope_type        = "tenant"
}
output "expected" {
  value = var.enabled ? { principalId = module.client.id, roleDefinitionId = module.assignment[0].role_definition_id, directoryScopeId = "/" } : null
}
# Independent item GET; do not infer identity from the module's POST response.
data "msgraph_resource" "item" {
  count                  = var.enabled ? 1 : 0
  url                    = "roleManagement/directory/roleAssignments/${module.assignment[0].id}"
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
  count = var.enabled ? 0 : 1
  url   = "roleManagement/directory/roleAssignments"
  query_parameters = {
    "$filter" = ["principalId eq '${module.client.id}'"]
  }
  response_export_values = { collection = "@" }
  depends_on             = [module.assignment, module.client]
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

output "tenant_id" {
  value = one(data.msgraph_resource.organization.output.tenants).id
}
