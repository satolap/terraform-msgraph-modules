variable "ediscovery_case_id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_case_id)) > 0
    error_message = "ediscovery_case_id must not be empty."
  }
}

variable "ediscovery_review_set_id" {
  description = "The unique identifier of ediscoveryReviewSet"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_review_set_id)) > 0
    error_message = "ediscovery_review_set_id must not be empty."
  }
}

variable "content" {
  description = "Microsoft Graph content property."
  type        = string
  default     = null
}

variable "custodian" {
  description = "Custodians associated with the file."
  type        = any
  default     = null
}

variable "date_time" {
  description = "Microsoft Graph dateTime property."
  type        = string
  default     = null
}

variable "extension" {
  description = "Microsoft Graph extension property."
  type        = string
  default     = null
}

variable "extracted_text_content" {
  description = "Microsoft Graph extractedTextContent property."
  type        = string
  default     = null
}

variable "media_type" {
  description = "Microsoft Graph mediaType property."
  type        = string
  default     = null
}

variable "name" {
  description = "Microsoft Graph name property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.ediscoveryFile"
  nullable    = false
}

variable "other_properties" {
  description = "Microsoft Graph otherProperties property."
  type        = any
  default     = null
}

variable "processing_status" {
  description = "Microsoft Graph processingStatus property."
  type        = any
  default     = null

  validation {
    condition     = var.processing_status == null ? true : contains(["success", "internalError", "unknownError", "processingTimeout", "invalidFileId", "fileSizeIsZero", "fileSizeIsTooLarge", "fileDepthLimitExceeded", "fileBodyIsTooLong", "fileTypeIsUnknown", "fileTypeIsNotSupported", "malformedFile", "protectedFile", "poisonFile", "noReviewSetSummaryGenerated", "extractionException", "ocrProcessingTimeout", "ocrFileSizeExceedsLimit", "unknownFutureValue"], var.processing_status)
    error_message = "processing_status must be one of the documented enum values."
  }
}

variable "sender_or_authors" {
  description = "Microsoft Graph senderOrAuthors property."
  type        = list(string)
  default     = null
}

variable "size" {
  description = "Microsoft Graph size property."
  type        = number
  default     = null
}

variable "source_type" {
  description = "Microsoft Graph sourceType property."
  type        = any
  default     = null

  validation {
    condition     = var.source_type == null ? true : contains(["mailbox", "site", "unknownFutureValue"], var.source_type)
    error_message = "source_type must be one of the documented enum values."
  }
}

variable "subject_title" {
  description = "Microsoft Graph subjectTitle property."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags associated with the file."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.ediscoveryReviewTag")
    childSelectability   = optional(any)
    childTags            = optional(any)
    createdBy            = optional(any)
    description          = optional(string)
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    parent               = optional(any)
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
