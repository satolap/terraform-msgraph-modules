# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "following"   = (var.following == null ? null : { for key0, value0 in { "@odata.type" = var.following["odata_type"], "application" = var.following["application"], "audience" = var.following["audience"], "device" = var.following["device"], "group" = var.following["group"], "user" = var.following["user"] } : key0 => value0 if value0 != null })
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/employeeExperience/storyline/followings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
