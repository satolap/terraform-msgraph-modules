variable "columns" {
  description = "Microsoft Graph columns property."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.exactDataMatchStoreColumn")
    ignoredDelimiters = optional(list(string))
    isCaseInsensitive = optional(bool)
    isSearchable      = optional(bool)
    name              = optional(string)
  }))
  default = null
}

variable "data_last_updated_date_time" {
  description = "Microsoft Graph dataLastUpdatedDateTime property."
  type        = string
  default     = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.exactMatchDataStore"
  nullable    = false
}

variable "sessions" {
  description = "Microsoft Graph sessions property."
  type = list(object({
    odata_type                   = optional(string, "#microsoft.graph.exactMatchSession")
    checksum                     = optional(string)
    completionDateTime           = optional(string)
    creationDateTime             = optional(string)
    dataStoreId                  = optional(string)
    dataUploadURI                = optional(string)
    error                        = optional(any)
    fields                       = optional(list(string))
    fileName                     = optional(string)
    lastUpdatedDateTime          = optional(string)
    processingCompletionDateTime = optional(string)
    remainingBlockCount          = optional(number)
    remainingJobCount            = optional(number)
    rowsPerBlock                 = optional(number)
    salt                         = optional(string)
    startDateTime                = optional(string)
    state                        = optional(string)
    totalBlockCount              = optional(number)
    totalJobCount                = optional(number)
    uploadAgent                  = optional(any)
    uploadAgentId                = optional(string)
    uploadCompletionDateTime     = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
