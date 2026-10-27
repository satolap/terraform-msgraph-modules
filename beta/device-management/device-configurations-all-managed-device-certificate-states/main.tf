# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "certificateExpirationDateTime"             = var.certificate_expiration_date_time
    "certificateExtendedKeyUsages"              = var.certificate_extended_key_usages
    "certificateIssuanceDateTime"               = var.certificate_issuance_date_time
    "certificateIssuerName"                     = var.certificate_issuer_name
    "certificateKeyUsages"                      = var.certificate_key_usages
    "certificateRevokeStatus"                   = var.certificate_revoke_status
    "certificateRevokeStatusLastChangeDateTime" = var.certificate_revoke_status_last_change_date_time
    "certificateSerialNumber"                   = var.certificate_serial_number
    "certificateSubjectName"                    = var.certificate_subject_name
    "certificateThumbprint"                     = var.certificate_thumbprint
    "managedDeviceDisplayName"                  = var.managed_device_display_name
    "@odata.type"                               = var.odata_type
    "userPrincipalName"                         = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceConfigurationsAllManagedDeviceCertificateStates"
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
