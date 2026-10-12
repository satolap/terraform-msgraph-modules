# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "addressableUserName"          = var.addressable_user_name
    "azureActiveDirectoryDeviceId" = var.azure_active_directory_device_id
    "displayName"                  = var.display_name
    "enrollmentState"              = var.enrollment_state
    "groupTag"                     = var.group_tag
    "lastContactedDateTime"        = var.last_contacted_date_time
    "managedDeviceId"              = var.managed_device_id
    "manufacturer"                 = var.manufacturer
    "model"                        = var.model
    "@odata.type"                  = var.odata_type
    "productKey"                   = var.product_key
    "purchaseOrderIdentifier"      = var.purchase_order_identifier
    "resourceName"                 = var.resource_name
    "serialNumber"                 = var.serial_number
    "skuNumber"                    = var.sku_number
    "systemFamily"                 = var.system_family
    "userPrincipalName"            = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/windowsAutopilotDeviceIdentities"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
