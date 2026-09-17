# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "configuration" = var.configuration
    "features"      = (var.features == null ? null : { for key0, value0 in { "@odata.type" = var.features["odata_type"], "allowOnPremUpdateOfOnPremisesObjectIdentifierEnabled" = var.features["allowOnPremUpdateOfOnPremisesObjectIdentifierEnabled"], "blockCloudObjectTakeoverThroughHardMatchEnabled" = var.features["blockCloudObjectTakeoverThroughHardMatchEnabled"], "blockSoftMatchEnabled" = var.features["blockSoftMatchEnabled"], "bypassDirSyncOverridesEnabled" = var.features["bypassDirSyncOverridesEnabled"], "cloudPasswordPolicyForPasswordSyncedUsersEnabled" = var.features["cloudPasswordPolicyForPasswordSyncedUsersEnabled"], "concurrentCredentialUpdateEnabled" = var.features["concurrentCredentialUpdateEnabled"], "concurrentOrgIdProvisioningEnabled" = var.features["concurrentOrgIdProvisioningEnabled"], "deviceWritebackEnabled" = var.features["deviceWritebackEnabled"], "directoryExtensionsEnabled" = var.features["directoryExtensionsEnabled"], "fopeConflictResolutionEnabled" = var.features["fopeConflictResolutionEnabled"], "groupWriteBackEnabled" = var.features["groupWriteBackEnabled"], "passwordSyncEnabled" = var.features["passwordSyncEnabled"], "passwordWritebackEnabled" = var.features["passwordWritebackEnabled"], "quarantineUponProxyAddressesConflictEnabled" = var.features["quarantineUponProxyAddressesConflictEnabled"], "quarantineUponUpnConflictEnabled" = var.features["quarantineUponUpnConflictEnabled"], "softMatchOnUpnEnabled" = var.features["softMatchOnUpnEnabled"], "synchronizeUpnForManagedUsersEnabled" = var.features["synchronizeUpnForManagedUsersEnabled"], "unifiedGroupWritebackEnabled" = var.features["unifiedGroupWritebackEnabled"], "userForcePasswordChangeOnLogonEnabled" = var.features["userForcePasswordChangeOnLogonEnabled"], "userWritebackEnabled" = var.features["userWritebackEnabled"] } : key0 => value0 if value0 != null })
    "@odata.type"   = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/onPremisesSynchronization"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
