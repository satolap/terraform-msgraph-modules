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

variable "columns" {
  description = "The collection of field definitions for this list."
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
    indexed     = optional(bool)
    isDeletable = optional(bool)
    isSealed    = optional(bool)
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

variable "content_types" {
  description = "The collection of content types present in this list."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.contentType")
    associatedHubsUrls = optional(list(string))
    base               = optional(any)
    baseTypes          = optional(any)
    columnLinks = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.columnLink")
      name       = optional(string)
    })))
    columnPositions = optional(list(object({
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
        choices        = optional(any)
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
      indexed     = optional(bool)
      isDeletable = optional(bool)
      isSealed    = optional(bool)
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
        descriptions    = optional(any)
        formula         = optional(string)
      }))
    })))
    columns = optional(list(object({
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
        choices        = optional(any)
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
      indexed     = optional(bool)
      isDeletable = optional(bool)
      isSealed    = optional(bool)
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
        descriptions    = optional(any)
        formula         = optional(string)
      }))
    })))
    description = optional(string)
    documentSet = optional(object({
      odata_type = optional(string, "#microsoft.graph.documentSet")
      allowedContentTypes = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.contentTypeInfo")
        id         = optional(string)
        name       = optional(string)
      })))
      defaultContents = optional(list(object({
        odata_type  = optional(string, "#microsoft.graph.documentSetContent")
        contentType = optional(any)
        fileName    = optional(string)
        folderName  = optional(string)
      })))
      propagateWelcomePageChanges = optional(bool)
      sharedColumns = optional(list(object({
        odata_type            = optional(string, "#microsoft.graph.columnDefinition")
        boolean               = optional(any)
        calculated            = optional(any)
        choice                = optional(any)
        columnGroup           = optional(string)
        contentApprovalStatus = optional(any)
        currency              = optional(any)
        dateTime              = optional(any)
        defaultValue          = optional(any)
        description           = optional(string)
        displayName           = optional(string)
        enforceUniqueValues   = optional(bool)
        geolocation           = optional(any)
        hidden                = optional(bool)
        hyperlinkOrPicture    = optional(any)
        indexed               = optional(bool)
        isDeletable           = optional(bool)
        isSealed              = optional(bool)
        lookup                = optional(any)
        name                  = optional(string)
        number                = optional(any)
        personOrGroup         = optional(any)
        propagateChanges      = optional(bool)
        readOnly              = optional(bool)
        required              = optional(bool)
        sourceColumn          = optional(any)
        term                  = optional(any)
        text                  = optional(any)
        thumbnail             = optional(any)
        validation            = optional(any)
      })))
      shouldPrefixNameToFile = optional(bool)
      welcomePageColumns = optional(list(object({
        odata_type            = optional(string, "#microsoft.graph.columnDefinition")
        boolean               = optional(any)
        calculated            = optional(any)
        choice                = optional(any)
        columnGroup           = optional(string)
        contentApprovalStatus = optional(any)
        currency              = optional(any)
        dateTime              = optional(any)
        defaultValue          = optional(any)
        description           = optional(string)
        displayName           = optional(string)
        enforceUniqueValues   = optional(bool)
        geolocation           = optional(any)
        hidden                = optional(bool)
        hyperlinkOrPicture    = optional(any)
        indexed               = optional(bool)
        isDeletable           = optional(bool)
        isSealed              = optional(bool)
        lookup                = optional(any)
        name                  = optional(string)
        number                = optional(any)
        personOrGroup         = optional(any)
        propagateChanges      = optional(bool)
        readOnly              = optional(bool)
        required              = optional(bool)
        sourceColumn          = optional(any)
        term                  = optional(any)
        text                  = optional(any)
        thumbnail             = optional(any)
        validation            = optional(any)
      })))
      welcomePageUrl = optional(string)
    }))
    documentTemplate = optional(object({
      odata_type = optional(string, "#microsoft.graph.documentSetContent")
      contentType = optional(object({
        odata_type = optional(string, "#microsoft.graph.contentTypeInfo")
        id         = optional(string)
        name       = optional(string)
      }))
      fileName   = optional(string)
      folderName = optional(string)
    }))
    group  = optional(string)
    hidden = optional(bool)
    inheritedFrom = optional(object({
      odata_type = optional(string, "#microsoft.graph.itemReference")
      driveType  = optional(string)
      shareId    = optional(string)
      siteId     = optional(string)
    }))
    isBuiltIn = optional(bool)
    name      = optional(string)
    order = optional(object({
      odata_type = optional(string, "#microsoft.graph.contentTypeOrder")
      default    = optional(bool)
      position   = optional(number)
    }))
    parentId         = optional(string)
    propagateChanges = optional(bool)
    readOnly         = optional(bool)
    sealed           = optional(bool)
  }))
  default = null
}

variable "description" {
  description = "Provides a user-visible description of the item. Optional."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The displayable title of the list."
  type        = string
  default     = null
}

variable "drive" {
  description = "Allows access to the list as a drive resource with driveItems. Only present on document libraries."
  type        = any
  default     = null
}

variable "items" {
  description = "All items contained in the list."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.listItem")
    analytics  = optional(any)
    contentType = optional(object({
      odata_type = optional(string, "#microsoft.graph.contentTypeInfo")
      id         = optional(string)
      name       = optional(string)
    }))
    description = optional(string)
    documentSetVersions = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.documentSetVersion")
      comment                   = optional(string)
      createdBy                 = optional(any)
      createdDateTime           = optional(string)
      fields                    = optional(any)
      items                     = optional(any)
      shouldCaptureMinorVersion = optional(bool)
    })))
    driveItem = optional(any)
    fields    = optional(any)
    name      = optional(string)
    parentReference = optional(object({
      odata_type = optional(string, "#microsoft.graph.itemReference")
      driveType  = optional(string)
      shareId    = optional(string)
      siteId     = optional(string)
    }))
    versions = optional(any)
  }))
  default = null
}

variable "list" {
  description = "Contains more details about the list."
  type = object({
    odata_type          = optional(string, "#microsoft.graph.listInfo")
    contentTypesEnabled = optional(bool)
    hidden              = optional(bool)
    template            = optional(string)
  })
  default = null
}

variable "name" {
  description = "The name of the item. Read-write."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.list"
  nullable    = false
}

variable "operations" {
  description = "The collection of long-running operations on the list."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.richLongRunningOperation")
    createdDateTime = optional(string)
    error = optional(object({
      odata_type = optional(string, "#microsoft.graph.publicError")
      code       = optional(string)
      details = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.publicErrorDetail")
        code       = optional(string)
        message    = optional(string)
        target     = optional(string)
      })))
      innerError = optional(object({
        odata_type = optional(string, "#microsoft.graph.publicInnerError")
        code       = optional(string)
        details    = optional(any)
        message    = optional(string)
        target     = optional(string)
      }))
      message = optional(string)
      target  = optional(string)
    }))
    lastActionDateTime = optional(string)
    percentageComplete = optional(number)
    resourceId         = optional(string)
    resourceLocation   = optional(string)
    status             = optional(string)
    statusDetail       = optional(string)
    type               = optional(string)
  }))
  default = null
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

variable "subscriptions" {
  description = "The set of subscriptions on the list."
  type = list(object({
    odata_type                = optional(string, "#microsoft.graph.subscription")
    changeType                = optional(string)
    clientState               = optional(string)
    encryptionCertificate     = optional(string)
    encryptionCertificateId   = optional(string)
    expirationDateTime        = optional(string)
    includeResourceData       = optional(bool)
    latestSupportedTlsVersion = optional(string)
    lifecycleNotificationUrl  = optional(string)
    notificationQueryOptions  = optional(string)
    notificationUrl           = optional(string)
    notificationUrlAppId      = optional(string)
    resource                  = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdByUser", "createdDateTime", "eTag", "id", "lastModifiedBy", "lastModifiedByUser", "lastModifiedDateTime", "permissions", "sharepointIds", "system", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
