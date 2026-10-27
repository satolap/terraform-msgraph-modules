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
  type = object({
    odata_type       = optional(string, "#microsoft.graph.mobileDriversLicenseConfiguration")
    acceptedRegions  = optional(list(string))
    documentStandard = optional(string)
  })
  default = null
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
  type = object({
    odata_type  = optional(string, "#microsoft.graph.verifiedIdSelfServiceIssuance")
    isEnabled   = optional(bool)
    issuanceUrl = optional(string)
  })
  default = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["enabled", "disabled"], var.state)
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

  validation {
    condition     = (var.verified_id_profile_configuration == null ? true : alltrue([(var.verified_id_profile_configuration["claimBindingSource"] == null ? true : alltrue([(var.verified_id_profile_configuration["claimBindingSource"] == null ? true : contains(["directory"], var.verified_id_profile_configuration["claimBindingSource"]))])), (var.verified_id_profile_configuration["claimBindings"] == null ? true : alltrue([alltrue([for input1 in var.verified_id_profile_configuration["claimBindings"] : (input1 == null ? true : alltrue([(input1["matchConfidenceLevel"] == null ? true : alltrue([(input1["matchConfidenceLevel"] == null ? true : contains(["exact", "relaxed"], input1["matchConfidenceLevel"]))]))]))])])), (var.verified_id_profile_configuration["methodType"] == null ? true : alltrue([(var.verified_id_profile_configuration["methodType"] == null ? true : contains(["identityVerificationPartner", "tenantCustomCredential", "verifiedEmployee"], var.verified_id_profile_configuration["methodType"]))]))]))
    error_message = "verified_id_profile_configuration: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "verified_id_usage_configurations" {
  description = "Collection defining the usage purpose for the profile. The possible values are: recovery, onboarding, all, unknownFutureValue, verification. Use the Prefer: include-unknown-enum-members request header to get the following value from this evolvable enum: verification. Required."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.verifiedIdUsageConfiguration")
    isEnabledForTestOnly = optional(bool)
    purpose              = optional(string)
  }))
  default = null

  validation {
    condition     = (var.verified_id_usage_configurations == null ? true : alltrue([alltrue([for input0 in var.verified_id_usage_configurations : (input0 == null ? true : alltrue([(input0["purpose"] == null ? true : alltrue([(input0["purpose"] == null ? true : contains(["recovery", "onboarding", "all"], input0["purpose"]))]))]))])]))
    error_message = "verified_id_usage_configurations: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "verifier_did" {
  description = "Decentralized Identifier (DID) string that represents the verifier in the verifiable credential exchange. Required."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
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
