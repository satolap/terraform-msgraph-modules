output "tier" {
  description = "The tier after the licence guard passed."
  value       = module.licence_guard.tier
  depends_on  = [msgraph_update_resource.this]
}

output "policy" {
  description = "The adminConsentRequestPolicy as read back after the apply, including the read-only version."
  value       = msgraph_update_resource.this.output.policy
}

output "previous_state" {
  description = "The policy captured before the module first wrote it, without version or OData annotations. restore_previous_state = true PUTs it back."
  value       = terraform_data.previous_state.output
}

output "reviewers" {
  description = "The reviewer objects rendered from the reviewer inputs. While restore_previous_state is true the policy holds previous_state.reviewers instead."
  value       = local.reviewers
}
