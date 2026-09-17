# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attemptsCount"          = var.attempts_count
    "createdDateTime"        = var.created_date_time
    "error"                  = var.error
    "lastActionDateTime"     = var.last_action_date_time
    "@odata.type"            = var.odata_type
    "operationType"          = var.operation_type
    "status"                 = var.status
    "targetResourceId"       = var.target_resource_id
    "targetResourceLocation" = var.target_resource_location
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/joinedTeams/${urlencode(var.team_id)}/operations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
