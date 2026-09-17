# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionReason"       = var.action_reason
    "appId"              = var.app_id
    "azureTenantId"      = var.azure_tenant_id
    "clientContext"      = var.client_context
    "completedDateTime"  = var.completed_date_time
    "createdDateTime"    = var.created_date_time
    "errorInfo"          = var.error_info
    "lastActionDateTime" = var.last_action_date_time
    "name"               = var.name
    "@odata.type"        = var.odata_type
    "parameters"         = (var.parameters == null ? null : [for item0 in var.parameters : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "states"             = (var.states == null ? null : [for item0 in var.states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appId" = item0["appId"], "status" = item0["status"], "updatedDateTime" = item0["updatedDateTime"], "user" = item0["user"] } : key1 => value1 if value1 != null }) if item0 != null])
    "status"             = var.status
    "user"               = var.user
    "vendorInformation"  = var.vendor_information
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/securityActions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
