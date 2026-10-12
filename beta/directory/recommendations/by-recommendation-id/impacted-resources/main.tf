# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "addedDateTime"         = var.added_date_time
    "additionalDetails"     = (var.additional_details == null ? null : [for item0 in var.additional_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "key" = item0["key"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "apiUrl"                = var.api_url
    "displayName"           = var.display_name
    "lastModifiedBy"        = var.last_modified_by
    "lastModifiedDateTime"  = var.last_modified_date_time
    "@odata.type"           = var.odata_type
    "owner"                 = var.owner
    "portalUrl"             = var.portal_url
    "postponeUntilDateTime" = var.postpone_until_date_time
    "rank"                  = var.rank
    "recommendationId"      = var.recommendation_id_2
    "resourceType"          = var.resource_type
    "status"                = var.status
    "subjectId"             = var.subject_id
    "tags"                  = (var.tags == null ? null : [for item0 in var.tags : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/recommendations/${urlencode(var.recommendation_id)}/impactedResources"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
