variable "closed_by" {
  description = "The user who closed the case."
  type        = any
  default     = null
}

variable "closed_date_time" {
  description = "The date and time when the case was closed. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the entity was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "custodians" {
  description = "Returns a list of case custodian objects for this case.  Nullable."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.ediscovery.custodian")
    acknowledgedDateTime = optional(string)
    applyHoldToSources   = optional(bool)
    createdDateTime      = optional(string)
    displayName          = optional(string)
    email                = optional(string)
    holdStatus           = optional(any)
    lastIndexOperation   = optional(any)
    lastModifiedDateTime = optional(string)
    releasedDateTime     = optional(string)
    siteSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.ediscovery.siteSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      holdStatus      = optional(any)
      site = optional(object({
        odata_type             = optional(string, "#microsoft.graph.site")
        analytics              = optional(any)
        columns                = optional(any)
        contentModels          = optional(any)
        contentTypes           = optional(any)
        createdByUser          = optional(any)
        deleted                = optional(any)
        description            = optional(string)
        documentProcessingJobs = optional(any)
        drive                  = optional(any)
        drives                 = optional(any)
        extensions             = optional(any)
        externalColumns        = optional(any)
        informationProtection  = optional(any)
        isPersonalSite         = optional(bool)
        items                  = optional(any)
        lastModifiedByUser     = optional(any)
        lists                  = optional(any)
        locale                 = optional(string)
        lockState              = optional(any)
        name                   = optional(string)
        onenote                = optional(any)
        operations             = optional(any)
        ownerIdentityToResolve = optional(any)
        pageTemplates          = optional(any)
        pages                  = optional(any)
        parentReference        = optional(any)
        permissions            = optional(any)
        recycleBin             = optional(any)
        shareByEmailEnabled    = optional(bool)
        sites                  = optional(any)
        template               = optional(any)
        termStore              = optional(any)
      }))
    })))
    status = optional(any)
    unifiedGroupSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.ediscovery.unifiedGroupSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      group = optional(object({
        odata_type                    = optional(string, "#microsoft.graph.group")
        acceptedSenders               = optional(any)
        accessType                    = optional(any)
        allowExternalSenders          = optional(bool)
        appRoleAssignments            = optional(any)
        assignedLabels                = optional(any)
        autoSubscribeNewMembers       = optional(bool)
        classification                = optional(string)
        cloudLicensing                = optional(any)
        conversations                 = optional(any)
        deletedDateTime               = optional(string)
        description                   = optional(string)
        displayName                   = optional(string)
        events                        = optional(any)
        groupTypes                    = optional(any)
        hasMembersWithLicenseErrors   = optional(bool)
        hideFromAddressLists          = optional(bool)
        hideFromOutlookClients        = optional(bool)
        infoCatalogs                  = optional(any)
        isAssignableToRole            = optional(bool)
        isFavorite                    = optional(bool)
        isSubscribedByMail            = optional(bool)
        mailEnabled                   = optional(bool)
        mailNickname                  = optional(string)
        members                       = optional(any)
        membershipRule                = optional(string)
        membershipRuleProcessingState = optional(string)
        onPremisesExtensionAttributes = optional(any)
        onPremisesProvisioningErrors  = optional(any)
        onPremisesSyncBehavior        = optional(any)
        onenote                       = optional(any)
        organizationId                = optional(string)
        owners                        = optional(any)
        permissionGrants              = optional(any)
        photo                         = optional(any)
        preferredDataLocation         = optional(string)
        preferredLanguage             = optional(string)
        rejectedSenders               = optional(any)
        resourceBehaviorOptions       = optional(any)
        resourceProvisioningOptions   = optional(any)
        securityEnabled               = optional(bool)
        serviceProvisioningErrors     = optional(any)
        settings                      = optional(any)
        sites                         = optional(any)
        team                          = optional(any)
        theme                         = optional(string)
        threads                       = optional(any)
        transitiveMemberOf            = optional(any)
        transitiveMembers             = optional(any)
        unseenConversationsCount      = optional(number)
        unseenCount                   = optional(number)
        unseenMessagesCount           = optional(number)
        visibility                    = optional(string)
        welcomeMessageEnabled         = optional(bool)
        writebackConfiguration        = optional(any)
      }))
      holdStatus      = optional(any)
      includedSources = optional(any)
    })))
    userSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.ediscovery.userSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      email           = optional(string)
      holdStatus      = optional(any)
      includedSources = optional(any)
    })))
  }))
  default = null
}

variable "description" {
  description = "The case description."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The case name."
  type        = string
  default     = null
}

variable "external_id" {
  description = "The external case number for customer reference."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The last user who modified the entity."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The latest date and time when the case was modified. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "legal_holds" {
  description = "Returns a list of case legalHold objects for this case.  Nullable."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.ediscovery.legalHold")
    contentQuery         = optional(string)
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    description          = optional(string)
    displayName          = optional(string)
    errors               = optional(list(string))
    isEnabled            = optional(bool)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    siteSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.ediscovery.siteSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      holdStatus      = optional(any)
      site = optional(object({
        odata_type             = optional(string, "#microsoft.graph.site")
        analytics              = optional(any)
        columns                = optional(any)
        contentModels          = optional(any)
        contentTypes           = optional(any)
        createdByUser          = optional(any)
        deleted                = optional(any)
        description            = optional(string)
        documentProcessingJobs = optional(any)
        drive                  = optional(any)
        drives                 = optional(any)
        extensions             = optional(any)
        externalColumns        = optional(any)
        informationProtection  = optional(any)
        isPersonalSite         = optional(bool)
        items                  = optional(any)
        lastModifiedByUser     = optional(any)
        lists                  = optional(any)
        locale                 = optional(string)
        lockState              = optional(any)
        name                   = optional(string)
        onenote                = optional(any)
        operations             = optional(any)
        ownerIdentityToResolve = optional(any)
        pageTemplates          = optional(any)
        pages                  = optional(any)
        parentReference        = optional(any)
        permissions            = optional(any)
        recycleBin             = optional(any)
        shareByEmailEnabled    = optional(bool)
        sites                  = optional(any)
        template               = optional(any)
        termStore              = optional(any)
      }))
    })))
    status = optional(any)
    unifiedGroupSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.ediscovery.unifiedGroupSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      group = optional(object({
        odata_type                    = optional(string, "#microsoft.graph.group")
        acceptedSenders               = optional(any)
        accessType                    = optional(any)
        allowExternalSenders          = optional(bool)
        appRoleAssignments            = optional(any)
        assignedLabels                = optional(any)
        autoSubscribeNewMembers       = optional(bool)
        classification                = optional(string)
        cloudLicensing                = optional(any)
        conversations                 = optional(any)
        deletedDateTime               = optional(string)
        description                   = optional(string)
        displayName                   = optional(string)
        events                        = optional(any)
        groupTypes                    = optional(any)
        hasMembersWithLicenseErrors   = optional(bool)
        hideFromAddressLists          = optional(bool)
        hideFromOutlookClients        = optional(bool)
        infoCatalogs                  = optional(any)
        isAssignableToRole            = optional(bool)
        isFavorite                    = optional(bool)
        isSubscribedByMail            = optional(bool)
        mailEnabled                   = optional(bool)
        mailNickname                  = optional(string)
        members                       = optional(any)
        membershipRule                = optional(string)
        membershipRuleProcessingState = optional(string)
        onPremisesExtensionAttributes = optional(any)
        onPremisesProvisioningErrors  = optional(any)
        onPremisesSyncBehavior        = optional(any)
        onenote                       = optional(any)
        organizationId                = optional(string)
        owners                        = optional(any)
        permissionGrants              = optional(any)
        photo                         = optional(any)
        preferredDataLocation         = optional(string)
        preferredLanguage             = optional(string)
        rejectedSenders               = optional(any)
        resourceBehaviorOptions       = optional(any)
        resourceProvisioningOptions   = optional(any)
        securityEnabled               = optional(bool)
        serviceProvisioningErrors     = optional(any)
        settings                      = optional(any)
        sites                         = optional(any)
        team                          = optional(any)
        theme                         = optional(string)
        threads                       = optional(any)
        transitiveMemberOf            = optional(any)
        transitiveMembers             = optional(any)
        unseenConversationsCount      = optional(number)
        unseenCount                   = optional(number)
        unseenMessagesCount           = optional(number)
        visibility                    = optional(string)
        welcomeMessageEnabled         = optional(bool)
        writebackConfiguration        = optional(any)
      }))
      holdStatus      = optional(any)
      includedSources = optional(any)
    })))
    userSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.ediscovery.userSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      email           = optional(string)
      holdStatus      = optional(any)
      includedSources = optional(any)
    })))
  }))
  default = null
}

variable "noncustodial_data_sources" {
  description = "Returns a list of case noncustodialDataSource objects for this case.  Nullable."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.ediscovery.noncustodialDataSource")
    applyHoldToSource    = optional(bool)
    createdDateTime      = optional(string)
    dataSource           = optional(any)
    displayName          = optional(string)
    holdStatus           = optional(any)
    lastIndexOperation   = optional(any)
    lastModifiedDateTime = optional(string)
    releasedDateTime     = optional(string)
    status               = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.ediscovery.case"
  nullable    = false
}

variable "operations" {
  description = "Returns a list of case operation objects for this case. Nullable."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.ediscovery.caseOperation")
    action            = optional(any)
    completedDateTime = optional(string)
    createdBy         = optional(any)
    createdDateTime   = optional(string)
    percentProgress   = optional(number)
    resultInfo        = optional(any)
    status            = optional(any)
  }))
  default = null
}

variable "settings" {
  description = "Microsoft Graph settings property."
  type        = any
  default     = null
}

variable "source_collections" {
  description = "Returns a list of sourceCollection objects associated with this case."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.ediscovery.sourceCollection")
    addToReviewSetOperation = optional(any)
    additionalSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.ediscovery.dataSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      holdStatus      = optional(any)
    })))
    contentQuery    = optional(string)
    createdBy       = optional(any)
    createdDateTime = optional(string)
    custodianSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.ediscovery.dataSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      holdStatus      = optional(any)
    })))
    dataSourceScopes                = optional(any)
    description                     = optional(string)
    displayName                     = optional(string)
    lastEstimateStatisticsOperation = optional(any)
    lastModifiedBy                  = optional(any)
    lastModifiedDateTime            = optional(string)
    noncustodialSources = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.ediscovery.noncustodialDataSource")
      applyHoldToSource    = optional(bool)
      createdDateTime      = optional(string)
      dataSource           = optional(any)
      displayName          = optional(string)
      holdStatus           = optional(any)
      lastIndexOperation   = optional(any)
      lastModifiedDateTime = optional(string)
      releasedDateTime     = optional(string)
      status               = optional(any)
    })))
  }))
  default = null
}

variable "status" {
  description = "The case status. Possible values are unknown, active, pendingDelete, closing, closed, and closedWithError. For details, see the following table."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "active", "pendingDelete", "closing", "closed", "closedWithError"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "tags" {
  description = "Returns a list of tag objects associated to this case."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.ediscovery.tag")
    childSelectability   = optional(any)
    childTags            = optional(any)
    createdBy            = optional(any)
    description          = optional(string)
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    parent               = optional(any)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "reviewSets"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
