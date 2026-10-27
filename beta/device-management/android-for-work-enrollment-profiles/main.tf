# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountId"               = var.account_id
    "createdDateTime"         = var.created_date_time
    "description"             = var.description
    "displayName"             = var.display_name
    "enrolledDeviceCount"     = var.enrolled_device_count
    "lastModifiedDateTime"    = var.last_modified_date_time
    "@odata.type"             = var.odata_type
    "qrCodeContent"           = var.qr_code_content
    "qrCodeImage"             = (var.qr_code_image == null ? null : { for key0, value0 in { "@odata.type" = var.qr_code_image["odata_type"], "type" = var.qr_code_image["type"], "value" = var.qr_code_image["value"] } : key0 => value0 if value0 != null })
    "tokenExpirationDateTime" = var.token_expiration_date_time
    "tokenValue"              = var.token_value
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/androidForWorkEnrollmentProfiles"
  api_version             = "beta"
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
