# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "advancedBitLockerStates"      = var.advanced_bit_locker_states
    "deviceName"                   = var.device_name
    "deviceType"                   = var.device_type
    "encryptionPolicySettingState" = var.encryption_policy_setting_state
    "encryptionReadinessState"     = var.encryption_readiness_state
    "encryptionState"              = var.encryption_state
    "fileVaultStates"              = var.file_vault_states
    "@odata.type"                  = var.odata_type
    "osVersion"                    = var.os_version
    "policyDetails"                = (var.policy_details == null ? null : [for item0 in var.policy_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "policyId" = item0["policyId"], "policyName" = item0["policyName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "tpmSpecificationVersion"      = var.tpm_specification_version
    "userPrincipalName"            = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/managedDeviceEncryptionStates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
