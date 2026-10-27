output "id" {
  description = "Opaque Graph ID of the owned assignment, not the app role GUID. A replacement changes it."
  value       = terraform_data.owned.input.assignmentId
}

output "resourceId" {
  description = "Configured resource service principal object ID, normalized and verified by the POST response postcondition."
  value       = terraform_data.owned.input.resourceId
}

output "principalId" {
  description = "Configured recipient object ID, normalized and verified by the POST response postcondition."
  value       = terraform_data.owned.input.principalId
}

output "appRoleId" {
  description = "Explicit or lookup-derived configured app role GUID, normalized and verified by the POST response postcondition."
  value       = terraform_data.owned.input.appRoleId
}
