variable "sharePointRestoreSession-id" {
  description = "The unique identifier of sharePointRestoreSession"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.sharePointRestoreSession-id)) > 0
    error_message = "sharePointRestoreSession-id must not be empty."
  }
}

variable "createdBy" {
  description = "The identity of the person who created the bulk request."
  type        = any
  default     = null
}

variable "createdDateTime" {
  description = "The time when the bulk request was created."
  type        = string
  default     = null
}

variable "destinationType" {
  description = "Indicates the restoration destination. The possible values are: new, inPlace, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.destinationType == null ? true : contains(["new", "inPlace"], var.destinationType)
    error_message = "destinationType must be one of the documented enum values."
  }
}

variable "displayName" {
  description = "Name of the addition request."
  type        = string
  default     = null
}

variable "error" {
  description = "Error details are populated for resource resolution failures."
  type = object({
    odata_type = optional(string, "#microsoft.graph.publicError")
    code       = optional(string)
    details = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.publicErrorDetail")
      code       = optional(string)
      message    = optional(string)
      target     = optional(string)
    })))
    innerError = optional(object({
      odata_type = optional(string, "#microsoft.graph.publicInnerError")
      code       = optional(string)
      details = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.publicErrorDetail")
        code       = optional(string)
        message    = optional(string)
        target     = optional(string)
      })))
      message = optional(string)
      target  = optional(string)
    }))
    message = optional(string)
    target  = optional(string)
  })
  default = null
}

variable "lastModifiedBy" {
  description = "Identity of the person who last modified this entity."
  type        = any
  default     = null
}

variable "lastModifiedDateTime" {
  description = "Timestamp when this entity was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.siteRestoreArtifactsBulkAdditionRequest"
  nullable    = false
}

variable "protectionTimePeriod" {
  description = "The start and end date and time of the protection period."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.timePeriod")
    endDateTime   = optional(string)
    startDateTime = optional(string)
  })
  default = null
}

variable "protectionUnitIds" {
  description = "Indicates which protection units to restore. This property isn't implemented yet. Future value; don't use."
  type        = list(string)
  default     = null
}

variable "restorePointPreference" {
  description = "Indicates which restore point to return. The possible values are: oldest, latest, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.restorePointPreference == null ? true : contains(["latest", "oldest"], var.restorePointPreference)
    error_message = "restorePointPreference must be one of the documented enum values."
  }
}

variable "siteIds" {
  description = "The list of SharePoint site IDs that are added to the corresponding SharePoint restore session in a bulk operation."
  type        = list(string)
  default     = null
}

variable "siteWebUrls" {
  description = "The list of SharePoint site URLs that are added to the corresponding SharePoint restore session in a bulk operation."
  type        = list(string)
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "active", "completed", "completedWithErrors"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "tags" {
  description = "The type of the restore point. The possible values are: none, fastRestore, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.tags == null ? true : try(alltrue([for value in split(",", var.tags) : contains(["none", "fastrestore"], lower(trimspace(value)))]), false)
    error_message = "tags must be one or more of the documented enum values, separated by commas."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
