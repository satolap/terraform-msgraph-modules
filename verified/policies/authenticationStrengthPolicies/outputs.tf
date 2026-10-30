output "id" {
  description = "Verified created custom policy ID, for grantControls.authenticationStrength.id in a Conditional Access policy."
  value       = terraform_data.owned.input.policyId
  depends_on  = [msgraph_resource_action.remove, data.msgraph_resource.current]
}

output "combinationConfigurationIds" {
  description = "Created configuration IDs keyed by the authentication method combination."
  value       = { for key, configuration in msgraph_resource.configuration : key => configuration.id }
}

output "combinationUpdateResult" {
  description = "Graph action result, including any conditionalAccessReferences and additionalInformation security impact warning."
  value       = msgraph_resource_action.combinations.output.result
}

output "licence_tier" {
  description = "The licence tier that was checked: p1 when licence_check is true, otherwise free (nothing is read). Reference this output to order resources after the check."
  value       = module.licence_guard.tier
}
