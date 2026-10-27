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

  validation {
    condition     = (var.device_statuses == null ? true : alltrue([alltrue([for input0 in var.device_statuses : (input0 == null ? true : alltrue([(input0["deploymentStatus"] == null ? true : alltrue([(input0["deploymentStatus"] == null ? true : contains(["unknown", "success", "tokenError", "notAuthorizedByToken", "policyNotFound"], input0["deploymentStatus"]))]))]))])]))
    error_message = "device_statuses: nested required attributes must be non-null and enum values must be supported input members."
  }
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
