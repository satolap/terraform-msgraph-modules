variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcServicePlan"
  nullable    = false
}

variable "provisioning_type" {
  description = "Specifies the type of license used when provisioning Cloud PCs. By default, the license type is dedicated. The possible values are: dedicated, shared, unknownFutureValue, sharedByUser, sharedByEntraGroup, reserve. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: sharedByUser, sharedByEntraGroup, reserve. The shared member is deprecated and will stop returning on April 30, 2027; going forward, use the sharedByUser member."
  type        = any
  default     = null

  validation {
    condition     = var.provisioning_type == null ? true : contains(["dedicated", "shared", "unknownFutureValue", "sharedByUser", "sharedByEntraGroup", "reserve"], var.provisioning_type)
    error_message = "provisioning_type must be one of the documented enum values."
  }
}

variable "supported_solution" {
  description = "Microsoft Graph supportedSolution property."
  type        = string
  default     = null

  validation {
    condition     = var.supported_solution == null ? true : contains(["windows365", "devBox", "unknownFutureValue", "rpaBox", "microsoft365Opal", "microsoft365BizChat"], var.supported_solution)
    error_message = "supported_solution must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["displayName", "id", "ramInGB", "storageInGB", "type", "userProfileInGB", "vCpuCount"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
