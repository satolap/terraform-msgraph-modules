# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"           = var.odata_type
    "assignments"           = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "intent" = item0["intent"], "settings" = item0["settings"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "categories"            = (var.categories == null ? null : [for item0 in var.categories : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"           = var.description
    "developer"             = var.developer
    "displayName"           = var.display_name
    "informationUrl"        = var.information_url
    "isFeatured"            = var.is_featured
    "largeIcon"             = (var.large_icon == null ? null : { for key0, value0 in { "@odata.type" = var.large_icon["odata_type"], "type" = var.large_icon["type"], "value" = var.large_icon["value"] } : key0 => value0 if value0 != null })
    "notes"                 = var.notes
    "owner"                 = var.owner
    "privacyInformationUrl" = var.privacy_information_url
    "publisher"             = var.publisher
    "relationships"         = (var.relationships == null ? null : [for item0 in var.relationships : item0 if item0 != null])
    "roleScopeTagIds"       = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/mobileApps"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
