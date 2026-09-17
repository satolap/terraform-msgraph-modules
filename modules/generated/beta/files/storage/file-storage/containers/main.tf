# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "archivalDetails"          = var.archival_details
    "assignedSensitivityLabel" = var.assigned_sensitivity_label
    "columns"                  = (var.columns == null ? null : [for item0 in var.columns : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "boolean" = item0["boolean"], "calculated" = item0["calculated"], "choice" = item0["choice"], "columnGroup" = item0["columnGroup"], "contentApprovalStatus" = item0["contentApprovalStatus"], "currency" = item0["currency"], "dateTime" = item0["dateTime"], "defaultValue" = item0["defaultValue"], "description" = item0["description"], "displayName" = item0["displayName"], "enforceUniqueValues" = item0["enforceUniqueValues"], "geolocation" = item0["geolocation"], "hidden" = item0["hidden"], "hyperlinkOrPicture" = item0["hyperlinkOrPicture"], "indexed" = item0["indexed"], "isDeletable" = item0["isDeletable"], "isSealed" = item0["isSealed"], "isSearchable" = item0["isSearchable"], "lookup" = item0["lookup"], "name" = item0["name"], "number" = item0["number"], "personOrGroup" = item0["personOrGroup"], "propagateChanges" = item0["propagateChanges"], "readOnly" = item0["readOnly"], "required" = item0["required"], "sourceColumn" = item0["sourceColumn"], "sourceContentType" = item0["sourceContentType"], "term" = item0["term"], "text" = item0["text"], "thumbnail" = item0["thumbnail"], "validation" = item0["validation"] } : key1 => value1 if value1 != null }) if item0 != null])
    "customProperties"         = var.custom_properties
    "description"              = var.description
    "displayName"              = var.display_name
    "externalGroupId"          = var.external_group_id
    "informationBarrier"       = var.information_barrier
    "migrationJobs"            = (var.migration_jobs == null ? null : [for item0 in var.migration_jobs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "containerInfo" = (item0["containerInfo"] == null ? null : { for key2, value2 in { "@odata.type" = item0["containerInfo"]["odata_type"] } : key2 => value2 if value2 != null }), "progressEvents" = (item0["progressEvents"] == null ? null : [for item2 in item0["progressEvents"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"              = var.odata_type
    "permissions"              = (var.permissions == null ? null : [for item0 in var.permissions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "expirationDateTime" = item0["expirationDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "settings"                 = (var.settings == null ? null : { for key0, value0 in { "@odata.type" = var.settings["odata_type"], "isItemVersioningEnabled" = var.settings["isItemVersioningEnabled"], "isOcrEnabled" = var.settings["isOcrEnabled"], "itemDefaultSensitivityLabelId" = var.settings["itemDefaultSensitivityLabelId"], "itemMajorVersionLimit" = var.settings["itemMajorVersionLimit"] } : key0 => value0 if value0 != null })
    "sharePointGroups"         = (var.share_point_groups == null ? null : [for item0 in var.share_point_groups : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "members" = (item0["members"] == null ? null : [for item2 in item0["members"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "identity" = item2["identity"] } : key3 => value3 if value3 != null }) if item2 != null]), "title" = item0["title"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "storage/fileStorage/containers"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
