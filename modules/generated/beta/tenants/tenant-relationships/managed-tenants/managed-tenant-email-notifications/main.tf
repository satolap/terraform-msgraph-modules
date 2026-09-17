# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alert"              = var.alert
    "createdByUserId"    = var.created_by_user_id
    "createdDateTime"    = var.created_date_time
    "emailAddresses"     = (var.email_addresses == null ? null : [for item0 in var.email_addresses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "emailAddress" = item0["emailAddress"] } : key1 => value1 if value1 != null }) if item0 != null])
    "emailBody"          = var.email_body
    "lastActionByUserId" = var.last_action_by_user_id
    "lastActionDateTime" = var.last_action_date_time
    "@odata.type"        = var.odata_type
    "subject"            = var.subject
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managedTenantEmailNotifications"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
