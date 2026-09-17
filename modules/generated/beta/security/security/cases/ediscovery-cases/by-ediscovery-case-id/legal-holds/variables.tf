variable "ediscovery_case_id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_case_id)) > 0
    error_message = "ediscovery_case_id must not be empty."
  }
}

variable "content_query" {
  description = "KQL query that specifies content to be held in the specified locations. To learn more, see Keyword queries and search conditions for Content Search and eDiscovery.  To hold all content in the specified locations, leave contentQuery blank."
  type        = string
  default     = null
}

variable "created_by" {
  description = "Microsoft Graph createdBy property."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "errors" {
  description = "Lists any errors that happened while placing the hold."
  type        = list(string)
  default     = null
}

variable "is_enabled" {
  description = "Indicates whether the hold is enabled and actively holding content."
  type        = bool
  default     = null
}

variable "last_modified_by" {
  description = "Microsoft Graph lastModifiedBy property."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.ediscoveryHoldPolicy"
  nullable    = false
}

variable "site_sources" {
  description = "Data sources that represent SharePoint sites."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.security.siteSource")
    createdBy       = optional(any)
    createdDateTime = optional(string)
    displayName     = optional(string)
    holdStatus      = optional(any)
    site = optional(object({
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
        odata_type         = optional(string, "#microsoft.graph.drive")
        activities         = optional(any)
        bundles            = optional(any)
        createdByUser      = optional(any)
        description        = optional(string)
        following          = optional(any)
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
        odata_type         = optional(string, "#microsoft.graph.list")
        activities         = optional(any)
        columns            = optional(any)
        contentTypes       = optional(any)
        createdByUser      = optional(any)
        description        = optional(string)
        displayName        = optional(string)
        drive              = optional(any)
        items              = optional(any)
        lastModifiedByUser = optional(any)
        list               = optional(any)
        name               = optional(string)
        operations         = optional(any)
        parentReference    = optional(any)
        subscriptions      = optional(any)
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
        webParts           = optional(any)
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
    }))
  }))
  default = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["pending", "error", "success", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "user_sources" {
  description = "Data sources that represent Exchange mailboxes."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.security.userSource")
    createdBy       = optional(any)
    createdDateTime = optional(string)
    displayName     = optional(string)
    email           = optional(string)
    holdStatus      = optional(any)
    includedSources = optional(any)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
