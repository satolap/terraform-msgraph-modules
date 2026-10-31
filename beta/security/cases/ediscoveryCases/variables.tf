variable "caseMembers" {
  description = "Returns a list of ediscoveryCaseMember objects associated to this case."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.security.ediscoveryCaseMember")
    displayName   = optional(string)
    recipientType = optional(string)
    smtpAddress   = optional(string)
  }))
  default = null

  validation {
    condition     = (var.caseMembers == null ? true : alltrue([alltrue([for input0 in var.caseMembers : (input0 == null ? true : alltrue([(input0["recipientType"] == null ? true : alltrue([(input0["recipientType"] == null ? true : try(alltrue([for value in split(",", input0["recipientType"]) : contains(["user", "rolegroup"], lower(trimspace(value)))]), false))]))]))])]))
    error_message = "caseMembers: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "closedBy" {
  description = "The user who closed the case."
  type        = any
  default     = null
}

variable "closedDateTime" {
  description = "The date and time when the case was closed. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "createdDateTime" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "custodians" {
  description = "Returns a list of case ediscoveryCustodian objects for this case."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.ediscoveryCustodian")
    acknowledgedDateTime = optional(string)
    createdDateTime      = optional(string)
    displayName          = optional(string)
    email                = optional(string)
    holdStatus           = optional(string)
    lastIndexOperation   = optional(any)
    lastModifiedDateTime = optional(string)
    releasedDateTime     = optional(string)
    siteSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.security.siteSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      holdStatus      = optional(string)
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
        lockState              = optional(string)
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
        template               = optional(string)
        termStore              = optional(any)
      }))
    })))
    status = optional(string)
    unifiedGroupSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.security.unifiedGroupSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      group = optional(object({
        odata_type                    = optional(string, "#microsoft.graph.group")
        acceptedSenders               = optional(any)
        accessType                    = optional(string)
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
      holdStatus      = optional(string)
      includedSources = optional(string)
    })))
    userSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.security.userSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      email           = optional(string)
      holdStatus      = optional(string)
      includedSources = optional(string)
    })))
  }))
  default = null

  validation {
    condition     = (var.custodians == null ? true : alltrue([alltrue([for input0 in var.custodians : (input0 == null ? true : alltrue([(input0["holdStatus"] == null ? true : alltrue([(input0["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input0["holdStatus"]))])), (input0["siteSources"] == null ? true : alltrue([alltrue([for input2 in input0["siteSources"] : (input2 == null ? true : alltrue([(input2["holdStatus"] == null ? true : alltrue([(input2["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input2["holdStatus"]))])), (input2["site"] == null ? true : alltrue([(input2["site"]["lockState"] == null ? true : alltrue([(input2["site"]["lockState"] == null ? true : contains(["unlocked", "lockedReadOnly", "lockedNoAccess", "lockedNoAdditions"], input2["site"]["lockState"]))])), (input2["site"]["template"] == null ? true : alltrue([(input2["site"]["template"] == null ? true : contains(["sitepagepublishing", "sts"], input2["site"]["template"]))]))]))]))])])), (input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["active", "released"], input0["status"]))])), (input0["unifiedGroupSources"] == null ? true : alltrue([alltrue([for input2 in input0["unifiedGroupSources"] : (input2 == null ? true : alltrue([(input2["group"] == null ? true : alltrue([(input2["group"]["accessType"] == null ? true : alltrue([(input2["group"]["accessType"] == null ? true : contains(["none", "private", "secret", "public"], input2["group"]["accessType"]))]))])), (input2["holdStatus"] == null ? true : alltrue([(input2["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input2["holdStatus"]))])), (input2["includedSources"] == null ? true : alltrue([(input2["includedSources"] == null ? true : try(alltrue([for value in split(",", input2["includedSources"]) : contains(["mailbox", "site"], lower(trimspace(value)))]), false))]))]))])])), (input0["userSources"] == null ? true : alltrue([alltrue([for input2 in input0["userSources"] : (input2 == null ? true : alltrue([(input2["holdStatus"] == null ? true : alltrue([(input2["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input2["holdStatus"]))])), (input2["includedSources"] == null ? true : alltrue([(input2["includedSources"] == null ? true : try(alltrue([for value in split(",", input2["includedSources"]) : contains(["mailbox", "site"], lower(trimspace(value)))]), false))]))]))])]))]))])]))
    error_message = "custodians: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "displayName" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "externalId" {
  description = "The external case number for customer reference."
  type        = string
  default     = null
}

variable "lastModifiedBy" {
  description = "Microsoft Graph lastModifiedBy property."
  type        = any
  default     = null
}

variable "lastModifiedDateTime" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "legalHolds" {
  description = "Returns a list of case eDiscoveryHoldPolicy objects for this case."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.ediscoveryHoldPolicy")
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
      odata_type      = optional(string, "#microsoft.graph.security.siteSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      holdStatus      = optional(string)
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
        lockState              = optional(string)
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
        template               = optional(string)
        termStore              = optional(any)
      }))
    })))
    status = optional(string)
    userSources = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.security.userSource")
      createdBy       = optional(any)
      createdDateTime = optional(string)
      displayName     = optional(string)
      email           = optional(string)
      holdStatus      = optional(string)
      includedSources = optional(string)
    })))
  }))
  default = null

  validation {
    condition     = (var.legalHolds == null ? true : alltrue([alltrue([for input0 in var.legalHolds : (input0 == null ? true : alltrue([(input0["siteSources"] == null ? true : alltrue([alltrue([for input2 in input0["siteSources"] : (input2 == null ? true : alltrue([(input2["holdStatus"] == null ? true : alltrue([(input2["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input2["holdStatus"]))])), (input2["site"] == null ? true : alltrue([(input2["site"]["lockState"] == null ? true : alltrue([(input2["site"]["lockState"] == null ? true : contains(["unlocked", "lockedReadOnly", "lockedNoAccess", "lockedNoAdditions"], input2["site"]["lockState"]))])), (input2["site"]["template"] == null ? true : alltrue([(input2["site"]["template"] == null ? true : contains(["sitepagepublishing", "sts"], input2["site"]["template"]))]))]))]))])])), (input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["pending", "error", "success"], input0["status"]))])), (input0["userSources"] == null ? true : alltrue([alltrue([for input2 in input0["userSources"] : (input2 == null ? true : alltrue([(input2["holdStatus"] == null ? true : alltrue([(input2["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input2["holdStatus"]))])), (input2["includedSources"] == null ? true : alltrue([(input2["includedSources"] == null ? true : try(alltrue([for value in split(",", input2["includedSources"]) : contains(["mailbox", "site"], lower(trimspace(value)))]), false))]))]))])]))]))])]))
    error_message = "legalHolds: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "noncustodialDataSources" {
  description = "Returns a list of case ediscoveryNoncustodialDataSource objects for this case."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.ediscoveryNoncustodialDataSource")
    createdDateTime      = optional(string)
    dataSource           = optional(any)
    displayName          = optional(string)
    holdStatus           = optional(string)
    lastIndexOperation   = optional(any)
    lastModifiedDateTime = optional(string)
    releasedDateTime     = optional(string)
    status               = optional(string)
  }))
  default = null

  validation {
    condition     = (var.noncustodialDataSources == null ? true : alltrue([alltrue([for input0 in var.noncustodialDataSources : (input0 == null ? true : alltrue([(input0["holdStatus"] == null ? true : alltrue([(input0["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input0["holdStatus"]))])), (input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["active", "released"], input0["status"]))]))]))])]))
    error_message = "noncustodialDataSources: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.ediscoveryCase"
  nullable    = false
}

variable "operations" {
  description = "Returns a list of case caseOperation objects for this case."
  type        = any
  default     = null
}

variable "reviewSets" {
  description = "Returns a list of eDiscoveryReviewSet objects in the case."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.security.ediscoveryReviewSet")
    description = optional(string)
    displayName = optional(string)
    files = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.security.ediscoveryFile")
      content              = optional(string)
      custodian            = optional(any)
      dateTime             = optional(string)
      extension            = optional(string)
      extractedTextContent = optional(string)
      mediaType            = optional(string)
      name                 = optional(string)
      otherProperties      = optional(any)
      processingStatus     = optional(string)
      senderOrAuthors      = optional(list(string))
      size                 = optional(number)
      sourceType           = optional(string)
      subjectTitle         = optional(string)
      tags                 = optional(any)
    })))
    queries = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.security.ediscoveryReviewSetQuery")
      contentQuery         = optional(string)
      createdBy            = optional(any)
      createdDateTime      = optional(string)
      description          = optional(string)
      displayName          = optional(string)
      lastModifiedBy       = optional(any)
      lastModifiedDateTime = optional(string)
    })))
  }))
  default = null

  validation {
    condition     = (var.reviewSets == null ? true : alltrue([alltrue([for input0 in var.reviewSets : (input0 == null ? true : alltrue([(input0["files"] == null ? true : alltrue([alltrue([for input2 in input0["files"] : (input2 == null ? true : alltrue([(input2["processingStatus"] == null ? true : alltrue([(input2["processingStatus"] == null ? true : contains(["success", "internalError", "unknownError", "processingTimeout", "invalidFileId", "fileSizeIsZero", "fileSizeIsTooLarge", "fileDepthLimitExceeded", "fileBodyIsTooLong", "fileTypeIsUnknown", "fileTypeIsNotSupported", "malformedFile", "protectedFile", "poisonFile", "noReviewSetSummaryGenerated", "extractionException", "ocrProcessingTimeout", "ocrFileSizeExceedsLimit"], input2["processingStatus"]))])), (input2["sourceType"] == null ? true : alltrue([(input2["sourceType"] == null ? true : try(alltrue([for value in split(",", input2["sourceType"]) : contains(["mailbox", "site"], lower(trimspace(value)))]), false))]))]))])]))]))])]))
    error_message = "reviewSets: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "searches" {
  description = "Returns a list of eDiscoverySearch objects associated with this case."
  type = list(object({
    odata_type                      = optional(string, "#microsoft.graph.security.ediscoverySearch")
    addToReviewSetOperation         = optional(any)
    additionalSources               = optional(any)
    contentQuery                    = optional(string)
    createdBy                       = optional(any)
    createdDateTime                 = optional(string)
    custodianSources                = optional(any)
    dataSourceScopes                = optional(string)
    description                     = optional(string)
    displayName                     = optional(string)
    lastEstimateStatisticsOperation = optional(any)
    lastModifiedBy                  = optional(any)
    lastModifiedDateTime            = optional(string)
    noncustodialSources = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.security.ediscoveryNoncustodialDataSource")
      createdDateTime      = optional(string)
      dataSource           = optional(any)
      displayName          = optional(string)
      holdStatus           = optional(string)
      lastIndexOperation   = optional(any)
      lastModifiedDateTime = optional(string)
      releasedDateTime     = optional(string)
      status               = optional(string)
    })))
  }))
  default = null

  validation {
    condition     = (var.searches == null ? true : alltrue([alltrue([for input0 in var.searches : (input0 == null ? true : alltrue([(input0["dataSourceScopes"] == null ? true : alltrue([(input0["dataSourceScopes"] == null ? true : try(alltrue([for value in split(",", input0["dataSourceScopes"]) : contains(["none", "alltenantmailboxes", "alltenantsites", "allcasecustodians", "allcasenoncustodialdatasources"], lower(trimspace(value)))]), false))])), (input0["noncustodialSources"] == null ? true : alltrue([alltrue([for input2 in input0["noncustodialSources"] : (input2 == null ? true : alltrue([(input2["holdStatus"] == null ? true : alltrue([(input2["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input2["holdStatus"]))])), (input2["status"] == null ? true : alltrue([(input2["status"] == null ? true : contains(["active", "released"], input2["status"]))]))]))])]))]))])]))
    error_message = "searches: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "settings" {
  description = "Returns a list of eDIscoverySettings objects in the case."
  type        = any
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "active", "pendingDelete", "closing", "closed", "closedWithError"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "tags" {
  description = "Returns a list of ediscoveryReviewTag objects associated to this case."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.ediscoveryReviewTag")
    childSelectability   = optional(string)
    childTags            = optional(any)
    createdBy            = optional(any)
    description          = optional(string)
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    parent               = optional(any)
  }))
  default = null

  validation {
    condition     = (var.tags == null ? true : alltrue([alltrue([for input0 in var.tags : (input0 == null ? true : alltrue([(input0["childSelectability"] == null ? true : alltrue([(input0["childSelectability"] == null ? true : contains(["One", "Many"], input0["childSelectability"]))]))]))])]))
    error_message = "tags: nested required attributes must be non-null and enum values must be supported input members."
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
