output "id" {
  description = "The object ID of the group. Use this as resource_origin_id when adding the group to a catalog."
  value       = msgraph_resource.group.id
}

output "display_name" {
  description = "The display name of the group."
  value       = msgraph_resource.group.output.display_name
}

output "mail" {
  description = "The SMTP address of the group, if mail-enabled."
  value       = msgraph_resource.group.output.mail
}
