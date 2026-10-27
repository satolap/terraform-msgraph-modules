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
    "@odata.type"          = var.odata_type
    "organizationalUnit"   = var.organizational_unit
    "resourceGroupId"      = var.resource_group_id
    "scopeIds"             = (var.scope_ids == null ? null : [for item0 in var.scope_ids : item0 if item0 != null])
    "subnetId"             = var.subnet_id
    "subscriptionId"       = var.subscription_id
    "virtualNetworkId"     = var.virtual_network_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/onPremisesConnections"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
