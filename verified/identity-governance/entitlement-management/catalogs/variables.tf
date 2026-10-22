variable "display_name" {
  description = "Display name of the entitlement management catalog."
  type        = string

  validation {
    condition     = length(var.display_name) > 0 && length(var.display_name) <= 90
    error_message = "display_name must be between 1 and 90 characters."
  }
}

variable "description" {
  description = "Description of the entitlement management catalog."
  type        = string
  default     = null
}

variable "is_externally_visible" {
  description = "Whether users outside the tenant, such as users of a connected organization, can request the access packages of the catalog (isExternallyVisible). An access package also needs a policy for them. null leaves the property out of the request: Microsoft Graph documents no default, and the Microsoft Entra admin center enables it for a new catalog. Changing true or false back to null keeps the last value in Microsoft Graph."
  type        = bool
  default     = null
}

variable "state" {
  description = "Whether the catalog is published and available for management. One of \"unpublished\" or \"published\"."
  type        = string
  default     = "unpublished"

  validation {
    condition     = contains(["unpublished", "published"], var.state)
    error_message = "state must be one of \"unpublished\" or \"published\"."
  }
}

variable "catalog_type" {
  description = "Deprecated and ignored; remove it. The create request does not take catalogType, so the module no longer sends it. Microsoft Learn describes catalogType as whether a user or entitlement management created the catalog, and its create example returns \"userManaged\"; the catalog_type output reads the value back. Only \"userManaged\", the former default, is accepted, so that existing callers keep working."
  type        = string
  default     = "userManaged"

  validation {
    condition     = contains(["userManaged"], var.catalog_type)
    error_message = "catalog_type is deprecated and accepts only \"userManaged\": the create request does not take catalogType, and a catalog that this module creates is created by a user, not by entitlement management. Remove catalog_type."
  }
}

variable "api_version" {
  description = "Microsoft Graph API version to target for the catalogs endpoint. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
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
