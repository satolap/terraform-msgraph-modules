output "tier" {
  description = "The tier after the licence guard and the plan-time checks passed."
  value       = module.licence_guard.tier

  depends_on = [terraform_data.guard]
}

output "managed_urls" {
  description = "Item URLs the module PATCHes, by object: policy, microsoftAuthenticator, fido2 and, when phone_methods is restrict or their restore is requested, sms and voice."
  value       = local.update_urls
}

output "previous_state" {
  sensitive   = true
  description = "Writable properties of all five objects (policy, microsoftAuthenticator, fido2, sms, voice) as read before the first apply. List objects in restore_previous_state to send them back before destroying the module."
  value       = { for key, snapshot in terraform_data.snapshot : key => jsondecode(snapshot.output) }
}

output "policy_migration_state" {
  description = "policyMigrationState of the policy as read at plan time (read only, never written)."
  value       = try(data.msgraph_resource.policy.output.migration_state, null)
}
