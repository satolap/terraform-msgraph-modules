variable "catalog_id" {
  description = "ID of the entitlement management catalog this access package belongs to."
  type        = string
}

variable "display_name" {
  description = "Display name of the access package."
  type        = string

  validation {
    condition     = length(var.display_name) > 0 && length(var.display_name) <= 90
    error_message = "display_name must be between 1 and 90 characters."
  }
}

variable "description" {
  description = "Description of the access package."
  type        = string
  default     = null
}

variable "is_hidden" {
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
