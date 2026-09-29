# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "associations"          = (var.associations == null ? null : [for item0 in var.associations : item0 if item0 != null])
    "description"           = var.description
    "version"               = var.graph_version
    "isCustomProfile"       = var.is_custom_profile
    "lastModifiedDateTime"  = var.last_modified_date_time
    "name"                  = var.name
    "@odata.type"           = var.odata_type
    "policies"              = (var.policies == null ? null : [for item0 in var.policies : item0 if item0 != null])
    "priority"              = var.priority
    "servicePrincipal"      = var.service_principal
    "state"                 = var.state
    "trafficForwardingType" = var.traffic_forwarding_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/forwardingProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
