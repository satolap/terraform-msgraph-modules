output "id" {
  description = "The ID of the access package resource role scope, as returned by the create POST (the entity has no GET-by-id endpoint)."
  value       = try(msgraph_resource_action.resource_role_scope.output.id, null)
}

output "access_package_id" {
  description = "The ID of the access package this role scope is attached to."
  value       = var.accessPackage-id
}

output "role_origin_id" {
  description = "The resolved origin ID of the granted role."
  value       = local.role_origin_id
}

output "resource_origin_id" {
  description = "The origin ID of the underlying resource, as reported by the catalog's resourceRoles list, or by the catalog's resources list for AzureResources."
  value       = local.resource_origin_id
}

output "available_roles" {
  description = "All roles Microsoft Graph reported for the resource in the catalog, useful for diagnosing a failed role match. Empty for AzureResources, whose roles Graph cannot list."
  value       = local.available_roles
}

output "available_scopes" {
  description = "AzureResources only: the scopes Microsoft Graph lists for the catalog resource, the root scope and, for a subscription, its resource groups. Useful for diagnosing a failed scope match; empty for other origin systems."
  value       = local.available_scopes
}
