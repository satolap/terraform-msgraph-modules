output "tier" {
  description = "The tier after the licence guard and the plan-time checks passed (the input tier during a decommission apply, which checks no licence)."
  value       = var.decommission ? var.tier : module.licence_guard[0].tier

  depends_on = [terraform_data.guard, module.emergency_access]
}

output "policy_ids" {
  description = "Policy object IDs by key: admins, legacy_auth, all_users and azure_management. Empty during a decommission apply."
  value       = { for key, policy in msgraph_resource.policy : key => policy.output.id }
}

output "policy_states" {
  description = "Policy state by key as Graph returned it: enabledForReportingButNotEnforced, or enabled once enforced."
  value       = { for key, policy in msgraph_resource.policy : key => policy.output.state }
}

output "security_defaults_prior_enabled" {
  description = "Whether security defaults were on when the module first applied. Never overwritten by later applies."
  value       = local.security_defaults_prior
}

output "security_defaults_turned_off_by_module" {
  description = "Whether this module's enforce apply turned security defaults off and has not restored them."
  value       = length(msgraph_update_resource.security_defaults_off) > 0
}

output "licensed_skus" {
  sensitive   = true
  description = "Subscribed SKUs that license the tier: Enabled, with enabled prepaid units, listing the tier's service plan (skuPartNumber, capabilityStatus and prepaidUnits among others). Empty during a decommission apply."
  value       = flatten(module.licence_guard[*].licensed_skus)
}
