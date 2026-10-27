# Integration-test helper for the launch and wait callback probe
# (GB-entitlement-management-519). The module sends no callback yet, so this helper
# creates a request workflow extension directly: the body the module sends, plus the
# callbackConfiguration that a launch and wait extension carries, with the duration
# named durationBeforeTimeout as in Microsoft Learn's entitlement management
# examples. It then waits and reads the extension back with a fresh GET, so the
# test sees which name and form Graph keeps. Nothing here invokes the Logic App.
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

resource "msgraph_resource" "extension" {
  url           = "identityGovernance/entitlementManagement/catalogs/${lower(var.catalog_id)}/customWorkflowExtensions"
  api_version   = "v1.0"
  update_method = "PUT"

  body = {
    "@odata.type" = "#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension"
    displayName   = var.display_name
    description   = "Created by terraform test (callback probe); safe to delete"
    endpointConfiguration = merge(
      {
        "@odata.type"        = "#microsoft.graph.logicAppTriggerEndpointConfiguration"
        subscriptionId       = var.logic_app.subscription_id
        resourceGroupName    = var.logic_app.resource_group_name
        logicAppWorkflowName = var.logic_app.workflow_name
      },
      var.logic_app.trigger_url == null ? {} : { url = var.logic_app.trigger_url },
    )
    authenticationConfiguration = {
      "@odata.type" = "#microsoft.graph.azureAdPopTokenAuthentication"
    }
    callbackConfiguration = {
      "@odata.type"         = "#microsoft.graph.customExtensionCallbackConfiguration"
      durationBeforeTimeout = var.timeout
    }
  }

  response_export_values = {
    callback = "callbackConfiguration"
  }
}

resource "time_sleep" "settle" {
  create_duration = "15s"

  triggers = {
    extension_id = msgraph_resource.extension.id
  }
}

data "msgraph_resource" "extension" {
  url         = "identityGovernance/entitlementManagement/catalogs/${lower(var.catalog_id)}/customWorkflowExtensions/${msgraph_resource.extension.id}"
  api_version = "v1.0"

  response_export_values = {
    callback = "callbackConfiguration"
  }

  depends_on = [time_sleep.settle]
}

output "id" {
  value = msgraph_resource.extension.id
}

output "created_callback" {
  value = try(msgraph_resource.extension.output.callback, null)
}

output "read_back_callback" {
  value = try(data.msgraph_resource.extension.output.callback, null)
}
