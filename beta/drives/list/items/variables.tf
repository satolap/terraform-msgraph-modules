variable "drive_id" {
  description = "The unique identifier of drive"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_id)) > 0
    error_message = "drive_id must not be empty."
  }
}

variable "activities" {
  description = "The list of recent activities that took place on this item."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.itemActivityOLD")
    action = optional(object({
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
    }))
    actor     = optional(any)
    driveItem = optional(any)
    listItem  = optional(any)
    times = optional(object({
      odata_type           = optional(string, "#microsoft.graph.itemActivityTimeSet")
      lastRecordedDateTime = optional(string)
      observedDateTime     = optional(string)
      recordedDateTime     = optional(string)
    }))
  }))
  default = null
}

variable "analytics" {
  description = "Analytics about the view activities that took place on this item."
  type        = any
  default     = null
}

variable "content_type" {
  description = "The content type of this list item"
  type = object({
    odata_type = optional(string, "#microsoft.graph.contentTypeInfo")
    id         = optional(string)
    name       = optional(string)
  })
  default = null
}

variable "created_by_user" {
  description = "Microsoft Graph createdByUser property."
  type        = any
  default     = null
}

variable "deleted" {
  description = "Microsoft Graph deleted property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.deleted")
    state      = optional(string)
  })
  default = null
}

variable "description" {
  description = "The description of the item."
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

variable "last_modified_by_user" {
  description = "Microsoft Graph lastModifiedByUser property."
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
  type = object({
    odata_type = optional(string, "#microsoft.graph.itemReference")
    driveType  = optional(string)
    shareId    = optional(string)
    siteId     = optional(string)
  })
  default = null
}

variable "versions" {
  description = "The list of previous versions of the list item."
  type        = any
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "eTag", "id", "lastModifiedBy", "lastModifiedDateTime", "permissions", "sharepointIds", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
