variable "printer_id" {
  description = "The unique identifier of printer"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.printer_id)) > 0
    error_message = "printer_id must not be empty."
  }
}

variable "configuration" {
  description = "Microsoft Graph configuration property."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.printJobConfiguration")
    collate         = optional(bool)
    finishings      = optional(any)
    fitPdfToPage    = optional(bool)
    inputBin        = optional(string)
    margin          = optional(any)
    mediaSize       = optional(string)
    mediaType       = optional(string)
    multipageLayout = optional(any)
    orientation     = optional(any)
    outputBin       = optional(string)
    pagesPerSheet   = optional(number)
    scaling         = optional(any)
  })
  default = null
}

variable "created_by" {
  description = "Microsoft Graph createdBy property."
  type        = any
  default     = null
}

variable "documents" {
  description = "Microsoft Graph documents property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.printDocument")
  }))
  default = null
}

variable "is_fetchable" {
  description = "If true, document can be fetched by printer."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.printJob"
  nullable    = false
}

variable "redirected_from" {
  description = "Contains the source job URL, if the job has been redirected from another printer."
  type        = string
  default     = null
}

variable "redirected_to" {
  description = "Contains the destination job URL, if the job has been redirected to another printer."
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.printJobStatus")
    state      = optional(string)
  })
  default = null
}

variable "tasks" {
  description = "A list of printTasks that were triggered by this print job."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.printTask")
    definition = optional(object({
      odata_type = optional(string, "#microsoft.graph.printTaskDefinition")
      createdBy = optional(object({
        odata_type           = optional(string, "#microsoft.graph.appIdentity")
        appId                = optional(string)
        displayName          = optional(string)
        servicePrincipalId   = optional(string)
        servicePrincipalName = optional(string)
      }))
      displayName = optional(string)
    }))
    status = optional(object({
      odata_type  = optional(string, "#microsoft.graph.printTaskStatus")
      description = optional(string)
      state       = optional(string)
    }))
    trigger = optional(object({
      odata_type = optional(string, "#microsoft.graph.printTaskTrigger")
      definition = optional(object({
        odata_type = optional(string, "#microsoft.graph.printTaskDefinition")
        createdBy = optional(object({
          odata_type           = optional(string, "#microsoft.graph.appIdentity")
          appId                = optional(string)
          displayName          = optional(string)
          servicePrincipalId   = optional(string)
          servicePrincipalName = optional(string)
        }))
        displayName = optional(string)
      }))
      event = optional(string)
    }))
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["acknowledgedDateTime", "createdDateTime", "errorCode", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
