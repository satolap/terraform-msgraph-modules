output "settings" {
  description = "The entitlementManagementSettings as read back after the apply."
  value       = msgraph_update_resource.this.output.settings
}

output "previous_state" {
  description = "Both settings as read before the module first wrote them, without id or OData annotations. restore_previous_state = true PATCHes the owned ones back."
  value       = terraform_data.previous_state.output
}

output "owned_properties" {
  description = "The Graph property names this module owns: those whose input is not null. Properties not listed are never written."
  value       = sort(keys(local.owned_input))
}

output "drifted_properties" {
  description = "Owned properties whose value in the read taken at plan time differs from the input, so the apply writes them. Compared exactly, as the provider compares, so empty means no change unless the service returns another spelling of the enum than the input, which shows as drift on every plan. During restore_previous_state it compares against the inputs, not the snapshot."
  value       = local.drifted_properties
}
