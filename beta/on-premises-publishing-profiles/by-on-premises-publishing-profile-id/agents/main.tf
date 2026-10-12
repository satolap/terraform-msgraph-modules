# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"              = var.odata_type
    "status"                   = var.status
    "supportedPublishingTypes" = (var.supported_publishing_types == null ? null : [for item0 in var.supported_publishing_types : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "onPremisesPublishingProfiles/${urlencode(var.on_premises_publishing_profile_id)}/agents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
