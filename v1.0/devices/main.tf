# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountEnabled"         = var.accountEnabled
    "alternativeSecurityIds" = (var.alternativeSecurityIds == null ? null : [for item0 in var.alternativeSecurityIds : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "identityProvider" = item0["identityProvider"], "key" = item0["key"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deletedDateTime"        = var.deletedDateTime
    "deviceCategory"         = var.deviceCategory
    "deviceId"               = var.deviceId
    "deviceMetadata"         = var.deviceMetadata
    "deviceOwnership"        = var.deviceOwnership
    "deviceVersion"          = var.deviceVersion
    "displayName"            = var.displayName
    "enrollmentProfileName"  = var.enrollmentProfileName
    "enrollmentType"         = var.enrollmentType
    "isManaged"              = var.isManaged
    "isRooted"               = var.isRooted
    "managementType"         = var.managementType
    "@odata.type"            = var.odata_type
    "operatingSystem"        = var.operatingSystem
    "operatingSystemVersion" = var.operatingSystemVersion
    "physicalIds"            = (var.physicalIds == null ? null : [for item0 in var.physicalIds : item0 if item0 != null])
    "profileType"            = var.profileType
    "systemLabels"           = (var.systemLabels == null ? null : [for item0 in var.systemLabels : item0 if item0 != null])
    "transitiveMemberOf"     = (var.transitiveMemberOf == null ? null : [for item0 in var.transitiveMemberOf : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "devices"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["transitiveMemberOf"], name)])]))))] } : null

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
