variable "case-id" {
  description = "The unique identifier of case"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.case-id)) > 0
    error_message = "case-id must not be empty."
  }
}

variable "custodian-id" {
  description = "The unique identifier of custodian"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.custodian-id)) > 0
    error_message = "custodian-id must not be empty."
  }
}

variable "createdBy" {
  description = "The user who created the dataSource."
  type        = any
  default     = null
}

variable "createdDateTime" {
  description = "The date and time the dataSource was created."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The display name of the dataSource, and is the name of the SharePoint site."
  type        = string
  default     = null
}

variable "holdStatus" {
  description = "Microsoft Graph holdStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.holdStatus == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], var.holdStatus)
    error_message = "holdStatus must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.ediscovery.siteSource"
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

  validation {
    condition     = (var.site == null ? true : alltrue([(var.site["contentModels"] == null ? true : alltrue([alltrue([for input1 in var.site["contentModels"] : (input1 == null ? true : alltrue([(input1["modelType"] == null ? true : alltrue([(input1["modelType"] == null ? true : contains(["teachingMethod", "layoutMethod", "freeformSelectionMethod", "prebuiltContractModel", "prebuiltInvoiceModel", "prebuiltReceiptModel"], input1["modelType"]))]))]))])])), (var.site["documentProcessingJobs"] == null ? true : alltrue([alltrue([for input1 in var.site["documentProcessingJobs"] : (input1 == null ? true : alltrue([(input1["jobType"] == null ? true : alltrue([(input1["jobType"] == null ? true : contains(["file", "folder"], input1["jobType"]))])), (input1["status"] == null ? true : alltrue([(input1["status"] == null ? true : contains(["inProgress", "completed", "failed"], input1["status"]))]))]))])])), (var.site["lists"] == null ? true : alltrue([alltrue([for input1 in var.site["lists"] : (input1 == null ? true : alltrue([(input1["operations"] == null ? true : alltrue([alltrue([for input3 in input1["operations"] : (input3 == null ? true : alltrue([(input3["status"] == null ? true : alltrue([(input3["status"] == null ? true : contains(["notStarted", "running", "succeeded", "failed"], input3["status"]))]))]))])]))]))])])), (var.site["lockState"] == null ? true : alltrue([(var.site["lockState"] == null ? true : contains(["unlocked", "lockedReadOnly", "lockedNoAccess", "lockedNoAdditions"], var.site["lockState"]))])), (var.site["operations"] == null ? true : alltrue([alltrue([for input1 in var.site["operations"] : (input1 == null ? true : alltrue([(input1["status"] == null ? true : alltrue([(input1["status"] == null ? true : contains(["notStarted", "running", "succeeded", "failed"], input1["status"]))]))]))])])), (var.site["pageTemplates"] == null ? true : alltrue([alltrue([for input1 in var.site["pageTemplates"] : (input1 == null ? true : alltrue([(input1["pageLayout"] == null ? true : alltrue([(input1["pageLayout"] == null ? true : contains(["microsoftReserved", "article", "home"], input1["pageLayout"]))])), (input1["titleArea"] == null ? true : alltrue([(input1["titleArea"]["layout"] == null ? true : alltrue([(input1["titleArea"]["layout"] == null ? true : contains(["imageAndTitle", "plain", "colorBlock", "overlap"], input1["titleArea"]["layout"]))])), (input1["titleArea"]["textAlignment"] == null ? true : alltrue([(input1["titleArea"]["textAlignment"] == null ? true : contains(["left", "center"], input1["titleArea"]["textAlignment"]))]))]))]))])])), (var.site["template"] == null ? true : alltrue([(var.site["template"] == null ? true : contains(["sitepagepublishing", "sts"], var.site["template"]))]))]))
    error_message = "site: nested required attributes must be non-null and enum values must be supported input members."
  }
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
