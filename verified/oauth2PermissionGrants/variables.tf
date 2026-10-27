variable "clientId" {
  description = "Client service principal object ID, not its application (client) ID. A different GUID replaces the grant."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.clientId))
    error_message = "clientId must be the client service principal object ID (a GUID)."
  }
}

variable "resourceId" {
  description = "Resource API service principal object ID, not its application (client) ID. A different GUID replaces the grant."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.resourceId))
    error_message = "resourceId must be the resource service principal object ID (a GUID)."
  }
}

variable "consentType" {
  description = "Required explicit Principal or AllPrincipals consent. AllPrincipals grants tenant-wide admin consent and requires acknowledge_all_principals. Changing this replaces the grant."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["Principal", "AllPrincipals"], var.consentType)
    error_message = "consentType must be explicitly Principal or AllPrincipals."
  }
}

variable "principalId" {
  description = "User object GUID required for Principal consent, null for AllPrincipals. A different GUID replaces the grant."
  type        = string
  default     = null

  validation {
    condition     = var.principalId == null ? true : can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.principalId))
    error_message = "principalId must be null or a user object ID (a GUID)."
  }
}

variable "acknowledge_all_principals" {
  description = "Explicit acknowledgement that AllPrincipals grants the configured delegated permissions on behalf of every user in the tenant. Validation only; this is not an authorization credential."
  type        = bool
  default     = false
  nullable    = false
}

variable "scopes" {
  description = "Nonempty set of exact, case-sensitive delegated permission values defined by the resource API's oauth2PermissionScopes. Names must be nonempty and contain no whitespace. Sent sorted with single spaces, at most 3850 characters; changes PATCH the complete scope set in place."
  type        = set(string)
  nullable    = false

  validation {
    condition = alltrue([
      length(var.scopes) > 0,
      alltrue([for scope in var.scopes : scope == null ? false : can(regex("^[^\\s\\p{Z}]+$", scope))]),
    ])
    error_message = "scopes must be a nonempty set of non-null, nonempty scope names without whitespace."
  }

  validation {
    condition     = try(length(join(" ", sort(tolist(var.scopes)))) <= 3850, false)
    error_message = "The rendered space-separated scope string must not exceed 3850 characters."
  }
}
