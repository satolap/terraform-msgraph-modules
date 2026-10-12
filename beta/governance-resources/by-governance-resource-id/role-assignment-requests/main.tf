# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignmentState"                = var.assignment_state
    "linkedEligibleRoleAssignmentId" = var.linked_eligible_role_assignment_id
    "@odata.type"                    = var.odata_type
    "reason"                         = var.reason
    "resourceId"                     = var.resource_id
    "roleDefinitionId"               = var.role_definition_id
    "schedule"                       = (var.schedule == null ? null : { for key0, value0 in { "@odata.type" = var.schedule["odata_type"], "duration" = var.schedule["duration"], "endDateTime" = var.schedule["endDateTime"], "startDateTime" = var.schedule["startDateTime"], "type" = var.schedule["type"] } : key0 => value0 if value0 != null })
    "status"                         = (var.status == null ? null : { for key0, value0 in { "@odata.type" = var.status["odata_type"], "status" = var.status["status"], "statusDetails" = (var.status["statusDetails"] == null ? null : [for item1 in var.status["statusDetails"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "key" = item1["key"], "value" = item1["value"] } : key2 => value2 if value2 != null }) if item1 != null]), "subStatus" = var.status["subStatus"] } : key0 => value0 if value0 != null })
    "subjectId"                      = var.subject_id
    "type"                           = var.type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "governanceResources/${urlencode(var.governance_resource_id)}/roleAssignmentRequests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
