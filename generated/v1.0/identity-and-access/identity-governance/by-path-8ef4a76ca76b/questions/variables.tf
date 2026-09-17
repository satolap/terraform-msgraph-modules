variable "access_package_assignment_policy_id" {
  description = "The unique identifier of accessPackageAssignmentPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_assignment_policy_id)) > 0
    error_message = "access_package_assignment_policy_id must not be empty."
  }
}

variable "is_answer_editable" {
  description = "Specifies whether the requestor is allowed to edit answers to questions for an assignment by posting an update to accessPackageAssignmentRequest."
  type        = bool
  default     = null
}

variable "is_required" {
  description = "Whether the requestor is required to supply an answer or not."
  type        = bool
  default     = null
}

variable "localizations" {
  description = "The text of the question represented in a format for a specific locale."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.accessPackageLocalizedText")
    languageCode = optional(string)
    text         = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageQuestion"
  nullable    = false
}

variable "sequence" {
  description = "Relative position of this question when displaying a list of questions to the requestor."
  type        = number
  default     = null
}

variable "text" {
  description = "The text of the question to show to the requestor."
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
