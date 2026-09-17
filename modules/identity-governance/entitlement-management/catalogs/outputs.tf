output "id" {
  description = "The ID of the entitlement management catalog."
  value       = msgraph_resource.catalog.id
}

output "display_name" {
  description = "The display name of the entitlement management catalog."
  value       = msgraph_resource.catalog.output.display_name
}

output "state" {
  description = "The published state of the entitlement management catalog."
  value       = msgraph_resource.catalog.output.state
}

output "catalog_type" {
  description = "The type of the entitlement management catalog."
  value       = msgraph_resource.catalog.output.catalog_type
}
