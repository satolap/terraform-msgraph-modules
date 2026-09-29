# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "availabilityStatus"   = var.availability_status
    "createdBy"            = (var.created_by == null ? null : { for key0, value0 in { "@odata.type" = var.created_by["odata_type"], "displayName" = var.created_by["displayName"], "email" = var.created_by["email"], "id" = var.created_by["id"] } : key0 => value0 if value0 != null })
    "createdDateTime"      = var.created_date_time
    "description"          = var.description
    "displayName"          = var.display_name
    "durationInMinutes"    = var.duration_in_minutes
    "source"               = var.graph_source
    "hasEvaluation"        = var.has_evaluation
    "languageDetails"      = (var.language_details == null ? null : [for item0 in var.language_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "createdBy" = (item0["createdBy"] == null ? null : { for key2, value2 in { "@odata.type" = item0["createdBy"]["odata_type"], "displayName" = item0["createdBy"]["displayName"], "email" = item0["createdBy"]["email"], "id" = item0["createdBy"]["id"] } : key2 => value2 if value2 != null }), "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isDefaultLangauge" = item0["isDefaultLangauge"], "lastModifiedBy" = (item0["lastModifiedBy"] == null ? null : { for key2, value2 in { "@odata.type" = item0["lastModifiedBy"]["odata_type"], "displayName" = item0["lastModifiedBy"]["displayName"], "email" = item0["lastModifiedBy"]["email"], "id" = item0["lastModifiedBy"]["id"] } : key2 => value2 if value2 != null }), "lastModifiedDateTime" = item0["lastModifiedDateTime"], "locale" = item0["locale"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedBy"       = (var.last_modified_by == null ? null : { for key0, value0 in { "@odata.type" = var.last_modified_by["odata_type"], "displayName" = var.last_modified_by["displayName"], "email" = var.last_modified_by["email"], "id" = var.last_modified_by["id"] } : key0 => value0 if value0 != null })
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "supportedLocales"     = (var.supported_locales == null ? null : [for item0 in var.supported_locales : item0 if item0 != null])
    "tags"                 = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "type"                 = var.type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/attackSimulation/trainings"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
