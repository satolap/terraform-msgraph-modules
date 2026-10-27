# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "certificatePayload"       = var.certificate_payload
    "companyName"              = var.company_name
    "deviceId"                 = var.device_id
    "deviceName"               = var.device_name
    "elevationType"            = var.elevation_type
    "eventDateTime"            = var.event_date_time
    "fileDescription"          = var.file_description
    "filePath"                 = var.file_path
    "fileVersion"              = var.file_version
    "hash"                     = var.hash
    "internalName"             = var.internal_name
    "justification"            = var.justification
    "@odata.type"              = var.odata_type
    "parentProcessName"        = var.parent_process_name
    "policyId"                 = var.policy_id
    "policyName"               = var.policy_name
    "processType"              = var.process_type
    "productName"              = var.product_name
    "result"                   = var.result
    "ruleId"                   = var.rule_id
    "systemInitiatedElevation" = var.system_initiated_elevation
    "upn"                      = var.upn
    "userType"                 = var.user_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/privilegeManagementElevations"
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
