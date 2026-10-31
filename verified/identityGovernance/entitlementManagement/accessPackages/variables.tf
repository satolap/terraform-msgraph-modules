variable "catalog_id" {
  description = "ID of the entitlement management catalog this access package belongs to. The catalog is read-only after creation, so a change replaces the access package: the new one is created in the new catalog before the old one is deleted."
  type        = string
}

variable "displayName" {
  description = "Display name of the access package."
  type        = string

  validation {
    condition     = length(var.displayName) > 0 && length(var.displayName) <= 90
    error_message = "displayName must be between 1 and 90 characters."
  }
}

variable "description" {
  description = "Description of the access package."
  type        = string
  default     = null
}

variable "isHidden" {
  description = "Whether the access package is hidden from the requestor's view."
  type        = bool
  default     = false
}

variable "api_version" {
  description = "Microsoft Graph API version to target for the accessPackages endpoint. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that displayName must match, such as the pattern of a naming convention. When it is set and displayName does not match, the plan fails. Null, the default, accepts any displayName."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}
