output "id" {
  description = "The object ID of the administrative unit. It changes when is_member_management_restricted changes, because that replaces the unit."
  value       = msgraph_resource.this.id
}

output "directory_scope_id" {
  description = "The scope of a Microsoft Entra role assignment that is limited to this unit, /administrativeUnits/{id}: the directoryScopeId of a unifiedRoleAssignment."
  value       = "/administrativeUnits/${msgraph_resource.this.id}"
}

output "display_name" {
  description = "The display name of the unit, as configured."
  value       = var.display_name
}

output "is_member_management_restricted" {
  description = "Whether the unit is a restricted management administrative unit."
  value       = var.is_member_management_restricted
}

output "membership_type" {
  description = "\"Assigned\" or \"Dynamic\"."
  value       = var.membership_type
}

output "visibility" {
  description = "Null for a public unit, or \"HiddenMembership\"."
  value       = var.visibility
}

output "scoped_role_member_ids" {
  description = "The IDs of the scopedRoleMembership objects that the module created, keyed like scoped_role_members. Empty when scoped_role_members is empty."
  value       = { for key, resource in msgraph_resource.scoped_role_member : key => resource.id }
}

output "member_ids" {
  description = "The member IDs that the module manages, in lower case, read from the member collection, so a reference to this output waits until the members are added. Null when member_ids is null and the members are not managed."
  value       = one(msgraph_resource_collection.members[*].reference_ids)
}
