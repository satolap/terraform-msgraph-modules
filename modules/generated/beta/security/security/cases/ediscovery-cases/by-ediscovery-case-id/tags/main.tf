# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "childSelectability"   = var.child_selectability
    "childTags"            = (var.child_tags == null ? null : [for item0 in var.child_tags : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "childSelectability" = item0["childSelectability"], "childTags" = (item0["childTags"] == null ? null : [for item2 in item0["childTags"] : item2 if item2 != null]), "createdBy" = item0["createdBy"], "description" = item0["description"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "parent" = item0["parent"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdBy"            = var.created_by
    "description"          = var.description
    "displayName"          = var.display_name
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "parent"               = var.parent
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/cases/ediscoveryCases/${urlencode(var.ediscovery_case_id)}/tags"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
