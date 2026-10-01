output "id" {
  description = "The ID of the assignment policy."
  value       = msgraph_resource.assignment_policy.id
}

output "display_name" {
  description = "The display name of the assignment policy."
  value       = msgraph_resource.assignment_policy.output.display_name
}

output "access_package_id" {
  description = "The ID of the access package this policy is attached to."
  value       = var.access_package_id
}

output "custom_extension_stage_settings" {
  description = "The custom extension bindings of the policy as Microsoft Graph returned them on the last read, as { stage, extension_id } in the order Graph returned them. It includes bindings that custom_extension_stage_settings does not declare, which the next apply removes. It is null when Graph returned no stage settings, because the read did not expand them, and never a list inferred from such a read."
  value       = local.read_back_stage_settings
}
