output "id" {
  description = "The object ID of the service principal. Use this as resource_origin_id when adding the application to a catalog (resource_origin_system = \"AadApplication\")."
  value       = msgraph_resource.service_principal.id
}

output "app_id" {
  description = "The application (client) ID associated with this service principal."
  value       = msgraph_resource.service_principal.output.app_id
}

output "display_name" {
  description = "The display name exposed by the associated application."
  value       = msgraph_resource.service_principal.output.display_name
}
