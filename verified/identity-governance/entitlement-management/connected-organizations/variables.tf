variable "display_name" {
  description = "Display name of the connected organization, shown in the admin center and in the connected organization pickers of an assignment policy."
  type        = string
  nullable    = false

  validation {
    condition     = try(length(trimspace(var.display_name)) > 0, false)
    error_message = "display_name must not be empty."
  }
}

variable "description" {
  description = "Description of the connected organization. It is always sent, as null when unset, because an update keeps the properties that its body omits; whether Microsoft Graph accepts a null description is not verified."
  type        = string
  default     = null
}

variable "state" {
  description = "\"configured\" puts the organization in scope of assignment policies that allow all configured connected organizations; \"proposed\" leaves it out of that scope, so only policies that name it specifically apply to its users. Microsoft Learn says an organization created through the API should be configured unless it is set to another state explicitly."
  type        = string
  default     = "configured"
  nullable    = false

  validation {
    condition     = contains(["configured", "proposed"], var.state)
    error_message = "state must be \"configured\" or \"proposed\"."
  }
}

variable "identity_sources" {
  description = <<-EOT
    The directories and domains whose users belong to the connected organization, at least
    one, sent in this order. Each entry has a type:

    - "tenant": a Microsoft Entra tenant by its ID. Set tenant_id (a GUID) and optionally
      display_name. Sent as azureActiveDirectoryTenant.
    - "tenant_domain": a Microsoft Entra tenant found by one of its domain names. Set
      domain_name. The module looks the tenant up at plan time with
      tenantRelationships/findTenantInformationByDomainName and sends an
      azureActiveDirectoryTenant with the tenant ID and name that the lookup returns. A domain
      that belongs to no Microsoft Entra tenant fails the plan; use "domain" for it.
    - "domain": a domain whose users sign in with a one-time passcode, by its name. Set
      domain_name and optionally display_name, which defaults to the domain name. Sent as
      domainIdentitySource.

    Tenant IDs and domain names are sent in lower case, so a change of case alone plans
    nothing. Changing the list updates the organization in place. Cross-cloud tenants,
    SAML/WS-Fed federated domains and social identity sources are not supported.
  EOT
  type = list(object({
    type         = string
    tenant_id    = optional(string)
    domain_name  = optional(string)
    display_name = optional(string)
  }))
  nullable = false

  validation {
    condition     = length(var.identity_sources) > 0
    error_message = "identity_sources must name at least one identity source."
  }

  validation {
    condition     = alltrue([for s in var.identity_sources : try(contains(["tenant", "tenant_domain", "domain"], s.type), false)])
    error_message = "identity_sources[*].type must be one of \"tenant\", \"tenant_domain\" or \"domain\". Cross-cloud tenants, SAML/WS-Fed federated domains and social identity sources are not supported."
  }

  validation {
    condition     = alltrue([for s in var.identity_sources : try(s.type == "tenant" ? can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s.tenant_id)) : s.tenant_id == null, false)])
    error_message = "identity_sources[*].tenant_id must be the ID (a GUID) of a Microsoft Entra tenant for type \"tenant\", and must not be set for the other types: a \"tenant_domain\" source takes its tenant ID from the lookup."
  }

  validation {
    condition     = alltrue([for s in var.identity_sources : try(s.type == "tenant" ? s.domain_name == null : s.domain_name != null, false)])
    error_message = "identity_sources[*].domain_name is required for type \"tenant_domain\" and \"domain\", and must not be set for type \"tenant\"."
  }

  validation {
    condition = alltrue([
      for s in var.identity_sources : try(
        s.domain_name == null ? true : can(regex("^(?i)[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?(?:\\.[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?)+$", s.domain_name)) && length(s.domain_name) <= 253,
        false,
      )
    ])
    error_message = "identity_sources[*].domain_name must be a domain name such as fabrikam.com: at least two labels of letters, digits and hyphens separated by dots, at most 253 characters, with no scheme, @, path or trailing dot."
  }

  validation {
    condition     = alltrue([for s in var.identity_sources : try(s.type == "tenant_domain" ? s.display_name == null : true, false)])
    error_message = "identity_sources[*].display_name must not be set for type \"tenant_domain\": the module sends the tenant name that the lookup returns."
  }

  validation {
    condition     = alltrue([for s in var.identity_sources : try(s.display_name == null ? true : length(trimspace(s.display_name)) > 0, false)])
    error_message = "identity_sources[*].display_name must not be empty when set; leave it null to use the default."
  }

  validation {
    condition = try(
      length(distinct([for s in var.identity_sources : lower(s.tenant_id) if s.tenant_id != null])) == length([for s in var.identity_sources : s if s.tenant_id != null]),
      true,
    )
    error_message = "identity_sources must name each tenant_id at most once."
  }

  validation {
    condition = try(
      length(distinct([for s in var.identity_sources : lower(s.domain_name) if s.domain_name != null])) == length([for s in var.identity_sources : s if s.domain_name != null]),
      true,
    )
    error_message = "identity_sources must name each domain_name at most once, whatever its type or case."
  }
}

variable "internal_sponsor_ids" {
  description = "Object IDs of the users or groups in this tenant that are the internal sponsors of the organization. Microsoft Learn describes internal sponsors as member users; the module does not check the user type. null, the default, leaves the internal sponsors unmanaged. A list is authoritative: missing sponsors are added and others are removed on the next apply, and an empty list removes them all. Changing a list back to null removes the sponsors that the module last managed."
  type        = list(string)
  default     = null

  validation {
    condition     = var.internal_sponsor_ids == null ? true : alltrue([for id in var.internal_sponsor_ids : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", id))])
    error_message = "internal_sponsor_ids must hold object IDs (GUIDs) of users or groups."
  }

  validation {
    condition     = var.internal_sponsor_ids == null ? true : try(length(distinct([for id in var.internal_sponsor_ids : lower(id)])) == length(var.internal_sponsor_ids), true)
    error_message = "internal_sponsor_ids must name each object at most once, whatever its case."
  }
}

variable "external_sponsor_ids" {
  description = "Object IDs of the users or groups in this tenant that are the external sponsors of the organization. Microsoft Learn describes external sponsors as guest users from the connected organization who were invited before; the module does not check the user type. null, the default, leaves the external sponsors unmanaged. A list is authoritative: missing sponsors are added and others are removed on the next apply, and an empty list removes them all. Changing a list back to null removes the sponsors that the module last managed."
  type        = list(string)
  default     = null

  validation {
    condition     = var.external_sponsor_ids == null ? true : alltrue([for id in var.external_sponsor_ids : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", id))])
    error_message = "external_sponsor_ids must hold object IDs (GUIDs) of users or groups."
  }

  validation {
    condition     = var.external_sponsor_ids == null ? true : try(length(distinct([for id in var.external_sponsor_ids : lower(id)])) == length(var.external_sponsor_ids), true)
    error_message = "external_sponsor_ids must name each object at most once, whatever its case."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that display_name must match, such as the pattern of a naming convention. When it is set and display_name does not match, the plan fails. Null, the default, accepts any display_name."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}
