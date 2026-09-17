output "id" {
  description = "The object ID of the application registration."
  value       = msgraph_resource.application.id
}

output "app_id" {
  description = "The application (client) ID. Pass this to the service-principals module's app_id to create the matching service principal."
  value       = msgraph_resource.application.output.app_id
}

output "display_name" {
  description = "The display name of the application."
  value       = msgraph_resource.application.output.display_name
}

output "app_role_ids" {
  description = "Map of app role `value` to its `id` (GUID), for use as role_origin_id in the access-packages/resource-role-scopes module."
  value       = { for r in var.app_roles : r.value => r.id }
}
