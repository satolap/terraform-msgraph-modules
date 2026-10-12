variable "contact_folder_id" {
  description = "The unique identifier of contactFolder"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.contact_folder_id)) > 0
    error_message = "contact_folder_id must not be empty."
  }
}

variable "display_name" {
  description = "The folder's display name."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.contactFolder"
  nullable    = false
}

variable "parent_folder_id" {
  description = "The ID of the folder's parent folder."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["childFolders", "contacts", "id", "multiValueExtendedProperties", "singleValueExtendedProperties"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
