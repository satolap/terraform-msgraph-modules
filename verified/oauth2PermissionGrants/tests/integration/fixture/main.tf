terraform {
  required_version = ">= 1.11.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
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
  source       = "../../../../applications"
  display_name = "tftest-client-${terraform_data.suffix.output}"
}
module "client" {
  source = "../../../../service-principals"
  app_id = module.client_application.app_id
}
variable "verified_domain" {
  type = string
}
variable "scopes" {
  type    = set(string)
  default = ["tftest.read"]
}
resource "random_password" "user" {
  length      = 24
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}
module "user" {
  source              = "../../../../users"
  user_principal_name = "tftest-grant-${terraform_data.suffix.output}@${var.verified_domain}"
  display_name        = "tftest-grant-${terraform_data.suffix.output}"
  mail_nickname       = "tftest-grant-${terraform_data.suffix.output}"
  password            = random_password.user.result
  account_enabled     = false
}
resource "terraform_data" "scope_ids" {
  input = [uuid(), uuid()]
  lifecycle {
    ignore_changes = [input]
  }
}
# Verified applications does not expose api.oauth2PermissionScopes. This fixture
# owns the entire disposable API, never PATCHes an existing application.
resource "msgraph_resource" "resource_application" {
  url = "applications"
  body = {
    displayName    = "tftest-api-${terraform_data.suffix.output}"
    signInAudience = "AzureADMyOrg"
    api = {
      oauth2PermissionScopes = [for index, value in ["tftest.read", "tftest.inspect"] : {
        id                      = terraform_data.scope_ids.output[index]
        value                   = value
        type                    = "Admin"
        isEnabled               = true
        adminConsentDisplayName = value
        adminConsentDescription = "Disposable API only; no downstream access"
      }]
    }
  }
  response_export_values = { app_id = "appId" }
}
# msgraph_resource plans output as unknown on any in-place update, and the
# service-principals module replaces its service principal when app_id changes
# (GB-msgraph-provider-614). Replacing the resource service principal changes
# the grant's resourceId, which re-keys the grant. Pin appId, which never
# changes for an application, and feed the pin's input, not its output.
resource "terraform_data" "resource_app_id" {
  input            = msgraph_resource.resource_application.output.app_id
  triggers_replace = msgraph_resource.resource_application.id

  lifecycle {
    ignore_changes = [input]
  }
}
module "resource" {
  source = "../../../../service-principals"
  app_id = terraform_data.resource_app_id.input
}
module "grant" {
  source      = "../../.."
  count       = var.enabled ? 1 : 0
  clientId    = module.client.id
  resourceId  = module.resource.id
  consentType = "Principal"
  principalId = module.user.id
  scopes      = var.scopes
}
output "expected" {
  value = { clientId = module.client.id, resourceId = module.resource.id, principalId = module.user.id }
}
# Independent item GET; do not infer identity from the module's POST response.
data "msgraph_resource" "item" {
  count                  = var.enabled ? 1 : 0
  url                    = "oauth2PermissionGrants/${module.grant[0].id}"
  response_export_values = { item = "@" }
  retry = {
    error_message_regex = ["(?i)Request_ResourceNotFound|NotFound|404"]
  }
  timeouts {
    read = "2m"
  }
  depends_on = [module.grant]
}
# A complete, independently fetched collection proves absence of the saved ID.
# Refuse pagination rather than accepting an incomplete absence check.
data "msgraph_resource" "remaining" {
  count = var.enabled ? 0 : 1
  url   = "oauth2PermissionGrants"
  query_parameters = {
    "$filter" = ["clientId eq '${module.client.id}'"]
  }
  response_export_values = { collection = "@" }
  depends_on             = [module.grant, module.client]
}
output "id" {
  value = var.enabled ? module.grant[0].id : null
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
