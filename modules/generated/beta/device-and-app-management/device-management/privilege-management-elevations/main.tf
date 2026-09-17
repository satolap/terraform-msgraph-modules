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

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/privilegeManagementElevations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
