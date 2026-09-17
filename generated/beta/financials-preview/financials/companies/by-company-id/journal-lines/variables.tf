variable "company_id" {
  description = "The unique identifier of company"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.company_id)) > 0
    error_message = "company_id must not be empty."
  }
}

variable "account" {
  description = "Microsoft Graph account property."
  type        = any
  default     = null
}

variable "account_id" {
  description = "Microsoft Graph accountId property."
  type        = string
  default     = null
}

variable "account_number" {
  description = "Microsoft Graph accountNumber property."
  type        = string
  default     = null
}

variable "amount" {
  description = "Microsoft Graph amount property."
  type        = number
  default     = null
}

variable "comment" {
  description = "Microsoft Graph comment property."
  type        = string
  default     = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "document_number" {
  description = "Microsoft Graph documentNumber property."
  type        = string
  default     = null
}

variable "external_document_number" {
  description = "Microsoft Graph externalDocumentNumber property."
  type        = string
  default     = null
}

variable "id" {
  description = "Microsoft Graph id property."
  type        = string
  default     = null
}

variable "journal_display_name" {
  description = "Microsoft Graph journalDisplayName property."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "line_number" {
  description = "Microsoft Graph lineNumber property."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.journalLine"
  nullable    = false
}

variable "posting_date" {
  description = "Microsoft Graph postingDate property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains([], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
