variable "description" {
  description = "Description for the verified ID profile. Required."
  type        = string
  default     = null
}

variable "face_check_configuration" {
  description = "Microsoft Graph faceCheckConfiguration property."
  type = object({
    odata_type           = optional(string, "#microsoft.graph.faceCheckConfiguration")
    isEnabled            = optional(bool)
    sourcePhotoClaimName = optional(string)
  })
  default = null
}

variable "last_modified_date_time" {
  description = "DateTime the profile was last modified. Optional."
  type        = string
  default     = null
}

variable "mobile_drivers_license_configuration" {
  description = "Configuration for accepting mobile driver's licenses. Optional."
  type        = any
  default     = null
}

variable "name" {
  description = "Display name for the verified ID profile. Required."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.verifiedIdProfile"
  nullable    = false
}

variable "priority" {
  description = "Defines profile processing priority if multiple profiles are configured. Optional."
  type        = number
  default     = null
}

variable "self_service_issuance" {
  description = "Configuration for self-service issuance. Optional."
  type        = any
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["enabled", "disabled", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "verified_id_profile_configuration" {
  description = "Microsoft Graph verifiedIdProfileConfiguration property."
  type = object({
    odata_type         = optional(string, "#microsoft.graph.verifiedIdProfileConfiguration")
    acceptedIssuer     = optional(string)
    claimBindingSource = optional(string)
    claimBindings = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.claimBinding")
      matchConfidenceLevel = optional(string)
      sourceAttribute      = optional(string)
      verifiedIdClaim      = optional(string)
    })))
    claimValidation = optional(object({
      odata_type        = optional(string, "#microsoft.graph.claimValidation")
      customExtensionId = optional(string)
      isEnabled         = optional(bool)
    }))
    manifestUrl = optional(string)
    methodType  = optional(string)
    type        = optional(string)
  })
  default = null
}

variable "verified_id_usage_configurations" {
  description = "Collection defining the usage purpose for the profile. The possible values are: recovery, onboarding, all, unknownFutureValue, verification. Use the Prefer: include-unknown-enum-members request header to get the following value from this evolvable enum: verification. Required."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.verifiedIdUsageConfiguration")
    isEnabledForTestOnly = optional(bool)
    purpose              = optional(string)
  }))
  default = null
}

variable "verifier_did" {
  description = "Decentralized Identifier (DID) string that represents the verifier in the verifiable credential exchange. Required."
  type        = string
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
