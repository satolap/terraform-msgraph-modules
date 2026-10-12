# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignmentFilterManagementType" = var.assignment_filter_management_type
    "createdDateTime"                = var.created_date_time
    "description"                    = var.description
    "displayName"                    = var.display_name
    "lastModifiedDateTime"           = var.last_modified_date_time
    "@odata.type"                    = var.odata_type
    "payloads"                       = (var.payloads == null ? null : [for item0 in var.payloads : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignmentFilterType" = item0["assignmentFilterType"], "groupId" = item0["groupId"], "payloadId" = item0["payloadId"], "payloadType" = item0["payloadType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "platform"                       = var.platform
    "roleScopeTags"                  = (var.role_scope_tags == null ? null : [for item0 in var.role_scope_tags : item0 if item0 != null])
    "rule"                           = var.rule
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/assignmentFilters"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
