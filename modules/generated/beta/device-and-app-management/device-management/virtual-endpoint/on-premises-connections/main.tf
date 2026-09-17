# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "adDomainName"         = var.ad_domain_name
    "adDomainPassword"     = var.ad_domain_password
    "adDomainUsername"     = var.ad_domain_username
    "alternateResourceUrl" = var.alternate_resource_url
    "connectionType"       = var.connection_type
    "displayName"          = var.display_name
    "healthCheckStatus"    = var.health_check_status
    "managedBy"            = var.managed_by
    "@odata.type"          = var.odata_type
    "organizationalUnit"   = var.organizational_unit
    "resourceGroupId"      = var.resource_group_id
    "scopeIds"             = (var.scope_ids == null ? null : [for item0 in var.scope_ids : item0 if item0 != null])
    "subnetId"             = var.subnet_id
    "subscriptionId"       = var.subscription_id
    "type"                 = var.type
    "virtualNetworkId"     = var.virtual_network_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/onPremisesConnections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
