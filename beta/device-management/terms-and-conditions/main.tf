# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "acceptanceStatement"  = var.acceptance_statement
    "acceptanceStatuses"   = (var.acceptance_statuses == null ? null : [for item0 in var.acceptance_statuses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "acceptedDateTime" = item0["acceptedDateTime"], "acceptedVersion" = item0["acceptedVersion"], "termsAndConditions" = item0["termsAndConditions"], "userDisplayName" = item0["userDisplayName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"          = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "bodyText"             = var.body_text
    "createdDateTime"      = var.created_date_time
    "description"          = var.description
    "displayName"          = var.display_name
    "version"              = var.graph_version
    "groupAssignments"     = (var.group_assignments == null ? null : [for item0 in var.group_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "targetGroupId" = item0["targetGroupId"], "termsAndConditions" = item0["termsAndConditions"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedDateTime" = var.last_modified_date_time
    "modifiedDateTime"     = var.modified_date_time
    "@odata.type"          = var.odata_type
    "roleScopeTagIds"      = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "title"                = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/termsAndConditions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
