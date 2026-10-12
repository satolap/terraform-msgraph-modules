# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "content"             = var.content
    "createdDateTime"     = var.created_date_time
    "expirationDateTime"  = var.expiration_date_time
    "explorerViewId"      = var.explorer_view_id
    "goalsOrganizationId" = var.goals_organization_id
    "lastActionDateTime"  = var.last_action_date_time
    "@odata.type"         = var.odata_type
    "resourceLocation"    = var.resource_location
    "status"              = var.status
    "statusDetail"        = var.status_detail
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "employeeExperience/goals/exportJobs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
