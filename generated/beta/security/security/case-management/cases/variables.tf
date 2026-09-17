variable "activities" {
  description = "The timeline of comments and audit events associated with the case. Supports $expand."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.caseManagement.activity")
    createdBy            = optional(string)
    createdDateTime      = optional(string)
    lastModifiedBy       = optional(string)
    lastModifiedDateTime = optional(string)
  }))
  default = null
}

variable "attachments" {
  description = "Evidence files and metadata associated with the case. Supports $expand."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.caseManagement.attachment")
    content              = optional(string)
    createdBy            = optional(string)
    createdDateTime      = optional(string)
    description          = optional(string)
    displayName          = optional(string)
    fileExtension        = optional(string)
    fileSize             = optional(number)
    lastModifiedBy       = optional(string)
    lastModifiedDateTime = optional(string)
    origin               = optional(any)
    scanResult           = optional(string)
  }))
  default = null
}

variable "created_by" {
  description = "The user or service that created the resource."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the resource was created."
  type        = string
  default     = null
}

variable "custom_fields" {
  description = "Tenant-defined custom field values keyed by the exact displayName of each custom field definition. The property and its dynamic fields don't support $filter."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The display name of the case. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The user or service that last modified the resource."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the resource was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.caseManagement.case"
  nullable    = false
}

variable "relations" {
  description = "Links from the case to related security resources. Supports $expand."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.caseManagement.relation")
    createdBy            = optional(string)
    createdDateTime      = optional(string)
    lastModifiedBy       = optional(string)
    lastModifiedDateTime = optional(string)
    relatedResourceId    = optional(string)
  }))
  default = null
}

variable "status" {
  description = "The tenant-defined lifecycle status of the case. Use a displayName value returned in the status tree by List statuses from /security/caseManagement/caseTypeConfigurations/genericCase/statuses or /security/caseManagement/caseTypeConfigurations/incidentCase/statuses, depending on the case type. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "tasks" {
  description = "Tasks used to track work required to resolve the case. Supports $expand."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.caseManagement.task")
    assignedTo           = optional(string)
    category             = optional(string)
    closingNotes         = optional(string)
    createdBy            = optional(string)
    createdDateTime      = optional(string)
    description          = optional(string)
    displayName          = optional(string)
    dueDateTime          = optional(string)
    lastModifiedBy       = optional(string)
    lastModifiedDateTime = optional(string)
    priority             = optional(string)
    status               = optional(string)
  }))
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "slaPolicies"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
