output "id" {
  description = "The captured directory role assignment ID; deterministic for the same tuple, not proof of a unique creation. Identical out-of-band re-creation is indistinguishable."
  value       = msgraph_resource.assignment.id
  depends_on  = [terraform_data.verification]
}

output "role_definition_id" {
  description = "The directory-specific role definition ID resolved by the read-only lookup."
  value       = local.role_id
}

output "request_body" {
  description = "The direct assignment request in Graph casing. Contains identifiers, no credentials."
  value       = local.request_body
}
