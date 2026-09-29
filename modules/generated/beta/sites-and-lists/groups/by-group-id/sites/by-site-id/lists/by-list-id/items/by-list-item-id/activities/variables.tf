variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

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

variable "list_item_id" {
  description = "The unique identifier of listItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.list_item_id)) > 0
    error_message = "list_item_id must not be empty."
  }
}

variable "action" {
  description = "Microsoft Graph action property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.itemActionSet")
    comment = optional(object({
      odata_type   = optional(string, "#microsoft.graph.commentAction")
      isReply      = optional(bool)
      parentAuthor = optional(any)
      participants = optional(any)
    }))
    create = optional(any)
    delete = optional(object({
      odata_type = optional(string, "#microsoft.graph.deleteAction")
      name       = optional(string)
      objectType = optional(string)
    }))
    edit = optional(any)
    mention = optional(object({
      odata_type = optional(string, "#microsoft.graph.mentionAction")
      mentionees = optional(any)
    }))
    move = optional(object({
      odata_type = optional(string, "#microsoft.graph.moveAction")
      from       = optional(string)
      to         = optional(string)
    }))
    rename = optional(object({
      odata_type = optional(string, "#microsoft.graph.renameAction")
      newName    = optional(string)
      oldName    = optional(string)
    }))
    restore = optional(any)
    share = optional(object({
      odata_type = optional(string, "#microsoft.graph.shareAction")
      recipients = optional(any)
    }))
    version = optional(object({
      odata_type = optional(string, "#microsoft.graph.versionAction")
      newVersion = optional(string)
    }))
  })
  default = null
}

variable "actor" {
  description = "Microsoft Graph actor property."
  type        = any
  default     = null
}

variable "drive_item" {
  description = "Microsoft Graph driveItem property."
  type        = any
  default     = null
}

variable "list_item" {
  description = "Microsoft Graph listItem property."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.itemActivityOLD"
  nullable    = false
}

variable "times" {
  description = "Microsoft Graph times property."
  type = object({
    odata_type           = optional(string, "#microsoft.graph.itemActivityTimeSet")
    lastRecordedDateTime = optional(string)
    observedDateTime     = optional(string)
    recordedDateTime     = optional(string)
  })
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
