variable "assignments" {
  description = "The list of group assignments for this mobile app."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.mobileAppAssignment")
    intent     = optional(string)
    settings   = optional(any)
    source     = optional(string)
    target     = optional(any)
  }))
  default = null
}

variable "categories" {
  description = "The list of categories for this app."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.mobileAppCategory")
    displayName = optional(string)
  }))
  default = null
}

variable "description" {
  description = "The description of the app."
  type        = string
  default     = null
}

variable "developer" {
  description = "The developer of the app."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The admin provided or imported title of the app."
  type        = string
  default     = null
}

variable "information_url" {
  description = "The more information Url."
  type        = string
  default     = null
}

variable "is_featured" {
  description = "The value indicating whether the app is marked as featured by the admin."
  type        = bool
  default     = null
}

variable "large_icon" {
  description = "The large icon, to be displayed in the app details and used for upload of the icon."
  type        = any
  default     = null
}

variable "notes" {
  description = "Notes for the app."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mobileApp"
  nullable    = false
}

variable "owner" {
  description = "The owner of the app."
  type        = string
  default     = null
}

variable "privacy_information_url" {
  description = "The privacy statement Url."
  type        = string
  default     = null
}

variable "publisher" {
  description = "The publisher of the app."
  type        = string
  default     = null
}

variable "publishing_state" {
  description = "Indicates the publishing state of an app."
  type        = string
  default     = null

  validation {
    condition     = var.publishing_state == null ? true : contains(["notPublished", "processing", "published"], var.publishing_state)
    error_message = "publishing_state must be one of the documented enum values."
  }
}

variable "relationships" {
  description = "The set of direct relationships for this app."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.mobileAppRelationship")
    targetType = optional(string)
  }))
  default = null
}

variable "role_scope_tag_ids" {
  description = "List of scope tag ids for this mobile app."
  type        = list(string)
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "dependentAppCount", "id", "isAssigned", "lastModifiedDateTime", "supersededAppCount", "supersedingAppCount", "uploadState"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
