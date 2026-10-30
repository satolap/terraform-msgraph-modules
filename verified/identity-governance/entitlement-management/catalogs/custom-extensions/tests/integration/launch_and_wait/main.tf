# Module integration helper: independent GET after each callback create/update.
# Nothing here invokes the Logic App.
terraform {
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.5.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.0"
    }
  }
}

variable "catalog_id" {
  type = string
}

variable "display_name" {
  type = string
}

# Set by TF_VAR_logic_app, as for the rest of the suite.
variable "logic_app" {
  type = object({
    subscription_id     = string
    resource_group_name = string
    workflow_name       = string
    trigger_url         = optional(string)
  })
}

variable "timeout" {
  type    = string
  default = "PT1H"
}

module "extension" {
  # modules/verified/identity-governance/entitlement-management/catalogs/custom-extensions,
  # relative to this helper
  source = "../../.."

  catalog_id     = var.catalog_id
  extension_type = "request_workflow"
  logic_app      = var.logic_app
  display_name   = var.display_name
  description    = "Created by terraform test (probe P13); safe to delete"
  callback       = { timeout = var.timeout }
}

resource "time_sleep" "settle" {
  create_duration = "15s"

  triggers = {
    extension_id = module.extension.id
    timeout      = var.timeout
  }
}

data "msgraph_resource" "extension" {
  url         = "identityGovernance/entitlementManagement/catalogs/${lower(var.catalog_id)}/customWorkflowExtensions/${module.extension.id}"
  api_version = "v1.0"

  response_export_values = {
    callback = "callbackConfiguration"
  }

  depends_on = [time_sleep.settle]
}

output "id" {
  value = module.extension.id
}

output "launch_and_wait" {
  value = module.extension.launch_and_wait
}

output "callback" {
  value = try(data.msgraph_resource.extension.output.callback, null)
}
