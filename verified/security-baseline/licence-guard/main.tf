locals {
  # tier_service_plans and tier_plan_names come from plans.tf, generated from the licensing registry.
  service_plans = try(local.tier_service_plans[var.tier], {})
  skus          = try(data.msgraph_resource.subscribed_skus[0].output.skus, [])

  # SKUs that list one of the tier's service plans, whatever their state.
  plan_skus = [
    for sku in local.skus : sku
    if anytrue([for plan in try(sku.servicePlans, []) : contains(keys(local.service_plans), try(lower(plan.servicePlanId), ""))])
  ]

  # Only an Enabled SKU with enabled prepaid units licenses the tier; every other state fails.
  usable = [
    for sku in local.plan_skus : try(sku.capabilityStatus, "") == "Enabled" && try(sku.prepaidUnits.enabled, 0) > 0
  ]

  licensed_skus = [
    for index, sku in local.plan_skus : {
      sku_id            = try(sku.skuId, null)
      sku_part_number   = try(sku.skuPartNumber, null)
      capability_status = sku.capabilityStatus
      prepaid_units     = sku.prepaidUnits
    } if local.usable[index]
  ]

  unusable_skus = [
    for index, sku in local.plan_skus : format("%s (%s, %v enabled units)", try(sku.skuPartNumber, sku.skuId, "unnamed SKU"), try(sku.capabilityStatus, "no capabilityStatus"), try(sku.prepaidUnits.enabled, 0))
    if !local.usable[index]
  ]

  licensed = var.tier == "free" || length(local.licensed_skus) > 0

  licence_error = "Tier ${var.tier} is not licensed: no subscribed SKU with capabilityStatus Enabled and enabled prepaid units lists ${try(local.tier_plan_names[var.tier], var.tier)} (${join(" or ", [for id, name in local.service_plans : "${name} ${id}"])}). ${length(local.unusable_skus) > 0 ? "SKUs that list the plan but do not qualify: ${join(", ", local.unusable_skus)}." : "No subscribed SKU lists the plan."}"
}

# The read depends only on the tier input, never on licence data. subscribedSkus supports
# only $select, so the SKUs are filtered here.
data "msgraph_resource" "subscribed_skus" {
  count = var.tier == "free" ? 0 : 1

  url         = "subscribedSkus"
  api_version = "v1.0"

  query_parameters = {
    "$select" = ["skuId,skuPartNumber,capabilityStatus,prepaidUnits,servicePlans"]
  }

  response_export_values = {
    skus      = "value"
    next_link = "\"@odata.nextLink\""
  }

  lifecycle {
    postcondition {
      condition = try(
        self.output.skus != null && can(concat(self.output.skus, [])) &&
        contains(keys(self.output), "next_link") && self.output.next_link == null &&
        alltrue([for sku in self.output.skus :
          can(concat(sku.servicePlans, [])) && sku.servicePlans != null &&
          alltrue([for plan in sku.servicePlans :
            can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", plan.servicePlanId))
          ]) &&
          sku.capabilityStatus != null && sku.capabilityStatus == tostring(sku.capabilityStatus) &&
          sku.prepaidUnits.enabled != null && sku.prepaidUnits.enabled == tonumber(sku.prepaidUnits.enabled) &&
          sku.prepaidUnits.enabled >= 0 && floor(sku.prepaidUnits.enabled) == sku.prepaidUnits.enabled
        ]), false
      )
      error_message = "The subscription response is malformed, incomplete or still paginated."
    }
  }
}
