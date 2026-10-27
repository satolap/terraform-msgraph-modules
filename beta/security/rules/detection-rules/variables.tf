variable "description" {
  description = "A user-supplied description of the detection rule. Supports $filter (eq, ne, not, in, startsWith, endsWith, contains)."
  type        = string
  default     = null
}

variable "detection_action" {
  description = "Microsoft Graph detectionAction property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.detectionAction")
    alertTemplate = optional(object({
      odata_type    = optional(string, "#microsoft.graph.security.alertTemplate")
      category      = optional(string)
      customDetails = optional(any)
      description   = optional(string)
      entityMappings = optional(object({
        odata_type = optional(string, "#microsoft.graph.security.entityMappingConfiguration")
        accounts = optional(list(object({
          odata_type      = optional(string, "#microsoft.graph.security.accountEntityMapping")
          aadUserIdColumn = optional(string)
          dnsDomainColumn = optional(string)
          nameColumn      = optional(string)
          ntDomainColumn  = optional(string)
          sidColumn       = optional(string)
          upnColumn       = optional(string)
          upnSuffixColumn = optional(string)
        })))
        amazonResources = optional(list(object({
          odata_type             = optional(string, "#microsoft.graph.security.amazonResourceEntityMapping")
          amazonResourceIdColumn = optional(string)
        })))
        azureResources = optional(list(object({
          odata_type       = optional(string, "#microsoft.graph.security.azureResourceEntityMapping")
          resourceIdColumn = optional(string)
        })))
        cloudApplications = optional(list(object({
          odata_type  = optional(string, "#microsoft.graph.security.cloudApplicationEntityMapping")
          appIdColumn = optional(string)
          nameColumn  = optional(string)
        })))
        dns = optional(list(object({
          odata_type          = optional(string, "#microsoft.graph.security.dnsEntityMapping")
          domainNameColumn    = optional(string)
          hostIpAddressColumn = optional(string)
          serverIpColumn      = optional(string)
        })))
        files = optional(list(object({
          odata_type   = optional(string, "#microsoft.graph.security.fileEntityMapping")
          nameColumn   = optional(string)
          sha1Column   = optional(string)
          sha256Column = optional(string)
        })))
        googleCloudResources = optional(list(object({
          odata_type             = optional(string, "#microsoft.graph.security.googleCloudResourceEntityMapping")
          fullResourceNameColumn = optional(string)
        })))
        hosts = optional(list(object({
          odata_type        = optional(string, "#microsoft.graph.security.hostEntityMapping")
          deviceIdColumn    = optional(string)
          dnsDomainColumn   = optional(string)
          nameColumn        = optional(string)
          netBiosNameColumn = optional(string)
          ntDomainColumn    = optional(string)
        })))
        ips = optional(list(object({
          odata_type    = optional(string, "#microsoft.graph.security.ipEntityMapping")
          addressColumn = optional(string)
          scopeColumn   = optional(string)
        })))
        mailClusters = optional(list(object({
          odata_type   = optional(string, "#microsoft.graph.security.mailClusterEntityMapping")
          queryColumn  = optional(string)
          sourceColumn = optional(string)
        })))
        mailMessages = optional(list(object({
          odata_type             = optional(string, "#microsoft.graph.security.mailMessageEntityMapping")
          networkMessageIdColumn = optional(string)
          recipientColumn        = optional(string)
          senderColumn           = optional(string)
          subjectColumn          = optional(string)
        })))
        mailboxes = optional(list(object({
          odata_type           = optional(string, "#microsoft.graph.security.mailboxEntityMapping")
          primaryAddressColumn = optional(string)
        })))
        oAuthApplications = optional(list(object({
          odata_type       = optional(string, "#microsoft.graph.security.oAuthApplicationEntityMapping")
          oAuthAppIdColumn = optional(string)
        })))
        processes = optional(list(object({
          odata_type   = optional(string, "#microsoft.graph.security.processEntityMapping")
          sha1Column   = optional(string)
          sha256Column = optional(string)
        })))
        registryValues = optional(list(object({
          odata_type      = optional(string, "#microsoft.graph.security.registryValueEntityMapping")
          keyColumn       = optional(string)
          valueNameColumn = optional(string)
        })))
        securityGroups = optional(list(object({
          odata_type              = optional(string, "#microsoft.graph.security.securityGroupEntityMapping")
          distinguishedNameColumn = optional(string)
          objectIdColumn          = optional(string)
          sidColumn               = optional(string)
        })))
        urls = optional(list(object({
          odata_type    = optional(string, "#microsoft.graph.security.urlEntityMapping")
          addressColumn = optional(string)
        })))
      }))
      impactedAssets     = optional(any)
      mitreTechniques    = optional(list(string))
      recommendedActions = optional(string)
      severity           = optional(string)
      tactics = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.security.mitreTactic")
        tactic     = optional(string)
        techniques = optional(any)
      })))
      title = optional(string)
    }))
    automatedActions = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.automatedActionSet")
      allowFiles = optional(list(object({
        odata_type       = optional(string, "#microsoft.graph.security.fileAction")
        deviceGroupNames = optional(list(string))
        sha1Column       = optional(string)
        sha256Column     = optional(string)
      })))
      blockFiles = optional(list(object({
        odata_type       = optional(string, "#microsoft.graph.security.fileAction")
        deviceGroupNames = optional(list(string))
        sha1Column       = optional(string)
        sha256Column     = optional(string)
      })))
      collectInvestigationPackages = optional(any)
      disableUsers = optional(list(object({
        odata_type       = optional(string, "#microsoft.graph.security.accountSidAction")
        accountSidColumn = optional(string)
      })))
      forceUserPasswordResets = optional(list(object({
        odata_type       = optional(string, "#microsoft.graph.security.accountSidAction")
        accountSidColumn = optional(string)
      })))
      hardDeleteEmails = optional(list(object({
        odata_type             = optional(string, "#microsoft.graph.security.emailAction")
        networkMessageIdColumn = optional(string)
        recipientColumn        = optional(string)
      })))
      initiateInvestigations = optional(any)
      isolateDevices = optional(list(object({
        odata_type     = optional(string, "#microsoft.graph.security.isolateDeviceAction")
        deviceIdColumn = optional(string)
        isolationType  = optional(string)
      })))
      markUsersAsCompromised = optional(list(object({
        odata_type            = optional(string, "#microsoft.graph.security.accountObjectIdAction")
        accountObjectIdColumn = optional(string)
      })))
      moveEmailsToDeletedItems = optional(list(object({
        odata_type             = optional(string, "#microsoft.graph.security.emailAction")
        networkMessageIdColumn = optional(string)
        recipientColumn        = optional(string)
      })))
      moveEmailsToInbox = optional(list(object({
        odata_type             = optional(string, "#microsoft.graph.security.emailAction")
        networkMessageIdColumn = optional(string)
        recipientColumn        = optional(string)
      })))
      moveEmailsToJunk = optional(list(object({
        odata_type             = optional(string, "#microsoft.graph.security.emailAction")
        networkMessageIdColumn = optional(string)
        recipientColumn        = optional(string)
      })))
      restrictAppExecutions = optional(any)
      runAntivirusScans     = optional(any)
      softDeleteEmails = optional(list(object({
        odata_type             = optional(string, "#microsoft.graph.security.emailAction")
        networkMessageIdColumn = optional(string)
        recipientColumn        = optional(string)
      })))
      stopAndQuarantineFiles = optional(list(object({
        odata_type     = optional(string, "#microsoft.graph.security.stopAndQuarantineFileAction")
        deviceIdColumn = optional(string)
        sha1Column     = optional(string)
      })))
    }))
    incidentConfiguration = optional(object({
      odata_type                        = optional(string, "#microsoft.graph.security.incidentConfiguration")
      isExcludedFromIncidentCorrelation = optional(bool)
    }))
    organizationalScope = optional(object({
      odata_type   = optional(string, "#microsoft.graph.security.organizationalScope")
      deviceGroups = optional(list(string))
      scopeNames   = optional(list(string))
      scopeType    = optional(string)
    }))
    responseActions = optional(any)
  })
  default   = null
  sensitive = true

  validation {
    condition     = (var.detection_action == null ? true : alltrue([(var.detection_action["alertTemplate"] == null ? true : alltrue([(var.detection_action["alertTemplate"]["severity"] == null ? true : alltrue([(var.detection_action["alertTemplate"]["severity"] == null ? true : contains(["unknown", "informational", "low", "medium", "high"], var.detection_action["alertTemplate"]["severity"]))]))])), (var.detection_action["automatedActions"] == null ? true : alltrue([(var.detection_action["automatedActions"]["isolateDevices"] == null ? true : alltrue([alltrue([for input2 in var.detection_action["automatedActions"]["isolateDevices"] : (input2 == null ? true : alltrue([(input2["isolationType"] == null ? true : alltrue([(input2["isolationType"] == null ? true : contains(["full", "selective"], input2["isolationType"]))]))]))])]))])), (var.detection_action["organizationalScope"] == null ? true : alltrue([(var.detection_action["organizationalScope"]["scopeType"] == null ? true : alltrue([(var.detection_action["organizationalScope"]["scopeType"] == null ? true : contains(["deviceGroup"], var.detection_action["organizationalScope"]["scopeType"]))]))]))]))
    error_message = "detection_action: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "detector_id" {
  description = "Internal detector identifier. Deprecated. This property will be removed from this resource on 2026-10-01."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the rule. Supports $filter (eq, ne, not, in, startsWith, endsWith, contains) and $orderby."
  type        = string
  default     = null
}

variable "is_enabled" {
  description = "Indicates whether the rule is turned on for the tenant. Supports $filter (eq, ne, not). Deprecated. Use status instead. This property will be removed from this resource on 2026-10-01."
  type        = bool
  default     = null
}

variable "last_run_details" {
  description = "Runtime execution details for the most recent rule run. Supports $filter on the following nested properties:String: lastRunDetails/failureReason  supports eq, ne, not, in, startsWith, endsWith, contains.DateTimeOffset: lastRunDetails/lastRunDateTime  supports eq, ne, not, le, ge, lt, gt.Enum: lastRunDetails/status, lastRunDetails/errorCode  each supports eq, ne, not, in.Deprecated. This property will be removed from this resource on 2026-10-01. Runtime execution details aren't exposed in the v1.0 API."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.security.runDetails")
    errorCode       = optional(string)
    failureReason   = optional(string)
    lastRunDateTime = optional(string)
    status          = optional(string)
  })
  default = null

  validation {
    condition     = (var.last_run_details == null ? true : alltrue([(var.last_run_details["errorCode"] == null ? true : alltrue([(var.last_run_details["errorCode"] == null ? true : contains(["queryExecutionFailed", "queryExecutionThrottling", "queryExceededResultSize", "queryLimitsExceeded", "queryTimeout", "alertCreationFailed", "alertReportNotFound", "partialRowsFailed"], var.last_run_details["errorCode"]))])), (var.last_run_details["status"] == null ? true : alltrue([(var.last_run_details["status"] == null ? true : contains(["running", "completed", "failed", "partiallyFailed"], var.last_run_details["status"]))]))]))
    error_message = "last_run_details: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.detectionRule"
  nullable    = false
}

variable "query_condition" {
  description = "Microsoft Graph queryCondition property."
  type = object({
    odata_type           = optional(string, "#microsoft.graph.security.queryCondition")
    lastModifiedDateTime = optional(string)
    queryText            = optional(string)
  })
  default = null
}

variable "schedule" {
  description = "Microsoft Graph schedule property."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.security.ruleSchedule")
    frequency       = optional(string)
    nextRunDateTime = optional(string)
    period          = optional(string)
  })
  default = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["enabled", "disabled", "autoDisabled"], var.status)
    error_message = "status must be one of the documented enum values."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
