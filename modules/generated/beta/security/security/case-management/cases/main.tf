# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activities"           = (var.activities == null ? null : [for item0 in var.activities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "attachments"          = (var.attachments == null ? null : [for item0 in var.attachments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "fileExtension" = item0["fileExtension"], "fileSize" = item0["fileSize"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "origin" = item0["origin"], "scanResult" = item0["scanResult"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "customFields"         = var.custom_fields
    "displayName"          = var.display_name
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "relations"            = (var.relations == null ? null : [for item0 in var.relations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "relatedResourceId" = item0["relatedResourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "status"               = var.status
    "tasks"                = (var.tasks == null ? null : [for item0 in var.tasks : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignedTo" = item0["assignedTo"], "category" = item0["category"], "closingNotes" = item0["closingNotes"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "dueDateTime" = item0["dueDateTime"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "priority" = item0["priority"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/caseManagement/cases"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
