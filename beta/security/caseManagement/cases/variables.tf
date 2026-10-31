variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.security.caseManagement.exposureCase", "#microsoft.graph.security.caseManagement.genericCase", "#microsoft.graph.security.caseManagement.incidentCase"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "activities" {
  description = "The timeline of comments and audit events associated with the case. Supports $expand."
  type        = any
  default     = null
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
    origin = optional(object({
      odata_type   = optional(string, "#microsoft.graph.security.caseManagement.attachmentOrigin")
      resourceId   = optional(string)
      resourceType = optional(string)
    }))
    scanResult = optional(string)
  }))
  default = null

  validation {
    condition     = (var.attachments == null ? true : alltrue([alltrue([for input0 in var.attachments : (input0 == null ? true : alltrue([(input0["origin"] == null ? true : alltrue([(input0["origin"]["resourceType"] == null ? true : alltrue([(input0["origin"]["resourceType"] == null ? true : contains(["case", "comment", "task"], input0["origin"]["resourceType"]))]))])), (input0["scanResult"] == null ? true : alltrue([(input0["scanResult"] == null ? true : contains(["unscanned", "noThreatsFound", "malicious"], input0["scanResult"]))]))]))])]))
    error_message = "attachments: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "createdBy" {
  description = "The user or service that created the resource."
  type        = string
  default     = null
}

variable "createdDateTime" {
  description = "The date and time when the resource was created."
  type        = string
  default     = null
}

variable "customFields" {
  description = "Tenant-defined custom field values keyed by the exact displayName of each custom field definition. The property and its dynamic fields don't support $filter."
  type        = any
  default     = null
}

variable "displayName" {
  description = "The display name of the case. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "lastModifiedBy" {
  description = "The user or service that last modified the resource."
  type        = string
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The date and time when the resource was last modified."
  type        = string
  default     = null
}

variable "relations" {
  description = "Links from the case to related security resources. Supports $expand."
  type        = any
  default     = null
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

  validation {
    condition     = (var.tasks == null ? true : alltrue([alltrue([for input0 in var.tasks : (input0 == null ? true : alltrue([(input0["category"] == null ? true : alltrue([(input0["category"] == null ? true : contains(["uncategorized", "triage", "contain", "investigate", "remediate", "prevent"], input0["category"]))])), (input0["priority"] == null ? true : alltrue([(input0["priority"] == null ? true : contains(["notSet", "veryLow", "low", "medium", "high", "critical"], input0["priority"]))])), (input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["notSet", "new", "inProgress", "failed", "partiallyCompleted", "skipped", "completed"], input0["status"]))]))]))])]))
    error_message = "tasks: nested required attributes must be non-null and enum values must be supported input members."
  }
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "slaPolicies"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
