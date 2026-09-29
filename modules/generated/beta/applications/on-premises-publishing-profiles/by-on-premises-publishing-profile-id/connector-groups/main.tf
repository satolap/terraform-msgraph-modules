# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "applications"       = (var.applications == null ? null : [for item0 in var.applications : item0 if item0 != null])
    "connectorGroupType" = var.connector_group_type
    "members"            = (var.members == null ? null : [for item0 in var.members : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "machineName" = item0["machineName"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "name"               = var.name
    "@odata.type"        = var.odata_type
    "region"             = var.region
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "onPremisesPublishingProfiles/${urlencode(var.on_premises_publishing_profile_id)}/connectorGroups"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
