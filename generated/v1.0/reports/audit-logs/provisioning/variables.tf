variable "activity_date_time" {
  description = "Represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z.  SUpports $filter (eq, gt, lt) and orderby."
  type        = string
  default     = null
}

variable "change_id" {
  description = "Unique ID of this change in this cycle. Supports $filter (eq, contains)."
  type        = string
  default     = null
}

variable "cycle_id" {
  description = "Unique ID per job iteration. Supports $filter (eq, contains)."
  type        = string
  default     = null
}

variable "duration_in_milliseconds" {
  description = "Indicates how long this provisioning action took to finish. Measured in milliseconds."
  type        = number
  default     = null
}

variable "initiated_by" {
  description = "Details of who initiated this provisioning. Supports $filter (eq, contains)."
  type        = any
  default     = null
}

variable "job_id" {
  description = "The unique ID for the whole provisioning job. Supports $filter (eq, contains)."
  type        = string
  default     = null
}

variable "modified_properties" {
  description = "Details of each property that was modified in this provisioning action on this object."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.modifiedProperty")
    displayName = optional(string)
    newValue    = optional(string)
    oldValue    = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.provisioningObjectSummary"
  nullable    = false
}

variable "provisioning_action" {
  description = "Indicates the activity name or the operation name. The possible values are: create, update, delete, stageddelete, disable, other and unknownFutureValue. For a list of activities logged, refer to Microsoft Entra activity list. Supports $filter (eq, contains)."
  type        = any
  default     = null

  validation {
    condition     = var.provisioning_action == null ? true : contains(["other", "create", "delete", "disable", "update", "stagedDelete", "unknownFutureValue"], var.provisioning_action)
    error_message = "provisioning_action must be one of the documented enum values."
  }
}

variable "provisioning_status_info" {
  description = "Details of provisioning status."
  type        = any
  default     = null
}

variable "provisioning_steps" {
  description = "Details of each step in provisioning."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.provisioningStep")
    description          = optional(string)
    details              = optional(any)
    name                 = optional(string)
    provisioningStepType = optional(any)
    status               = optional(any)
  }))
  default = null
}

variable "service_principal" {
  description = "Represents the service principal used for provisioning. Supports $filter (eq) for id and name."
  type        = any
  default     = null
}

variable "source_identity" {
  description = "Details of source object being provisioned. Supports $filter (eq, contains) for identityType, id, and displayName."
  type        = any
  default     = null
}

variable "source_system" {
  description = "Details of source system of the object being provisioned. Supports $filter (eq, contains) for displayName."
  type        = any
  default     = null
}

variable "target_identity" {
  description = "Details of target object being provisioned. Supports $filter (eq, contains) for identityType, id, and displayName."
  type        = any
  default     = null
}

variable "target_system" {
  description = "Details of target system of the object being provisioned. Supports $filter (eq, contains) for displayName."
  type        = any
  default     = null
}

variable "tenant_id" {
  description = "Unique Microsoft Entra tenant ID. Supports $filter (eq, contains)."
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
