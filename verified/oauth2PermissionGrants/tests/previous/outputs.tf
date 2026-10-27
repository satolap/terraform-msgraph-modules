output "id" {
  description = "Opaque Graph ID of the created grant. A replacement changes it."
  value       = terraform_data.owned.input.grantId
}

output "clientId" {
  description = "Normalized client service principal object ID verified by the POST response."
  value       = terraform_data.owned.input.clientId
}

output "resourceId" {
  description = "Normalized resource service principal object ID verified by the POST response."
  value       = terraform_data.owned.input.resourceId
}

output "consentType" {
  description = "Consent type verified by the POST response."
  value       = terraform_data.owned.input.consentType
}

output "principalId" {
  description = "Normalized user object ID, or null for AllPrincipals, verified by the POST response."
  value       = terraform_data.owned.input.principalId
}

output "scope" {
  description = "Configured complete scope string, sorted with single spaces; not independent evidence of effective access."
  value       = local.scope
}

output "owned_state_id" { value = terraform_data.owned.id }
