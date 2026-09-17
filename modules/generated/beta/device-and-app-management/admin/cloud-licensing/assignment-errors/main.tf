# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignedTo"         = (var.assigned_to == null ? null : { for key0, value0 in { "@odata.type" = var.assigned_to["odata_type"], "deletedDateTime" = var.assigned_to["deletedDateTime"] } : key0 => value0 if value0 != null })
    "code"               = var.code
    "message"            = var.message
    "occurrenceDateTime" = var.occurrence_date_time
    "@odata.type"        = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/cloudLicensing/assignmentErrors"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
