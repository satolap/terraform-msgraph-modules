# Outputs that feed other modules depend on the gate, so their consumers wait for the checks.
# Normalize sensitivity before declassifying fixed labels: Terraform 1.5 rejects
# nonsensitive() when its argument was already public. Never declassify raw IDs.

output "exclude_users" {
  sensitive   = true
  description = "Validated resolved user IDs, including discovery-group members, snapshotted for conditions.users.excludeUsers. Later group changes do not automatically change an already applied policy."
  value       = local.resolved_user_ids
  depends_on  = [terraform_data.emergency_access]
}

# Slice the typed discovery-ID list to preserve list(string) while returning no IDs.
output "exclude_groups" {
  sensitive   = true
  description = "Always an empty list(string): discovery groups are never released as mutable Conditional Access exclusions."
  value       = slice(local.group_ids, 0, 0)
  depends_on  = [terraform_data.emergency_access]
}

output "conditional_access_users_exclusions" {
  sensitive   = true
  description = "Snapshot { excludeUsers = validated resolved user IDs, excludeGroups = [] } for conditions.users and the verifier. Group IDs are deliberately excluded."
  value = {
    excludeUsers  = local.resolved_user_ids
    excludeGroups = slice(local.group_ids, 0, 0)
  }
  depends_on = [terraform_data.emergency_access]
}

output "emergency_access_user_ids" {
  sensitive   = true
  description = "All emergency access user IDs: the direct users plus the user members of the groups, without duplicates. For monitoring, and for modules that must leave these accounts alone."
  value       = local.resolved_user_ids
  depends_on  = [terraform_data.emergency_access]
}

output "tier" {
  description = "The tier after the licence guard passed."
  value       = module.licence_guard.tier
  depends_on  = [terraform_data.emergency_access]
}

output "checks" {
  description = "Each check and its result: passed, failed, warning or not_applicable. A failed check also fails the plan."
  # Only fixed public status labels are declassified; identifiers stay sensitive.
  depends_on = [terraform_data.emergency_access]
  value = {
    break_glass_user_ids   = nonsensitive(sensitive("passed"))
    users                  = nonsensitive(sensitive(length(local.user_errors) == 0 ? "passed" : "failed"))
    groups                 = nonsensitive(sensitive(length(local.group_ids) == 0 ? "not_applicable" : length(local.group_errors) == 0 ? "passed" : "failed"))
    expected_group_members = nonsensitive(sensitive(var.expected_group_member_ids == null ? "not_applicable" : length(local.membership_errors) == 0 ? "passed" : "failed"))
    role_assignable_groups = nonsensitive(sensitive(length(local.group_ids) == 0 ? "not_applicable" : length(local.not_role_assignable) == 0 ? "passed" : var.require_role_assignable_group ? "failed" : "warning"))
    minimum_accounts       = nonsensitive(sensitive(local.enough_accounts ? "passed" : "failed"))
    licence                = nonsensitive(sensitive(var.tier == "free" ? "not_applicable" : length(module.licence_guard.licensed_skus) > 0 ? "passed" : "failed"))
  }
}

output "warnings" {
  sensitive   = true
  description = "Findings that do not fail the plan, such as a break-glass group that is not role-assignable while require_role_assignable_group is false."
  value       = local.warnings
  depends_on  = [terraform_data.emergency_access]
}
