# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "commerceSubscriptionId" = var.commerce_subscription_id
    "createdDateTime"        = var.created_date_time
    "isTrial"                = var.is_trial
    "nextLifecycleDateTime"  = var.next_lifecycle_date_time
    "@odata.type"            = var.odata_type
    "ownerId"                = var.owner_id
    "ownerTenantId"          = var.owner_tenant_id
    "ownerType"              = var.owner_type
    "serviceStatus"          = (var.service_status == null ? null : [for item0 in var.service_status : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = item0["appliesTo"], "provisioningStatus" = item0["provisioningStatus"], "servicePlanId" = item0["servicePlanId"], "servicePlanName" = item0["servicePlanName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "skuId"                  = var.sku_id
    "skuPartNumber"          = var.sku_part_number
    "status"                 = var.status
    "totalLicenses"          = var.total_licenses
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/subscriptions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
