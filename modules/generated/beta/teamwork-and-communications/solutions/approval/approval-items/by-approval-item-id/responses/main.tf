# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "comments"    = var.comments
    "createdBy"   = (var.created_by == null ? null : { for key0, value0 in { "@odata.type" = var.created_by["odata_type"], "application" = var.created_by["application"], "device" = var.created_by["device"], "group" = var.created_by["group"], "user" = var.created_by["user"] } : key0 => value0 if value0 != null })
    "@odata.type" = var.odata_type
    "response"    = var.response
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/approval/approvalItems/${urlencode(var.approval_item_id)}/responses"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
