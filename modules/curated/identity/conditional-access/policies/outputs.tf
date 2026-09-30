output "id" {
  description = "The ID of the Conditional Access policy. It changes when an optional part (locations, platforms, device_filter, grant_controls, its authentication strength, or a session control) is added or removed, because that replaces the policy. It also changes when grant_controls.authentication_strength_id is not known at plan time, for example the id of a strength created or replaced in the same apply."
  value       = msgraph_resource.policy.id
}

output "display_name" {
  description = "The display name Microsoft Graph returned on the last read."
  value       = msgraph_resource.policy.output.display_name
}

output "state" {
  description = "The policy state Microsoft Graph returned on the last read."
  value       = msgraph_resource.policy.output.state
}

output "excluded_user_ids" {
  description = "conditions.users.excludeUsers as Microsoft Graph returned it on the last read: GUIDs lower-cased, sorted. Includes the break-glass users."
  value       = try(sort([for s in msgraph_resource.policy.output.exclude_users : can(regex(local.guid, s)) ? lower(s) : s]), [])
}

output "excluded_group_ids" {
  description = "conditions.users.excludeGroups as Microsoft Graph returned it on the last read: lower-cased, sorted. Includes the break-glass groups."
  value       = try(sort([for s in msgraph_resource.policy.output.exclude_groups : lower(s)]), [])
}

output "optional_parts_not_in_configuration" {
  description = "Optional parts (for example conditions.locations or sessionControls.persistentBrowser) that Microsoft Graph returned on the last read but the configuration does not set, such as a part added outside Terraform. An in-place apply cannot remove them; replace the policy with terraform apply -replace. Empty when the policy matches the configuration."
  value       = local.server_presence == null ? [] : sort(tolist(setsubtract(local.server_presence, local.presence)))
}

output "unmanaged_properties_set" {
  description = "Properties this module does not manage (for example conditions.users.excludeGuestsOrExternalUsers) that Microsoft Graph returned set on the last read, as JSON paths, sorted. A replacement creates the policy from the configuration only and loses their values. Empty when none is set."
  value       = local.unmanaged_set
}
