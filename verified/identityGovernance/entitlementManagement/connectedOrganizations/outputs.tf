output "id" {
  description = "The ID of the connected organization. An update keeps it: every managed property changes in place."
  value       = msgraph_resource.this.id
}

output "display_name" {
  description = "The display name of the connected organization, as configured."
  value       = var.displayName
}

output "state" {
  description = "The state of the connected organization, \"configured\" or \"proposed\", as configured."
  value       = var.state
}

output "identity_sources" {
  description = "The identity sources as the module sends them, in Microsoft Graph's shape and in the order of identity_sources: { \"@odata.type\", tenantId, displayName } for a tenant, with the tenant ID and name that the lookup returned for a \"tenant_domain\" source, and { \"@odata.type\", domainName, displayName } for a domain. Tenant IDs and domain names are in lower case."
  value       = local.identity_sources_body
}

output "internal_sponsor_ids" {
  description = "The object IDs of the internal sponsors that the module manages, in lower case, or null when internal_sponsor_ids is null and the module leaves them alone."
  value       = one(msgraph_resource_collection.internal_sponsors[*].reference_ids)
}

output "external_sponsor_ids" {
  description = "The object IDs of the external sponsors that the module manages, in lower case, or null when external_sponsor_ids is null and the module leaves them alone."
  value       = one(msgraph_resource_collection.external_sponsors[*].reference_ids)
}

output "specific_allowed_target" {
  description = "The organization in the shape of one element of an assignment policy's specific_allowed_targets: { type = \"connectedOrganizationMembers\", id }. A policy with allowed_target_scope \"specificConnectedOrganizationUsers\" that lists it lets the users of this organization request access."
  value = {
    type = "connectedOrganizationMembers"
    id   = msgraph_resource.this.id
  }
}
