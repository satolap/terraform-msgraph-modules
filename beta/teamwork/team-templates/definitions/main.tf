# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "audience"             = var.audience
    "categories"           = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "description"          = var.description
    "displayName"          = var.display_name
    "iconUrl"              = var.icon_url
    "languageTag"          = var.language_tag
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "parentTemplateId"     = var.parent_template_id
    "publisherName"        = var.publisher_name
    "shortDescription"     = var.short_description
    "teamDefinition"       = var.team_definition
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamwork/teamTemplates/${urlencode(var.team_template_id)}/definitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
