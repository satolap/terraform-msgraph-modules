output "id" {
  description = "Object ID of the custom role definition, for a separate role assignment. A replacement changes this ID."
  value       = msgraph_resource.roleDefinition.id
}

output "templateId" {
  description = "Custom template identifier read back from Microsoft Graph."
  value       = msgraph_resource.roleDefinition.output.templateId
}
