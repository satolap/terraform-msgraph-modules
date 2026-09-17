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
    odata_type  = optional(string, "#microsoft.graph.listItem")
    analytics   = optional(any)
    contentType = optional(any)
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
    driveItem       = optional(any)
    fields          = optional(any)
    name            = optional(string)
    parentReference = optional(any)
    versions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.listItemVersion")
      fields     = optional(any)
    })))
  }))
  default = null
}

variable "list" {
  description = "Contains more details about the list."
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
  default     = "#microsoft.graph.list"
  nullable    = false
}

variable "operations" {
  description = "The collection of long-running operations on the list."
  type = list(object({
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
  }))
  default = null
}

variable "parent_reference" {
  description = "Parent information, if the item has a parent. Read-write."
  type        = any
  default     = null
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
