locals {
  odata = {
    endpoint       = "#microsoft.graph.logicAppTriggerEndpointConfiguration"
    authentication = "#microsoft.graph.azureAdTokenAuthentication"
    client         = "#microsoft.graph.customExtensionClientConfiguration"
    callback       = "#microsoft.graph.identityGovernance.customTaskExtensionCallbackConfiguration"
  }

  # Every property that Microsoft Learn documents for creating a custom task extension, except
  # callbackConfiguration.authorizedApps. Learn documents the same properties for the PATCH, so
  # every one of them is updated in place. The for expressions keep a null input out of the body.
  body = merge(
    {
      displayName = var.displayName
      description = var.description
      endpointConfiguration = {
        "@odata.type"        = local.odata.endpoint
        subscriptionId       = var.logic_app.subscriptionId
        resourceGroupName    = var.logic_app.resourceGroupName
        logicAppWorkflowName = var.logic_app.logicAppWorkflowName
      }
      authenticationConfiguration = {
        "@odata.type" = local.odata.authentication
        resourceId    = var.authentication_resource_id
      }
      clientConfiguration = merge(
        {
          "@odata.type"         = local.odata.client
          timeoutInMilliseconds = var.timeout_in_milliseconds
        },
        { for key, value in { maximumRetries = var.maximum_retries } : key => value if value != null },
      )
    },
    {
      for key, value in {
        callbackConfiguration = {
          "@odata.type"   = local.odata.callback
          timeoutDuration = var.callback_timeout_duration
        }
      } : key => value if var.callback_timeout_duration != null
    },
  )
}

# The extension is a configuration record in Microsoft Graph. Creating, updating or deleting it
# does not start the Logic App: Learn describes the call to the Logic App as made by a workflow task
# that references the extension, so a plan or apply of this module does not invoke it. Whether Graph
# changes the Logic App's own authorization settings while creating the extension is not documented
# (Learn requires an Azure role on the Logic App for create and update), so treat the apply as
# possibly touching the Logic App's access configuration.
#
# Every documented create property is also documented for PATCH, so nothing here forces a
# replacement and the provider's PATCH of the changed top-level keys is enough. The resource is an
# ordinary resource, not a request or action resource, so there is no body that must never be
# sent twice.
resource "msgraph_resource" "extension" {
  url         = "identityGovernance/lifecycleWorkflows/customTaskExtensions"
  api_version = "v1.0"
  body        = local.body

  update_method = "PATCH"

  # The read returns the same properties plus createdBy and lastModifiedBy; a configured key that
  # a read does not return keeps its configured value.
  ignore_missing_property = true

  response_export_values = {
    created_date_time       = "createdDateTime"
    last_modified_date_time = "lastModifiedDateTime"
  }

  lifecycle {
    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.displayName))
      error_message = "displayName \"${var.displayName}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set displayName to a value that matches, or change name_pattern."
    }
  }
}
