# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountId"                 = var.accountId
    "configureWifi"             = var.configureWifi
    "createdDateTime"           = var.createdDateTime
    "description"               = var.description
    "deviceNameTemplate"        = var.deviceNameTemplate
    "displayName"               = var.displayName
    "enrolledDeviceCount"       = var.enrolledDeviceCount
    "enrollmentMode"            = var.enrollmentMode
    "enrollmentTokenType"       = var.enrollmentTokenType
    "enrollmentTokenUsageCount" = var.enrollmentTokenUsageCount
    "isTeamsDeviceProfile"      = var.isTeamsDeviceProfile
    "lastModifiedDateTime"      = var.lastModifiedDateTime
    "@odata.type"               = var.odata_type
    "qrCodeContent"             = var.qrCodeContent
    "qrCodeImage"               = (var.qrCodeImage == null ? null : { for key0, value0 in { "@odata.type" = var.qrCodeImage["odata_type"], "type" = var.qrCodeImage["type"], "value" = var.qrCodeImage["value"] } : key0 => value0 if value0 != null })
    "roleScopeTagIds"           = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "tokenCreationDateTime"     = var.tokenCreationDateTime
    "tokenExpirationDateTime"   = var.tokenExpirationDateTime
    "tokenValue"                = var.tokenValue
    "wifiHidden"                = var.wifiHidden
    "wifiPassword"              = var.wifiPassword
    "wifiSecurityType"          = var.wifiSecurityType
    "wifiSsid"                  = var.wifiSsid
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/androidDeviceOwnerEnrollmentProfiles"
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
