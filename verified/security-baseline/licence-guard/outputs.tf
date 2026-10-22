output "tier" {
  description = "The tier after both checks passed. Reference this output rather than your own tier input, so that dependent resources wait for the guard."
  value       = var.tier

  precondition {
    condition     = contains(var.allowed_tiers, var.tier)
    error_message = "tier \"${var.tier}\" is not supported by this module. Allowed tiers: ${join(", ", sort(var.allowed_tiers))}."
  }

  precondition {
    condition     = local.licensed
    error_message = local.licence_error
  }
}

output "licensed_skus" {
  sensitive   = true
  description = "Subscribed SKUs that license the tier: Enabled, with enabled prepaid units, listing the tier's service plan. Each item has sku_id, sku_part_number, capability_status and prepaid_units. Empty for the free tier."
  value       = local.licensed_skus
}
