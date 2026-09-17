variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "list_id" {
  description = "The unique identifier of list"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.list_id)) > 0
    error_message = "list_id must not be empty."
  }
}

variable "analytics" {
  description = "Analytics about the view activities that took place on this item."
  type        = any
  default     = null
}

variable "content_type" {
  description = "The content type of this list item"
  type        = any
  default     = null
}

variable "description" {
  description = "Provides a user-visible description of the item. Optional."
  type        = string
  default     = null
}

variable "document_set_versions" {
  description = "Version information for a document set version created by a user."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.documentSetVersion")
    comment         = optional(string)
    createdBy       = optional(any)
    createdDateTime = optional(string)
    fields          = optional(any)
    items = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.documentSetVersionItem")
      itemId     = optional(string)
      title      = optional(string)
      versionId  = optional(string)
    })))
    shouldCaptureMinorVersion = optional(bool)
  }))
  default = null
}

variable "drive_item" {
  description = "For document libraries, the driveItem relationship exposes the listItem as a driveItem"
  type        = any
  default     = null
}

variable "fields" {
  description = "The values of the columns set on this list item."
  type        = any
  default     = null
}

variable "name" {
  description = "The name of the item. Read-write."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.listItem"
  nullable    = false
}

variable "parent_reference" {
  description = "Parent information, if the item has a parent. Read-write."
  type        = any
  default     = null
}

variable "versions" {
  description = "The list of previous versions of the list item."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.listItemVersion")
    fields     = optional(any)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdByUser", "createdDateTime", "deleted", "eTag", "id", "lastModifiedBy", "lastModifiedByUser", "lastModifiedDateTime", "permissions", "sharepointIds", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
