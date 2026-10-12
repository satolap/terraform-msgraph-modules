output "request_id" {
  description = "The ID of the accessPackageResourceRequest that added this resource to the catalog."
  value       = try(msgraph_resource_action.add_request.output.request_id, null)
}

output "resource_id" {
  description = "The ID of the accessPackageResource within the catalog (distinct from resource_origin_id), captured from the post-add verification read. Pass this as catalog_resource_id to the access-packages/resource-role-scopes module. Null if verification did not find the resource."
  value       = local.matched_resource_id
}

output "resource_origin_id" {
  description = "The origin ID of the resource, as passed in."
  value       = var.resource_origin_id
}

output "verified" {
  description = "Whether the post-add verification read confirmed the resource is present in the catalog."
  value       = local.verified
}
