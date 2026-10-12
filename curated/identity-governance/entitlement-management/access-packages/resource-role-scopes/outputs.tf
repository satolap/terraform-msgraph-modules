output "id" {
  description = "The ID of the access package resource role scope, as returned by the create POST (the entity has no GET-by-id endpoint)."
  value       = try(msgraph_resource_action.resource_role_scope.output.id, null)
}

output "access_package_id" {
  description = "The ID of the access package this role scope is attached to."
  value       = var.access_package_id
}

output "role_origin_id" {
  description = "The resolved origin ID of the granted role."
  value       = local.role_origin_id
}

output "resource_origin_id" {
  description = "The origin ID of the underlying resource, as reported by the catalog's resourceRoles list."
  value       = local.resource_origin_id
}

output "available_roles" {
  description = "All roles Microsoft Graph reported for the resource in the catalog, useful for diagnosing a failed role match."
  value       = local.available_roles
}
