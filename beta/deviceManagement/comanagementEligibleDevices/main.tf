# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "clientRegistrationStatus" = var.clientRegistrationStatus
    "deviceName"               = var.deviceName
    "deviceType"               = var.deviceType
    "entitySource"             = var.entitySource
    "managementAgents"         = var.managementAgents
    "managementState"          = var.managementState
    "manufacturer"             = var.manufacturer
    "mdmStatus"                = var.mdmStatus
    "model"                    = var.model
    "@odata.type"              = var.odata_type
    "osDescription"            = var.osDescription
    "osVersion"                = var.osVersion
    "ownerType"                = var.ownerType
    "referenceId"              = var.referenceId
    "serialNumber"             = var.serialNumber
    "status"                   = var.status
    "upn"                      = var.upn
    "userEmail"                = var.userEmail
    "userId"                   = var.userId
    "userName"                 = var.userName
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/comanagementEligibleDevices"
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
