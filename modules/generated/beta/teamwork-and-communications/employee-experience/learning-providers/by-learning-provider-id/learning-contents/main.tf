# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "additionalTags"       = (var.additional_tags == null ? null : [for item0 in var.additional_tags : item0 if item0 != null])
    "contentWebUrl"        = var.content_web_url
    "contributors"         = (var.contributors == null ? null : [for item0 in var.contributors : item0 if item0 != null])
    "createdDateTime"      = var.created_date_time
    "description"          = var.description
    "duration"             = var.duration
    "externalId"           = var.external_id
    "format"               = var.format
    "isActive"             = var.is_active
    "isPremium"            = var.is_premium
    "isSearchable"         = var.is_searchable
    "languageTag"          = var.language_tag
    "lastModifiedDateTime" = var.last_modified_date_time
    "level"                = var.level
    "numberOfPages"        = var.number_of_pages
    "@odata.type"          = var.odata_type
    "skillTags"            = (var.skill_tags == null ? null : [for item0 in var.skill_tags : item0 if item0 != null])
    "sourceName"           = var.source_name
    "thumbnailWebUrl"      = var.thumbnail_web_url
    "title"                = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "employeeExperience/learningProviders/${urlencode(var.learning_provider_id)}/learningContents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
