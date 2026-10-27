variable "application_id" {
  description = "Object ID (not client/appId) of the existing application. A different GUID replaces this credential; a case-only change does not. The application and its other credentials are not managed here."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.application_id))
    error_message = "application_id must be an application object ID (a GUID), not a client ID selector or URL."
  }
}

variable "name" {
  description = "Unique immutable credential name. Learn requires a URL-friendly name of at most 120 characters. This module conservatively accepts 3 to 120 ASCII letters, digits, hyphens or underscores, starting with a letter or digit. A change replaces the credential, normally deleting the old one first; dependent lifecycle settings can override this (see README)."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9_-]{2,119}$", var.name))
    error_message = "name must be 3 to 120 ASCII letters, digits, hyphens or underscores, starting with a letter or digit (the module's conservative URL-friendly subset)."
  }
}

variable "issuer" {
  description = "External identity provider issuer URL, matching the token's iss claim exactly, including case and trailing slash. Maximum 600 characters. The module accepts an absolute HTTPS URL with a DNS/IPv4 host, optional port and path, without userinfo, query, fragment, whitespace or backslashes. It does not contact the issuer."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.issuer) <= 600 && can(regex("^https://[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?([.][A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?)*(:[0-9]{1,5})?(/[^[:space:]?#\\\\]*)?$", var.issuer))
    error_message = "issuer must be an absolute HTTPS URL of at most 600 characters with a DNS/IPv4 host and optional port/path; userinfo, query, fragment, whitespace and backslashes are not supported."
  }

  validation {
    condition     = alltrue([for port in regexall("^https://[^/]*:([0-9]+)(/|$)", var.issuer) : tonumber(port[0]) >= 1 && tonumber(port[0]) <= 65535])
    error_message = "An explicit issuer port must be between 1 and 65535."
  }
}

variable "subject" {
  description = "External workload subject matching the token's sub claim exactly (case-sensitive), 1 to 600 characters. The issuer/subject pair must be unique within the application. This v1.0 module uses literal subjects, not claimsMatchingExpression."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.subject)) > 0 && length(var.subject) <= 600
    error_message = "subject must be nonempty text of at most 600 characters."
  }
}

variable "audiences" {
  description = "Exactly one nonempty token audience of at most 600 characters. Defaults to api://AzureADTokenExchange, as recommended by Learn for Microsoft Entra ID."
  type        = list(string)
  default     = ["api://AzureADTokenExchange"]
  nullable    = false

  validation {
    condition = length(var.audiences) == 1 && alltrue([
      for audience in var.audiences : audience == null ? false : (length(trimspace(audience)) > 0 && length(audience) <= 600)
    ])
    error_message = "audiences must contain exactly one non-null, nonempty string of at most 600 characters."
  }
}

variable "description" {
  description = "Optional administrative description, at most 600 characters. Null omits it; returning to null does not clear an existing description through the provider's diff-based PATCH."
  type        = string
  default     = null

  validation {
    condition     = var.description == null ? true : length(var.description) <= 600
    error_message = "description must be null or at most 600 characters."
  }
}
