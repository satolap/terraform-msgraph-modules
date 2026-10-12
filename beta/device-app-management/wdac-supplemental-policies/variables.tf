variable "assignments" {
  description = "The associated group assignments for the Windows Defender Application Control Supplemental Policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.windowsDefenderApplicationControlSupplementalPolicyAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "content" {
  description = "Indicates the content of the Windows Defender Application Control Supplemental Policy in byte array format."
  type        = string
  default     = null
}

variable "content_file_name" {
  description = "Indicates the file name associated with the content of the Windows Defender Application Control Supplemental Policy."
  type        = string
  default     = null
}

variable "creation_date_time" {
  description = "Indicates the created date and time when the Windows Defender Application Control Supplemental Policy was uploaded."
  type        = string
  default     = null
}

variable "deploy_summary" {
  description = "WindowsDefenderApplicationControl supplemental policy deployment summary."
  type        = any
  default     = null
}

variable "description" {
  description = "The description of the Windows Defender Application Control Supplemental Policy."
  type        = string
  default     = null
}

variable "device_statuses" {
  description = "The list of device deployment states for this WindowsDefenderApplicationControl supplemental policy."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.windowsDefenderApplicationControlSupplementalPolicyDeploymentStatus")
    deploymentStatus  = optional(string)
    deviceId          = optional(string)
    deviceName        = optional(string)
    lastSyncDateTime  = optional(string)
    osDescription     = optional(string)
    osVersion         = optional(string)
    policy            = optional(any)
    policyVersion     = optional(string)
    userName          = optional(string)
    userPrincipalName = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "The display name of the Windows Defender Application Control Supplemental Policy."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Indicates the Windows Defender Application Control Supplemental Policy's version."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Indicates the last modified date and time of the Windows Defender Application Control Supplemental Policy."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsDefenderApplicationControlSupplementalPolicy"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for the Windows Defender Application Control Supplemental Policy entity."
  type        = list(string)
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
