variable "authentication_strength_policy_id" {
  description = "The unique identifier of authenticationStrengthPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.authentication_strength_policy_id)) > 0
    error_message = "authentication_strength_policy_id must not be empty."
  }
}

variable "applies_to_combinations" {
  description = "Which authentication method combinations this configuration applies to. Must be an allowedCombinations object defined for the authenticationStrengthPolicy. For fido2combinationConfigurations use 'fido2', for x509certificatecombinationconfiguration use 'x509CertificateSingleFactor' or 'x509CertificateMultiFactor'."
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.authenticationCombinationConfiguration"
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
