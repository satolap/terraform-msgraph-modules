# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountId"        = var.account_id
    "accountName"      = var.account_name
    "appliesTo"        = var.applies_to
    "capabilityStatus" = var.capability_status
    "consumedUnits"    = var.consumed_units
    "@odata.type"      = var.odata_type
    "prepaidUnits"     = (var.prepaid_units == null ? null : { for key0, value0 in { "@odata.type" = var.prepaid_units["odata_type"], "enabled" = var.prepaid_units["enabled"], "lockedOut" = var.prepaid_units["lockedOut"], "suspended" = var.prepaid_units["suspended"], "warning" = var.prepaid_units["warning"] } : key0 => value0 if value0 != null })
    "servicePlans"     = (var.service_plans == null ? null : [for item0 in var.service_plans : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = item0["appliesTo"], "provisioningStatus" = item0["provisioningStatus"], "servicePlanId" = item0["servicePlanId"], "servicePlanName" = item0["servicePlanName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "skuId"            = var.sku_id
    "skuPartNumber"    = var.sku_part_number
    "subscriptionIds"  = (var.subscription_ids == null ? null : [for item0 in var.subscription_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "subscribedSkus"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
