output "prior_values" {
  description = "The snapshot captured before the first apply, keyed by Graph property path; a property that was null is not restored. Unknown until the first apply."
  value       = { for key, value in terraform_data.snapshot.output : key => jsondecode(value) }
}

output "target_values" {
  description = "The values the module sets with the current inputs, keyed by Graph property path: the baseline, or the snapshot when restore_prior_values is true."
  value       = { for key, value in local.effective : key => jsondecode(value) }
}

output "planned_changes" {
  description = "Each property whose current tenant value differs from the target, as JSON text: property, current and target. Review it at plan time."
  value       = local.planned_changes
}

output "tier" {
  description = "The tier after the licence guard passed. Reference it so dependent resources wait for the guard and the policy update."
  value       = module.licence_guard.tier
  depends_on  = [msgraph_update_resource.policy]
}
