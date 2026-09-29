variable "archival_details" {
  description = "Archival details of the fileStorageContainer. Read-write."
  type = object({
    odata_type       = optional(string, "#microsoft.graph.siteArchivalDetails")
    archiveStatus    = optional(string)
    archivedBy       = optional(any)
    archivedDateTime = optional(string)
  })
  default = null
}

variable "assigned_sensitivity_label" {
  description = "Sensitivity label assigned to the fileStorageContainer. Read-write."
  type = object({
    odata_type = optional(string, "#microsoft.graph.assignedLabel")
    labelId    = optional(string)
  })
  default = null
}

variable "columns" {
  description = "The set of custom structured metadata supported by the fileStorageContainer. Read-write."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.columnDefinition")
    boolean    = optional(any)
    calculated = optional(object({
      odata_type = optional(string, "#microsoft.graph.calculatedColumn")
      format     = optional(string)
      formula    = optional(string)
      outputType = optional(string)
    }))
    choice = optional(object({
      odata_type     = optional(string, "#microsoft.graph.choiceColumn")
      allowTextEntry = optional(bool)
      choices        = optional(list(string))
      displayAs      = optional(string)
    }))
    columnGroup           = optional(string)
    contentApprovalStatus = optional(any)
    currency = optional(object({
      odata_type = optional(string, "#microsoft.graph.currencyColumn")
      locale     = optional(string)
    }))
    dateTime = optional(object({
      odata_type = optional(string, "#microsoft.graph.dateTimeColumn")
      displayAs  = optional(string)
      format     = optional(string)
    }))
    defaultValue = optional(object({
      odata_type = optional(string, "#microsoft.graph.defaultColumnValue")
      formula    = optional(string)
      value      = optional(string)
    }))
    description         = optional(string)
    displayName         = optional(string)
    enforceUniqueValues = optional(bool)
    geolocation         = optional(any)
    hidden              = optional(bool)
    hyperlinkOrPicture = optional(object({
      odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")
      isPicture  = optional(bool)
    }))
    indexed      = optional(bool)
    isDeletable  = optional(bool)
    isSealed     = optional(bool)
    isSearchable = optional(bool)
    lookup = optional(object({
      odata_type            = optional(string, "#microsoft.graph.lookupColumn")
      allowMultipleValues   = optional(bool)
      allowUnlimitedLength  = optional(bool)
      columnName            = optional(string)
      listId                = optional(string)
      primaryLookupColumnId = optional(string)
    }))
    name = optional(string)
    number = optional(object({
      odata_type    = optional(string, "#microsoft.graph.numberColumn")
      decimalPlaces = optional(string)
      displayAs     = optional(string)
      maximum       = optional(any)
      minimum       = optional(any)
    }))
    personOrGroup = optional(object({
      odata_type             = optional(string, "#microsoft.graph.personOrGroupColumn")
      allowMultipleSelection = optional(bool)
      chooseFromType         = optional(string)
      displayAs              = optional(string)
    }))
    propagateChanges = optional(bool)
    readOnly         = optional(bool)
    required         = optional(bool)
    sourceColumn     = optional(any)
    sourceContentType = optional(object({
      odata_type = optional(string, "#microsoft.graph.contentTypeInfo")
      id         = optional(string)
      name       = optional(string)
    }))
    term = optional(object({
      odata_type             = optional(string, "#microsoft.graph.termColumn")
      allowMultipleValues    = optional(bool)
      parentTerm             = optional(any)
      showFullyQualifiedName = optional(bool)
      termSet                = optional(any)
    }))
    text = optional(object({
      odata_type                  = optional(string, "#microsoft.graph.textColumn")
      allowMultipleLines          = optional(bool)
      appendChangesToExistingText = optional(bool)
      linesForEditing             = optional(number)
      maxLength                   = optional(number)
      textType                    = optional(string)
    }))
    thumbnail = optional(any)
    validation = optional(object({
      odata_type      = optional(string, "#microsoft.graph.columnValidation")
      defaultLanguage = optional(string)
      descriptions = optional(list(object({
        odata_type  = optional(string, "#microsoft.graph.displayNameLocalization")
        displayName = optional(string)
        languageTag = optional(string)
      })))
      formula = optional(string)
    }))
  }))
  default = null
}

variable "custom_properties" {
  description = "Custom property collection for the fileStorageContainer. Read-write."
  type        = any
  default     = null
}

variable "description" {
  description = "Provides a user-visible description of the fileStorageContainer. Read-write."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the fileStorageContainer. Read-write."
  type        = string
  default     = null
}

variable "external_group_id" {
  description = "Microsoft Graph externalGroupId property."
  type        = string
  default     = null
}

variable "information_barrier" {
  description = "Information barrier of a fileStorageContainer. Read-write."
  type = object({
    odata_type = optional(string, "#microsoft.graph.informationBarrier")
    mode       = optional(string)
    segmentIds = optional(list(string))
  })
  default = null
}

variable "migration_jobs" {
  description = "The collection of sharePointMigrationJob objects local to the container. Read-write."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.sharePointMigrationJob")
    containerInfo = optional(object({
      odata_type = optional(string, "#microsoft.graph.sharePointMigrationContainerInfo")
    }))
    progressEvents = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.fileStorageContainer"
  nullable    = false
}

variable "permissions" {
  description = "The set of permissions for users in the fileStorageContainer. The permission for each user is set by the roles property. The possible values are reader, writer, manager, and owner. Read-write."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.permission")
    expirationDateTime = optional(string)
  }))
  default = null
}

variable "settings" {
  description = "Microsoft Graph settings property."
  type = object({
    odata_type                    = optional(string, "#microsoft.graph.fileStorageContainerSettings")
    isItemVersioningEnabled       = optional(bool)
    isOcrEnabled                  = optional(bool)
    itemDefaultSensitivityLabelId = optional(string)
    itemMajorVersionLimit         = optional(number)
  })
  default = null
}

variable "share_point_groups" {
  description = "The collection of sharePointGroup objects local to the container. Read-write."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.sharePointGroup")
    description = optional(string)
    members = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.sharePointGroupMember")
      identity = optional(object({
        odata_type      = optional(string, "#microsoft.graph.sharePointIdentitySet")
        application     = optional(any)
        device          = optional(any)
        group           = optional(any)
        sharePointGroup = optional(any)
        siteGroup       = optional(any)
        siteUser        = optional(any)
        user            = optional(any)
      }))
    })))
    title = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["containerTypeId", "createdDateTime", "dataLocationCode", "drive", "id", "lockState", "owners", "ownershipType", "recycleBin", "status", "storageUsedInBytes", "viewpoint"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
