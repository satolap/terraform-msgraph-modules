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

variable "associated_hubs_urls" {
  description = "List of canonical URLs for hub sites with which this content type is associated to. This contains all hub sites where this content type is queued to be enforced or is already enforced. Enforcing a content type means that the content type is applied to the lists in the enforced sites."
  type        = list(string)
  default     = null
}

variable "base" {
  description = "Parent contentType from which this content type is derived."
  type        = any
  default     = null
}

variable "base_types" {
  description = "The collection of content types that are ancestors of this content type."
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
        isSearchable          = optional(bool)
        lookup                = optional(any)
        name                  = optional(string)
        number                = optional(any)
        personOrGroup         = optional(any)
        propagateChanges      = optional(bool)
        readOnly              = optional(bool)
        required              = optional(bool)
        sourceColumn          = optional(any)
        sourceContentType     = optional(any)
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
        isSearchable          = optional(bool)
        lookup                = optional(any)
        name                  = optional(string)
        number                = optional(any)
        personOrGroup         = optional(any)
        propagateChanges      = optional(bool)
        readOnly              = optional(bool)
        required              = optional(bool)
        sourceColumn          = optional(any)
        sourceContentType     = optional(any)
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

variable "column_links" {
  description = "The collection of columns that are required by this content type."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.columnLink")
    name       = optional(string)
  }))
  default = null
}

variable "column_positions" {
  description = "Column order information in a content type."
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

variable "columns" {
  description = "The collection of column definitions for this content type."
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

variable "description" {
  description = "The descriptive text for the item."
  type        = string
  default     = null
}

variable "document_set" {
  description = "Document Set metadata."
  type = object({
    odata_type = optional(string, "#microsoft.graph.documentSet")
    allowedContentTypes = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.contentTypeInfo")
      id         = optional(string)
      name       = optional(string)
    })))
    defaultContents = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.documentSetContent")
      contentType = optional(object({
        odata_type = optional(string, "#microsoft.graph.contentTypeInfo")
        id         = optional(string)
        name       = optional(string)
      }))
      fileName   = optional(string)
      folderName = optional(string)
    })))
    propagateWelcomePageChanges = optional(bool)
    sharedColumns = optional(list(object({
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
        descriptions    = optional(any)
        formula         = optional(string)
      }))
    })))
    shouldPrefixNameToFile = optional(bool)
    welcomePageColumns = optional(list(object({
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
        descriptions    = optional(any)
        formula         = optional(string)
      }))
    })))
    welcomePageUrl = optional(string)
  })
  default = null
}

variable "document_template" {
  description = "Document template metadata. To make sure that documents have consistent content across a site and its subsites, you can associate a Word, Excel, or PowerPoint template with a site content type."
  type = object({
    odata_type = optional(string, "#microsoft.graph.documentSetContent")
    contentType = optional(object({
      odata_type = optional(string, "#microsoft.graph.contentTypeInfo")
      id         = optional(string)
      name       = optional(string)
    }))
    fileName   = optional(string)
    folderName = optional(string)
  })
  default = null
}

variable "group" {
  description = "The name of the group this content type belongs to. Helps organize related content types."
  type        = string
  default     = null
}

variable "hidden" {
  description = "Indicates whether the content type is hidden in the list's 'New' menu."
  type        = bool
  default     = null
}

variable "inherited_from" {
  description = "If this content type is inherited from another scope (like a site), provides a reference to the item where the content type is defined."
  type = object({
    odata_type = optional(string, "#microsoft.graph.itemReference")
    driveType  = optional(string)
    shareId    = optional(string)
    siteId     = optional(string)
  })
  default = null
}

variable "is_built_in" {
  description = "Specifies if a content type is a built-in content type."
  type        = bool
  default     = null
}

variable "name" {
  description = "The name of the content type."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.contentType"
  nullable    = false
}

variable "order" {
  description = "Specifies the order in which the content type appears in the selection UI."
  type = object({
    odata_type = optional(string, "#microsoft.graph.contentTypeOrder")
    default    = optional(bool)
    position   = optional(number)
  })
  default = null
}

variable "parent_id" {
  description = "The unique identifier of the content type."
  type        = string
  default     = null
}

variable "propagate_changes" {
  description = "If true, any changes made to the content type are pushed to inherited content types and lists that implement the content type."
  type        = bool
  default     = null
}

variable "read_only" {
  description = "If true, the content type can't be modified unless this value is first set to false."
  type        = bool
  default     = null
}

variable "sealed" {
  description = "If true, the content type can't be modified by users or through push-down operations. Only site collection administrators can seal or unseal content types."
  type        = bool
  default     = null
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
