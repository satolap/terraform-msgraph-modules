variable "mailbox_id" {
  description = "The unique identifier of mailbox"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mailbox_id)) > 0
    error_message = "mailbox_id must not be empty."
  }
}

variable "mailbox_folder_id" {
  description = "The unique identifier of mailboxFolder"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mailbox_folder_id)) > 0
    error_message = "mailbox_folder_id must not be empty."
  }
}

variable "child_folder_count" {
  description = "The number of immediate child folders in the current folder."
  type        = number
  default     = null
}

variable "child_folders" {
  description = "The collection of child folders in this folder."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.mailboxFolder")
    childFolderCount = optional(number)
    childFolders     = optional(any)
    displayName      = optional(string)
    items = optional(list(object({
      odata_type                    = optional(string, "#microsoft.graph.mailboxItem")
      categories                    = optional(list(string))
      createdDateTime               = optional(string)
      lastModifiedDateTime          = optional(string)
      multiValueExtendedProperties  = optional(any)
      singleValueExtendedProperties = optional(any)
      size                          = optional(number)
      type                          = optional(string)
    })))
    multiValueExtendedProperties = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.multiValueLegacyExtendedProperty")
      value      = optional(list(string))
    })))
    parentFolderId   = optional(string)
    parentMailboxUrl = optional(string)
    singleValueExtendedProperties = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.singleValueLegacyExtendedProperty")
      value      = optional(string)
    })))
    totalItemCount = optional(number)
    type           = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "The display name of the folder."
  type        = string
  default     = null
}

variable "items" {
  description = "The collection of items in this folder."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.mailboxItem")
    categories           = optional(list(string))
    createdDateTime      = optional(string)
    lastModifiedDateTime = optional(string)
    multiValueExtendedProperties = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.multiValueLegacyExtendedProperty")
      value      = optional(list(string))
    })))
    singleValueExtendedProperties = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.singleValueLegacyExtendedProperty")
      value      = optional(string)
    })))
    size = optional(number)
    type = optional(string)
  }))
  default = null
}

variable "multi_value_extended_properties" {
  description = "The collection of multi-value extended properties defined for the mailboxFolder."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.multiValueLegacyExtendedProperty")
    value      = optional(list(string))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mailboxFolder"
  nullable    = false
}

variable "parent_folder_id" {
  description = "The unique identifier for the parent folder of this folder."
  type        = string
  default     = null
}

variable "parent_mailbox_url" {
  description = "The routing link to the actual underlying mailbox where the folder physically resides. The folder can be accessed using GET {parentMailboxUrl}/folders/{id}, which treats the entire URL as an opaque string.  This method is especially important when auto-expanding archiving is enabled for a user's in-place archive mailbox. The user's archive content can span across multiple mailboxes in such scenarios."
  type        = string
  default     = null
}

variable "single_value_extended_properties" {
  description = "The collection of single-value extended properties defined for the mailboxFolder."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.singleValueLegacyExtendedProperty")
    value      = optional(string)
  }))
  default = null
}

variable "total_item_count" {
  description = "The number of items in the folder."
  type        = number
  default     = null
}

variable "type" {
  description = "Describes the folder class type."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "wellKnownName"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
