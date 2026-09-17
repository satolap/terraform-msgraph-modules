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
      impactedAssets = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.security.impactedAsset")
      })))
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
    automatedActions    = optional(any)
    organizationalScope = optional(any)
    responseActions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.security.responseAction")
    })))
  })
  default = null
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
  type        = any
  default     = null
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
    condition     = var.status == null ? true : contains(["enabled", "disabled", "autoDisabled", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
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
