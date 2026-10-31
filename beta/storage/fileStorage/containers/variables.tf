variable "archivalDetails" {
  description = "Archival details of the fileStorageContainer. Read-write."
  type = object({
    odata_type       = optional(string, "#microsoft.graph.siteArchivalDetails")
    archiveStatus    = optional(string)
    archivedBy       = optional(any)
    archivedDateTime = optional(string)
  })
  default = null

  validation {
    condition     = (var.archivalDetails == null ? true : alltrue([(var.archivalDetails["archiveStatus"] == null ? true : alltrue([(var.archivalDetails["archiveStatus"] == null ? true : contains(["recentlyArchived", "fullyArchived", "reactivating"], var.archivalDetails["archiveStatus"]))]))]))
    error_message = "archivalDetails: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "assignedSensitivityLabel" {
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

variable "customProperties" {
  description = "Custom property collection for the fileStorageContainer. Read-write."
  type        = any
  default     = null
}

variable "description" {
  description = "Provides a user-visible description of the fileStorageContainer. Read-write."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The display name of the fileStorageContainer. Read-write."
  type        = string
  default     = null
}

variable "externalGroupId" {
  description = "Microsoft Graph externalGroupId property."
  type        = string
  default     = null
}

variable "informationBarrier" {
  description = "Information barrier of a fileStorageContainer. Read-write."
  type = object({
    odata_type = optional(string, "#microsoft.graph.informationBarrier")
    mode       = optional(string)
    segmentIds = optional(list(string))
  })
  default = null

  validation {
    condition     = (var.informationBarrier == null ? true : alltrue([(var.informationBarrier["mode"] == null ? true : alltrue([(var.informationBarrier["mode"] == null ? true : contains(["open", "ownerModerated", "explicit"], var.informationBarrier["mode"]))]))]))
    error_message = "informationBarrier: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "migrationJobs" {
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

variable "sharePointGroups" {
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

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
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
