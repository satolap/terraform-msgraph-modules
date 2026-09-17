variable "case_id" {
  description = "The unique identifier of case"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.case_id)) > 0
    error_message = "case_id must not be empty."
  }
}

variable "custodian_id" {
  description = "The unique identifier of custodian"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.custodian_id)) > 0
    error_message = "custodian_id must not be empty."
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
  description = "The display name of the dataSource, and is the name of the SharePoint site."
  type        = string
  default     = null
}

variable "hold_status" {
  description = "Microsoft Graph holdStatus property."
  type        = any
  default     = null

  validation {
    condition     = var.hold_status == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial", "unknownFutureValue"], var.hold_status)
    error_message = "hold_status must be one of the documented enum values."
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
    contentModels = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.contentModel")
      modelType  = optional(any)
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
      description      = optional(string)
      documentSet      = optional(any)
      documentTemplate = optional(any)
      group            = optional(string)
      hidden           = optional(bool)
      inheritedFrom    = optional(any)
      isBuiltIn        = optional(bool)
      name             = optional(string)
      order            = optional(any)
      parentId         = optional(string)
      propagateChanges = optional(bool)
      readOnly         = optional(bool)
      sealed           = optional(bool)
    })))
    createdByUser = optional(any)
    deleted       = optional(any)
    description   = optional(string)
    documentProcessingJobs = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.documentProcessingJob")
      jobType          = optional(any)
      listItemUniqueId = optional(string)
      status           = optional(any)
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
      parentReference    = optional(any)
      sharePointIds      = optional(any)
    })))
    extensions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.extension")
    })))
    externalColumns = optional(list(object({
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
    informationProtection = optional(any)
    isPersonalSite        = optional(bool)
    items = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.baseItem")
      createdByUser      = optional(any)
      description        = optional(string)
      lastModifiedByUser = optional(any)
      name               = optional(string)
      parentReference    = optional(any)
    })))
    lastModifiedByUser = optional(any)
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
      list               = optional(any)
      name               = optional(string)
      operations = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.richLongRunningOperation")
        createdDateTime    = optional(string)
        error              = optional(any)
        lastActionDateTime = optional(string)
        percentageComplete = optional(number)
        resourceId         = optional(string)
        resourceLocation   = optional(string)
        status             = optional(any)
        statusDetail       = optional(string)
        type               = optional(string)
      })))
      parentReference = optional(any)
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
    lockState = optional(any)
    name      = optional(string)
    onenote   = optional(any)
    operations = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.richLongRunningOperation")
      createdDateTime    = optional(string)
      error              = optional(any)
      lastActionDateTime = optional(string)
      percentageComplete = optional(number)
      resourceId         = optional(string)
      resourceLocation   = optional(string)
      status             = optional(any)
      statusDetail       = optional(string)
      type               = optional(string)
    })))
    ownerIdentityToResolve = optional(any)
    pageTemplates = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.pageTemplate")
      canvasLayout       = optional(any)
      createdByUser      = optional(any)
      description        = optional(string)
      lastModifiedByUser = optional(any)
      name               = optional(string)
      pageLayout         = optional(any)
      parentReference    = optional(any)
      publishingState    = optional(any)
      title              = optional(string)
      titleArea          = optional(any)
      webParts = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.webPart")
      })))
    })))
    pages = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.baseSitePage")
      createdByUser      = optional(any)
      description        = optional(string)
      lastModifiedByUser = optional(any)
      name               = optional(string)
      pageLayout         = optional(any)
      parentReference    = optional(any)
      publishingState    = optional(any)
      title              = optional(string)
    })))
    parentReference = optional(any)
    permissions = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.permission")
      expirationDateTime = optional(string)
    })))
    recycleBin          = optional(any)
    shareByEmailEnabled = optional(bool)
    sites               = optional(any)
    template            = optional(any)
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
