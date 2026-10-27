# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appleId"                 = var.apple_id
    "automaticallyUpdateApps" = var.automatically_update_apps
    "countryOrRegion"         = var.country_or_region
    "expirationDateTime"      = var.expiration_date_time
    "lastModifiedDateTime"    = var.last_modified_date_time
    "lastSyncDateTime"        = var.last_sync_date_time
    "lastSyncStatus"          = var.last_sync_status
    "@odata.type"             = var.odata_type
    "organizationName"        = var.organization_name
    "state"                   = var.state
    "token"                   = var.token
    "vppTokenAccountType"     = var.vpp_token_account_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/vppTokens"
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
