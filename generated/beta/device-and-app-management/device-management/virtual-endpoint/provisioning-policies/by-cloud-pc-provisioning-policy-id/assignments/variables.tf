variable "cloud_pc_provisioning_policy_id" {
  description = "The unique identifier of cloudPcProvisioningPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.cloud_pc_provisioning_policy_id)) > 0
    error_message = "cloud_pc_provisioning_policy_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcProvisioningPolicyAssignment"
  nullable    = false
}

variable "target" {
  description = "The assignment target for the provisioning policy. Currently, the only target supported for this policy is a user group. For details, see cloudPcManagementGroupAssignmentTarget."
  type        = any
  default     = null
}

variable "user_settings_persistence_detail" {
  description = "The assignment targeted user settings persistence for the provisioning policy. It allows user application data and Windows settings to be saved and applied between sessions."
  type        = any
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["assignedUsers", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
