variable "ediscovery_case_id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_case_id)) > 0
    error_message = "ediscovery_case_id must not be empty."
  }
}

variable "ediscovery_hold_policy_id" {
  description = "The unique identifier of ediscoveryHoldPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_hold_policy_id)) > 0
    error_message = "ediscovery_hold_policy_id must not be empty."
  }
}

variable "created_by" {
  description = "The user who created the dataSource."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time the dataSource was created."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the dataSource and is the name of the SharePoint site."
  type        = string
  default     = null
}

variable "hold_status" {
  description = "The hold status of the dataSource.The possible values are: notApplied, applied, applying, removing, partial"
  type        = string
  default     = null

  validation {
    condition     = var.hold_status == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial", "unknownFutureValue"], var.hold_status)
    error_message = "hold_status must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.siteSource"
  nullable    = false
}

variable "site" {
  description = "Microsoft Graph site property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.site")
    analytics  = optional(any)
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
    contentModels = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.contentModel")
      modelType  = optional(string)
      name       = optional(string)
    })))
    contentTypes = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.contentType")
      associatedHubsUrls = optional(list(string))
      base               = optional(any)
      baseTypes          = optional(any)
      columnLinks = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.columnLink")
        name       = optional(string)
      })))
      columnPositions = optional(list(object({
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
      columns = optional(list(object({
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
      description = optional(string)
      documentSet = optional(object({
        odata_type                  = optional(string, "#microsoft.graph.documentSet")
        allowedContentTypes         = optional(any)
        defaultContents             = optional(any)
        propagateWelcomePageChanges = optional(bool)
        sharedColumns               = optional(any)
        shouldPrefixNameToFile      = optional(bool)
        welcomePageColumns          = optional(any)
        welcomePageUrl              = optional(string)
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
    })))
    createdByUser = optional(any)
    deleted = optional(object({
      odata_type = optional(string, "#microsoft.graph.deleted")
      state      = optional(string)
    }))
    description = optional(string)
    documentProcessingJobs = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.documentProcessingJob")
      jobType          = optional(string)
      listItemUniqueId = optional(string)
      status           = optional(string)
    })))
    drive = optional(any)
    drives = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.drive")
      activities = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.itemActivityOLD")
        action     = optional(any)
        actor      = optional(any)
        driveItem  = optional(any)
        listItem   = optional(any)
        times      = optional(any)
      })))
      bundles = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.driveItem")
        activities         = optional(any)
        analytics          = optional(any)
        content            = optional(string)
        contentStream      = optional(string)
        createdByUser      = optional(any)
        description        = optional(string)
        extensions         = optional(any)
        fileSystemInfo     = optional(any)
        lastModifiedByUser = optional(any)
        media              = optional(any)
        name               = optional(string)
        parentReference    = optional(any)
        retentionLabel     = optional(any)
        root               = optional(any)
        subscriptions      = optional(any)
        webDavUrl          = optional(string)
        workbook           = optional(any)
      })))
      createdByUser = optional(any)
      description   = optional(string)
      following = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.driveItem")
        activities         = optional(any)
        analytics          = optional(any)
        content            = optional(string)
        contentStream      = optional(string)
        createdByUser      = optional(any)
        description        = optional(string)
        extensions         = optional(any)
        fileSystemInfo     = optional(any)
        lastModifiedByUser = optional(any)
        media              = optional(any)
        name               = optional(string)
        parentReference    = optional(any)
        retentionLabel     = optional(any)
        root               = optional(any)
        subscriptions      = optional(any)
        webDavUrl          = optional(string)
        workbook           = optional(any)
      })))
      lastModifiedByUser = optional(any)
      name               = optional(string)
      parentReference = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemReference")
        driveType  = optional(string)
        shareId    = optional(string)
        siteId     = optional(string)
      }))
      sharePointIds = optional(object({
        odata_type       = optional(string, "#microsoft.graph.sharepointIds")
        listId           = optional(string)
        listItemId       = optional(string)
        listItemUniqueId = optional(string)
        siteId           = optional(string)
        siteUrl          = optional(string)
        tenantId         = optional(string)
        webId            = optional(string)
      }))
    })))
    extensions = optional(any)
    externalColumns = optional(list(object({
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
    informationProtection = optional(any)
    isPersonalSite        = optional(bool)
    items                 = optional(any)
    lastModifiedByUser    = optional(any)
    lists = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.list")
      activities = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.itemActivityOLD")
        action     = optional(any)
        actor      = optional(any)
        driveItem  = optional(any)
        listItem   = optional(any)
        times      = optional(any)
      })))
      columns = optional(list(object({
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
      contentTypes = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.contentType")
        associatedHubsUrls = optional(any)
        base               = optional(any)
        baseTypes          = optional(any)
        columnLinks        = optional(any)
        columnPositions    = optional(any)
        columns            = optional(any)
        description        = optional(string)
        documentSet        = optional(any)
        documentTemplate   = optional(any)
        group              = optional(string)
        hidden             = optional(bool)
        inheritedFrom      = optional(any)
        isBuiltIn          = optional(bool)
        name               = optional(string)
        order              = optional(any)
        parentId           = optional(string)
        propagateChanges   = optional(bool)
        readOnly           = optional(bool)
        sealed             = optional(bool)
      })))
      createdByUser = optional(any)
      description   = optional(string)
      displayName   = optional(string)
      drive         = optional(any)
      items = optional(list(object({
        odata_type          = optional(string, "#microsoft.graph.listItem")
        activities          = optional(any)
        analytics           = optional(any)
        contentType         = optional(any)
        createdByUser       = optional(any)
        deleted             = optional(any)
        description         = optional(string)
        documentSetVersions = optional(any)
        driveItem           = optional(any)
        fields              = optional(any)
        lastModifiedByUser  = optional(any)
        name                = optional(string)
        parentReference     = optional(any)
        versions            = optional(any)
      })))
      lastModifiedByUser = optional(any)
      list = optional(object({
        odata_type          = optional(string, "#microsoft.graph.listInfo")
        contentTypesEnabled = optional(bool)
        hidden              = optional(bool)
        template            = optional(string)
      }))
      name = optional(string)
      operations = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.richLongRunningOperation")
        createdDateTime    = optional(string)
        error              = optional(any)
        lastActionDateTime = optional(string)
        percentageComplete = optional(number)
        resourceId         = optional(string)
        resourceLocation   = optional(string)
        status             = optional(string)
        statusDetail       = optional(string)
        type               = optional(string)
      })))
      parentReference = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemReference")
        driveType  = optional(string)
        shareId    = optional(string)
        siteId     = optional(string)
      }))
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
    })))
    locale    = optional(string)
    lockState = optional(string)
    name      = optional(string)
    onenote   = optional(any)
    operations = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.richLongRunningOperation")
      createdDateTime = optional(string)
      error = optional(object({
        odata_type = optional(string, "#microsoft.graph.publicError")
        code       = optional(string)
        details    = optional(any)
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
    })))
    ownerIdentityToResolve = optional(object({
      odata_type = optional(string, "#microsoft.graph.identityInput")
      alias      = optional(string)
      email      = optional(string)
      objectId   = optional(string)
    }))
    pageTemplates = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.pageTemplate")
      canvasLayout       = optional(any)
      createdByUser      = optional(any)
      description        = optional(string)
      lastModifiedByUser = optional(any)
      name               = optional(string)
      pageLayout         = optional(string)
      parentReference = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemReference")
        driveType  = optional(string)
        shareId    = optional(string)
        siteId     = optional(string)
      }))
      publishingState = optional(object({
        odata_type   = optional(string, "#microsoft.graph.publicationFacet")
        checkedOutBy = optional(any)
      }))
      title = optional(string)
      titleArea = optional(object({
        odata_type           = optional(string, "#microsoft.graph.titleArea")
        alternativeText      = optional(string)
        enableGradientEffect = optional(bool)
        imageWebUrl          = optional(string)
        layout               = optional(string)
        serverProcessedContent = optional(object({
          odata_type            = optional(string, "#microsoft.graph.serverProcessedContent")
          componentDependencies = optional(any)
          customMetadata        = optional(any)
          htmlStrings           = optional(any)
          imageSources          = optional(any)
          links                 = optional(any)
          searchablePlainTexts  = optional(any)
        }))
        showAuthor              = optional(bool)
        showPublishedDate       = optional(bool)
        showTextBlockAboveTitle = optional(bool)
        textAboveTitle          = optional(string)
        textAlignment           = optional(string)
      }))
      webParts = optional(any)
    })))
    pages = optional(any)
    parentReference = optional(object({
      odata_type = optional(string, "#microsoft.graph.itemReference")
      driveType  = optional(string)
      shareId    = optional(string)
      siteId     = optional(string)
    }))
    permissions = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.permission")
      expirationDateTime = optional(string)
    })))
    recycleBin          = optional(any)
    shareByEmailEnabled = optional(bool)
    sites               = optional(any)
    template            = optional(string)
    termStore           = optional(any)
  })
  default   = null
  sensitive = true
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
