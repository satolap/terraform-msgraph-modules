output "id" {
  description = "The ID of the access package."
  value       = msgraph_resource.access_package.id
}

output "display_name" {
  description = "The display name of the access package."
  value       = msgraph_resource.access_package.output.display_name
}

output "catalog_id" {
  description = "The ID of the catalog this access package belongs to."
  value       = var.catalog_id
}
