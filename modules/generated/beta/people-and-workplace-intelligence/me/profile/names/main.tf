# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedAudiences"     = var.allowed_audiences
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "displayName"          = var.display_name
    "first"                = var.first
    "source"               = (var.graph_source == null ? null : { for key0, value0 in { "@odata.type" = var.graph_source["odata_type"], "type" = (var.graph_source["type"] == null ? null : [for item1 in var.graph_source["type"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "inference"            = (var.inference == null ? null : { for key0, value0 in { "@odata.type" = var.inference["odata_type"], "confidenceScore" = var.inference["confidenceScore"], "userHasVerifiedAccuracy" = var.inference["userHasVerifiedAccuracy"] } : key0 => value0 if value0 != null })
    "initials"             = var.initials
    "isSearchable"         = var.is_searchable
    "languageTag"          = var.language_tag
    "last"                 = var.last
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "maiden"               = var.maiden
    "middle"               = var.middle
    "nickname"             = var.nickname
    "@odata.type"          = var.odata_type
    "pronunciation"        = (var.pronunciation == null ? null : { for key0, value0 in { "@odata.type" = var.pronunciation["odata_type"], "displayName" = var.pronunciation["displayName"], "first" = var.pronunciation["first"], "last" = var.pronunciation["last"], "maiden" = var.pronunciation["maiden"], "middle" = var.pronunciation["middle"] } : key0 => value0 if value0 != null })
    "sources"              = (var.sources == null ? null : [for item0 in var.sources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isDefaultSource" = item0["isDefaultSource"], "properties" = (item0["properties"] == null ? null : [for item2 in item0["properties"] : item2 if item2 != null]), "sourceId" = item0["sourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "suffix"               = var.suffix
    "title"                = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/profile/names"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
