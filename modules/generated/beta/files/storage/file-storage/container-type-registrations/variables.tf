variable "application_permission_grants" {
  description = "Access privileges of applications on containers."
  type = list(object({
    odata_type             = optional(string, "#microsoft.graph.fileStorageContainerTypeAppPermissionGrant")
    appId                  = optional(string)
    applicationPermissions = optional(any)
    delegatedPermissions   = optional(any)
  }))
  default = null
}

variable "billing_classification" {
  description = "Microsoft Graph billingClassification property."
  type        = string
  default     = null

  validation {
    condition     = var.billing_classification == null ? true : contains(["standard", "trial", "directToCustomer", "unknownFutureValue"], var.billing_classification)
    error_message = "billing_classification must be one of the documented enum values."
  }
}

variable "billing_status" {
  description = "Microsoft Graph billingStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.billing_status == null ? true : contains(["invalid", "valid", "unknownFutureValue"], var.billing_status)
    error_message = "billing_status must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.fileStorageContainerTypeRegistration"
  nullable    = false
}

variable "settings" {
  description = "Microsoft Graph settings property."
  type = object({
    odata_type                    = optional(string, "#microsoft.graph.fileStorageContainerTypeRegistrationSettings")
    isDiscoverabilityEnabled      = optional(bool)
    isItemVersioningEnabled       = optional(bool)
    isOfficeRestricted            = optional(bool)
    isSearchEnabled               = optional(bool)
    isSharingRestricted           = optional(bool)
    itemMajorVersionLimit         = optional(number)
    maxStoragePerContainerInBytes = optional(number)
    sharingCapability             = optional(any)
    urlTemplate                   = optional(string)
  })
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["etag", "expirationDateTime", "id", "name", "owningAppId", "registeredDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
