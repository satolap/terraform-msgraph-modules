# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "clientRegistrationStatus" = var.client_registration_status
    "deviceName"               = var.device_name
    "deviceType"               = var.device_type
    "entitySource"             = var.entity_source
    "managementAgents"         = var.management_agents
    "managementState"          = var.management_state
    "manufacturer"             = var.manufacturer
    "mdmStatus"                = var.mdm_status
    "model"                    = var.model
    "@odata.type"              = var.odata_type
    "osDescription"            = var.os_description
    "osVersion"                = var.os_version
    "ownerType"                = var.owner_type
    "referenceId"              = var.reference_id
    "serialNumber"             = var.serial_number
    "status"                   = var.status
    "upn"                      = var.upn
    "userEmail"                = var.user_email
    "userId"                   = var.user_id
    "userName"                 = var.user_name
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
