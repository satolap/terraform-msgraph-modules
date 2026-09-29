variable "activities" {
  description = "The list of recent activities that took place under this drive."
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

variable "bundles" {
  description = "Collection of bundles (albums and multi-select-shared sets of items). Only in personal OneDrive."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.driveItem")
    activities = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.itemActivityOLD")
      action = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemActionSet")
        comment    = optional(any)
        create     = optional(any)
        delete     = optional(any)
        edit       = optional(any)
        mention    = optional(any)
        move       = optional(any)
        rename     = optional(any)
        restore    = optional(any)
        share      = optional(any)
        version    = optional(any)
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
    })))
    analytics     = optional(any)
    content       = optional(string)
    contentStream = optional(string)
    createdByUser = optional(any)
    description   = optional(string)
    extensions    = optional(any)
    fileSystemInfo = optional(object({
      odata_type           = optional(string, "#microsoft.graph.fileSystemInfo")
      createdDateTime      = optional(string)
      lastAccessedDateTime = optional(string)
      lastModifiedDateTime = optional(string)
    }))
    lastModifiedByUser = optional(any)
    media = optional(object({
      odata_type           = optional(string, "#microsoft.graph.media")
      isTranscriptionShown = optional(bool)
    }))
    name = optional(string)
    parentReference = optional(object({
      odata_type = optional(string, "#microsoft.graph.itemReference")
      driveType  = optional(string)
      shareId    = optional(string)
      siteId     = optional(string)
    }))
    retentionLabel = optional(any)
    root           = optional(any)
    subscriptions = optional(list(object({
      odata_type                       = optional(string, "#microsoft.graph.subscription")
      changeType                       = optional(string)
      clientState                      = optional(string)
      encryptionCertificate            = optional(string)
      encryptionCertificateId          = optional(string)
      expirationDateTime               = optional(string)
      includeResourceData              = optional(bool)
      latestSupportedTlsVersion        = optional(string)
      lifecycleNotificationUrl         = optional(string)
      notificationContentType          = optional(string)
      notificationQueryOptions         = optional(string)
      notificationUrl                  = optional(string)
      notificationUrlAppId             = optional(string)
      resource                         = optional(string)
      vapidPublicKey                   = optional(string)
      webPushEncryptionP256dhPublicKey = optional(string)
      webPushEncryptionSecret          = optional(string)
    })))
    webDavUrl = optional(string)
    workbook  = optional(any)
  }))
  default   = null
  sensitive = true
}

variable "created_by_user" {
  description = "Microsoft Graph createdByUser property."
  type        = any
  default     = null
}

variable "description" {
  description = "The description of the item."
  type        = string
  default     = null
}

variable "following" {
  description = "The list of items the user is following. Only in OneDrive for Business."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.driveItem")
    activities = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.itemActivityOLD")
      action = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemActionSet")
        comment    = optional(any)
        create     = optional(any)
        delete     = optional(any)
        edit       = optional(any)
        mention    = optional(any)
        move       = optional(any)
        rename     = optional(any)
        restore    = optional(any)
        share      = optional(any)
        version    = optional(any)
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
    })))
    analytics     = optional(any)
    content       = optional(string)
    contentStream = optional(string)
    createdByUser = optional(any)
    description   = optional(string)
    extensions    = optional(any)
    fileSystemInfo = optional(object({
      odata_type           = optional(string, "#microsoft.graph.fileSystemInfo")
      createdDateTime      = optional(string)
      lastAccessedDateTime = optional(string)
      lastModifiedDateTime = optional(string)
    }))
    lastModifiedByUser = optional(any)
    media = optional(object({
      odata_type           = optional(string, "#microsoft.graph.media")
      isTranscriptionShown = optional(bool)
    }))
    name = optional(string)
    parentReference = optional(object({
      odata_type = optional(string, "#microsoft.graph.itemReference")
      driveType  = optional(string)
      shareId    = optional(string)
      siteId     = optional(string)
    }))
    retentionLabel = optional(any)
    root           = optional(any)
    subscriptions = optional(list(object({
      odata_type                       = optional(string, "#microsoft.graph.subscription")
      changeType                       = optional(string)
      clientState                      = optional(string)
      encryptionCertificate            = optional(string)
      encryptionCertificateId          = optional(string)
      expirationDateTime               = optional(string)
      includeResourceData              = optional(bool)
      latestSupportedTlsVersion        = optional(string)
      lifecycleNotificationUrl         = optional(string)
      notificationContentType          = optional(string)
      notificationQueryOptions         = optional(string)
      notificationUrl                  = optional(string)
      notificationUrlAppId             = optional(string)
      resource                         = optional(string)
      vapidPublicKey                   = optional(string)
      webPushEncryptionP256dhPublicKey = optional(string)
      webPushEncryptionSecret          = optional(string)
    })))
    webDavUrl = optional(string)
    workbook  = optional(any)
  }))
  default   = null
  sensitive = true
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
  default     = "#microsoft.graph.drive"
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

variable "share_point_ids" {
  description = "Microsoft Graph sharePointIds property."
  type = object({
    odata_type       = optional(string, "#microsoft.graph.sharepointIds")
    listId           = optional(string)
    listItemId       = optional(string)
    listItemUniqueId = optional(string)
    siteId           = optional(string)
    siteUrl          = optional(string)
    tenantId         = optional(string)
    webId            = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "driveType", "eTag", "id", "items", "lastModifiedBy", "lastModifiedDateTime", "list", "owner", "quota", "root", "settings", "special", "system", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
