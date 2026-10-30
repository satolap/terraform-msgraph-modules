output "names" {
  description = "Every name and description that the naming convention rendered, keyed like the templates: catalog, access_package, administrative_unit, the three groups and their mail nicknames, the two policies, and their descriptions."
  value       = local.names
}

output "name_patterns" {
  description = "The pattern of every name and description, keyed like names: an anchored regular expression in RE2 syntax that the naming convention derives from its template. The composite passes the patterns of the object names to the name_pattern and mail_nickname_pattern inputs of the modules it calls; pass them to other modules to hold their names to the same convention."
  value       = local.patterns
}

output "connected_organization_id" {
  description = "The ID of the connected organization."
  value       = module.connected_organization.id
}

output "identity_sources" {
  description = "The identity sources of the connected organization as sent to Microsoft Graph, with the tenant that the lookup found for each \"tenant_domain\" source."
  value       = module.connected_organization.identity_sources
}

output "catalog_id" {
  description = "The ID of the catalog."
  value       = module.catalog.id
}

output "access_package_id" {
  description = "The ID of the access package."
  value       = module.access_package.id
}

output "my_access_url" {
  description = "The My Access link to the access package, with the tenant hint from my_access_tenant when it is set. Share it with the users of the organization; a hidden access package is reachable only through it."
  value       = local.my_access_url
}

output "group_ids" {
  description = "The object IDs of the groups: guests (the users assigned the access package), external_sponsors and internal_sponsors."
  value = {
    guests            = module.guests_group.id
    external_sponsors = module.external_sponsors_group.id
    internal_sponsors = module.internal_sponsors_group.id
  }
}

output "administrative_unit_id" {
  description = "The ID of the administrative unit that holds the groups, or null when administrative_unit.enabled is false."
  value       = one(module.administrative_unit[*].id)
}

output "requests_policy_id" {
  description = "The ID of the policy through which users of the organization request the access package."
  value       = module.requests_policy.id
}

output "external_sponsor_policy_id" {
  description = "The ID of the external sponsor policy, or null when external_sponsor_policy.enabled is false."
  value       = one(module.external_sponsor_policy[*].id)
}

output "custom_extension_ids" {
  description = "The IDs of the custom extensions, keyed like custom_extensions."
  value       = { for key, extension in module.custom_extensions : key => extension.id }
}

output "invited_user_ids" {
  description = "The object IDs of the guest users that external_sponsor_invitations invited, keyed by email address in lower case."
  value       = local.invited_user_ids
}
