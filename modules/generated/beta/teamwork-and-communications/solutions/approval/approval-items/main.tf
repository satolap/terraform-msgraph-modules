# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowEmailNotification" = var.allow_email_notification
    "approvalType"           = var.approval_type
    "approvers"              = (var.approvers == null ? null : [for item0 in var.approvers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "application" = item0["application"], "device" = item0["device"], "group" = item0["group"], "user" = item0["user"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"            = var.description
    "displayName"            = var.display_name
    "@odata.type"            = var.odata_type
    "requests"               = (var.requests == null ? null : [for item0 in var.requests : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "responsePrompts"        = (var.response_prompts == null ? null : [for item0 in var.response_prompts : item0 if item0 != null])
    "responses"              = (var.responses == null ? null : [for item0 in var.responses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "comments" = item0["comments"], "createdBy" = item0["createdBy"], "response" = item0["response"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/approval/approvalItems"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
