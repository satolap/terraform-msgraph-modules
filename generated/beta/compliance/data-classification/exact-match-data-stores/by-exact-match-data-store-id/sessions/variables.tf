variable "exact_match_data_store_id" {
  description = "The unique identifier of exactMatchDataStore"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.exact_match_data_store_id)) > 0
    error_message = "exact_match_data_store_id must not be empty."
  }
}

variable "checksum" {
  description = "Microsoft Graph checksum property."
  type        = string
  default     = null
}

variable "completion_date_time" {
  description = "Microsoft Graph completionDateTime property."
  type        = string
  default     = null
}

variable "creation_date_time" {
  description = "Microsoft Graph creationDateTime property."
  type        = string
  default     = null
}

variable "data_store_id" {
  description = "Microsoft Graph dataStoreId property."
  type        = string
  default     = null
}

variable "data_upload_uri" {
  description = "Microsoft Graph dataUploadURI property."
  type        = string
  default     = null
}

variable "error" {
  description = "Microsoft Graph error property."
  type        = any
  default     = null
}

variable "fields" {
  description = "Microsoft Graph fields property."
  type        = list(string)
  default     = null
}

variable "file_name" {
  description = "Microsoft Graph fileName property."
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "Microsoft Graph lastUpdatedDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.exactMatchSession"
  nullable    = false
}

variable "processing_completion_date_time" {
  description = "Microsoft Graph processingCompletionDateTime property."
  type        = string
  default     = null
}

variable "remaining_block_count" {
  description = "Microsoft Graph remainingBlockCount property."
  type        = number
  default     = null
}

variable "remaining_job_count" {
  description = "Microsoft Graph remainingJobCount property."
  type        = number
  default     = null
}

variable "rows_per_block" {
  description = "Microsoft Graph rowsPerBlock property."
  type        = number
  default     = null
}

variable "salt" {
  description = "Microsoft Graph salt property."
  type        = string
  default     = null
}

variable "start_date_time" {
  description = "Microsoft Graph startDateTime property."
  type        = string
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null
}

variable "total_block_count" {
  description = "Microsoft Graph totalBlockCount property."
  type        = number
  default     = null
}

variable "total_job_count" {
  description = "Microsoft Graph totalJobCount property."
  type        = number
  default     = null
}

variable "upload_agent" {
  description = "Microsoft Graph uploadAgent property."
  type        = any
  default     = null
}

variable "upload_agent_id" {
  description = "Microsoft Graph uploadAgentId property."
  type        = string
  default     = null
}

variable "upload_completion_date_time" {
  description = "Microsoft Graph uploadCompletionDateTime property."
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
