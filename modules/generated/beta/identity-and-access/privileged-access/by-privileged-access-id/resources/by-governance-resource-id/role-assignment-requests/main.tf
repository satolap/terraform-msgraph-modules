# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignmentState"                = var.assignment_state
    "linkedEligibleRoleAssignmentId" = var.linked_eligible_role_assignment_id
    "@odata.type"                    = var.odata_type
    "reason"                         = var.reason
    "resourceId"                     = var.resource_id
    "roleDefinitionId"               = var.role_definition_id
    "schedule"                       = var.schedule
    "status"                         = var.status
    "subjectId"                      = var.subject_id
    "type"                           = var.type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "privilegedAccess/${urlencode(var.privileged_access_id)}/resources/${urlencode(var.governance_resource_id)}/roleAssignmentRequests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
