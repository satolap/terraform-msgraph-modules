variable "ediscovery_case_id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_case_id)) > 0
    error_message = "ediscovery_case_id must not be empty."
  }
}

variable "description" {
  description = "The description of the data set."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the data set. The name is unique with a maximum limit of 64 characters."
  type        = string
  default     = null
}

variable "files" {
  description = "Represents files within the review set."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.ediscoveryFile")
    content              = optional(string)
    custodian            = optional(any)
    dateTime             = optional(string)
    extension            = optional(string)
    extractedTextContent = optional(string)
    mediaType            = optional(string)
    name                 = optional(string)
    otherProperties      = optional(any)
    processingStatus     = optional(any)
    senderOrAuthors      = optional(list(string))
    size                 = optional(number)
    sourceType           = optional(any)
    subjectTitle         = optional(string)
    tags = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.security.ediscoveryReviewTag")
      childSelectability   = optional(any)
      childTags            = optional(any)
      createdBy            = optional(any)
      description          = optional(string)
      displayName          = optional(string)
      lastModifiedDateTime = optional(string)
      parent               = optional(any)
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.ediscoveryReviewSet"
  nullable    = false
}

variable "queries" {
  description = "Represents queries within the review set."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.ediscoveryReviewSetQuery")
    contentQuery         = optional(string)
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    description          = optional(string)
    displayName          = optional(string)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
