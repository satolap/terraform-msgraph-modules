# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName" = var.display_name
    "finishDate"  = var.finish_date
    "notes"       = (var.notes == null ? null : { for key0, value0 in { "@odata.type" = var.notes["odata_type"], "content" = var.notes["content"], "contentType" = var.notes["contentType"] } : key0 => value0 if value0 != null })
    "@odata.type" = var.odata_type
    "planId"      = var.plan_id
    "priority"    = var.priority
    "startDate"   = var.start_date
    "status"      = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "planner/goals"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
