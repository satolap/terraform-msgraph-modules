# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignmentState"                = var.assignment_state
    "endDateTime"                    = var.end_date_time
    "externalId"                     = var.external_id
    "linkedEligibleRoleAssignmentId" = var.linked_eligible_role_assignment_id
    "memberType"                     = var.member_type
    "@odata.type"                    = var.odata_type
    "resourceId"                     = var.resource_id
    "roleDefinitionId"               = var.role_definition_id
    "startDateTime"                  = var.start_date_time
    "status"                         = var.status
    "subjectId"                      = var.subject_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "governanceResources/${urlencode(var.governance_resource_id)}/roleAssignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
