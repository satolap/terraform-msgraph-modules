# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "availabilityEndDateTime"   = var.availability_end_date_time
    "availabilityStartDateTime" = var.availability_start_date_time
    "categories"                = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "description"               = var.description
    "displayName"               = var.display_name
    "groupIds"                  = (var.group_ids == null ? null : [for item0 in var.group_ids : item0 if item0 != null])
    "keywords"                  = var.keywords
    "languageTags"              = (var.language_tags == null ? null : [for item0 in var.language_tags : item0 if item0 != null])
    "@odata.type"               = var.odata_type
    "platforms"                 = (var.platforms == null ? null : [for item0 in var.platforms : item0 if item0 != null])
    "powerAppIds"               = (var.power_app_ids == null ? null : [for item0 in var.power_app_ids : item0 if item0 != null])
    "state"                     = var.state
    "targetedVariations"        = (var.targeted_variations == null ? null : [for item0 in var.targeted_variations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "displayName" = item0["displayName"], "languageTag" = item0["languageTag"], "platform" = item0["platform"], "webUrl" = item0["webUrl"] } : key1 => value1 if value1 != null }) if item0 != null])
    "webUrl"                    = var.web_url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "search/bookmarks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
