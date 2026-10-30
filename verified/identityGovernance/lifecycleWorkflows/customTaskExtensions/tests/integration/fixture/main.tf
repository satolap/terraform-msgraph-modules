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
# Existing, owner-prepared Azure fixture only; no Azure infrastructure or role grants.
variable "lifecycle_extension_fixture" {
  type = object({
    logic_app = object({
      subscription_id         = string
      resource_group_name     = string
      logic_app_workflow_name = string
    })
    authentication_resource_id = string
  })
  nullable = false
}
module "extension" {
  source                     = "../../.."
  count                      = var.enabled ? 1 : 0
  display_name               = "tftest-extension-${terraform_data.suffix.output}"
  description                = var.description
  logic_app                  = var.lifecycle_extension_fixture.logic_app
  authentication_resource_id = var.lifecycle_extension_fixture.authentication_resource_id
  timeout_in_milliseconds    = 1000
  maximum_retries            = 0
}
output "expected" {
  value = var.lifecycle_extension_fixture
}
# Independent GET, separate from the module's create/refresh response.
data "msgraph_resource" "item" {
  count                  = var.enabled ? 1 : 0
  url                    = "identityGovernance/lifecycleWorkflows/customTaskExtensions/${module.extension[0].id}"
  response_export_values = { item = "@" }
  retry                  = { error_message_regex = ["(?i)Request_ResourceNotFound|NotFound|404"] }
  timeouts { read = "2m" }
  depends_on = [module.extension]
}
data "msgraph_resource" "remaining" {
  count = var.enabled ? 0 : 1
  url   = "identityGovernance/lifecycleWorkflows/customTaskExtensions"
  query_parameters = {
    "$filter" = ["displayName eq 'tftest-extension-${terraform_data.suffix.output}'"]
  }
  response_export_values = { collection = "@" }
  depends_on             = [module.extension]
}
output "id" {
  value = var.enabled ? module.extension[0].id : null
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
