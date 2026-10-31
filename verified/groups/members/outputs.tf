output "id" {
  description = "The provider's ID of the managed collection, groups/{group-id}/members. A reference to it waits until the membership is applied."
  value       = msgraph_resource_collection.this.id
}

output "group_id" {
  description = "The object ID of the group, in lower case."
  value       = local.group_id
}

output "member_ids" {
  description = "The object IDs of the direct members that the module manages, in lower case, as the managed collection holds them. Order is not significant. A reference to it waits until the membership is applied."
  value       = msgraph_resource_collection.this.reference_ids
}
