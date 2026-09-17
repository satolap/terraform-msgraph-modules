variable "grace_period_end_date_time" {
  description = "The date and time when the grace period ends and reprovisioning or deprovisioning happen. Required only if the status is inGracePeriod. The timestamp is shown in ISO 8601 format and Coordinated Universal Time (UTC). For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The last modified date and time of the Cloud PC. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPC"
  nullable    = false
}

variable "provisioning_type" {
  description = "The type of licenses to be used when provisioning Cloud PCs using this policy. The possible values are: dedicated, shared, unknownFutureValue. The default value is dedicated."
  type        = any
  default     = null

  validation {
    condition     = var.provisioning_type == null ? true : contains(["dedicated", "shared", "unknownFutureValue"], var.provisioning_type)
    error_message = "provisioning_type must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["aadDeviceId", "displayName", "id", "imageDisplayName", "managedDeviceId", "managedDeviceName", "onPremisesConnectionName", "provisioningPolicyId", "provisioningPolicyName", "servicePlanId", "servicePlanName", "userPrincipalName"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
