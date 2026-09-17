output "id" {
  description = "Microsoft Graph object identifier."
  value       = msgraph_resource.this.id
}

output "resource_url" {
  description = "Microsoft Graph URL identifying the managed object."
  value       = msgraph_resource.this.resource_url
}

output "response" {
  description = "Graph response object, including service-specific IDs such as appId when available. May contain secrets."
  value       = msgraph_resource.this.output.response
  sensitive   = true
}
