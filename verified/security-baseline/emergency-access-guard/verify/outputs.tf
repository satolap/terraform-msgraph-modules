output "verified" {
  description = "True when at least one supported Conditional Access policy was checked and every checked policy excludes all emergency access users and groups. False for the free tier or an empty tenant-scope population."
  value       = nonsensitive(sensitive(var.tier != "free" && length(local.checked_policy_ids) > 0 && length(local.missing_policy_ids) == 0 && length(local.policy_errors) == 0 && length(local.unsupported_policy_ids) == 0))
  depends_on  = [terraform_data.verified]
}

output "verified_policy_ids" {
  sensitive   = true
  description = "IDs of the policies whose exclusions were checked: the baseline policies, plus every enabled policy in tenant scope."
  value       = local.checked_policy_ids
  depends_on  = [terraform_data.verified]
}
