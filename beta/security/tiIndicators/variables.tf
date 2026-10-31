variable "action" {
  description = "The action to apply if the indicator is matched from within the targetProduct security tool. The possible values are: unknown, allow, block, alert. Required."
  type        = string
  default     = null

  validation {
    condition     = var.action == null ? true : contains(["unknown", "allow", "block", "alert"], var.action)
    error_message = "action must be one of the documented enum values."
  }
}

variable "activityGroupNames" {
  description = "The cyber threat intelligence name(s) for the parties responsible for the malicious activity covered by the threat indicator."
  type        = list(string)
  default     = null
}

variable "additionalInformation" {
  description = "A catchall area for extra data from the indicator that is not specifically covered by other tiIndicator properties. The security tool specified by targetProduct typically does not utilize this data."
  type        = string
  default     = null
}

variable "azureTenantId" {
  description = "Stamped by the system when the indicator is ingested. The Microsoft Entra tenant id of submitting client. Required."
  type        = string
  default     = null
}

variable "confidence" {
  description = "An integer representing the confidence the data within the indicator accurately identifies malicious behavior. Acceptable values are 0 – 100 with 100 being the highest."
  type        = number
  default     = null
}

variable "description" {
  description = "Brief description (100 characters or less) of the threat represented by the indicator. Required."
  type        = string
  default     = null
}

variable "diamondModel" {
  description = "The area of the Diamond Model in which this indicator exists. The possible values are: unknown, adversary, capability, infrastructure, victim."
  type        = string
  default     = null

  validation {
    condition     = var.diamondModel == null ? true : contains(["unknown", "adversary", "capability", "infrastructure", "victim"], var.diamondModel)
    error_message = "diamondModel must be one of the documented enum values."
  }
}

variable "domainName" {
  description = "Microsoft Graph domainName property."
  type        = string
  default     = null
}

variable "emailEncoding" {
  description = "Microsoft Graph emailEncoding property."
  type        = string
  default     = null
}

variable "emailLanguage" {
  description = "Microsoft Graph emailLanguage property."
  type        = string
  default     = null
}

variable "emailRecipient" {
  description = "Microsoft Graph emailRecipient property."
  type        = string
  default     = null
}

variable "emailSenderAddress" {
  description = "Microsoft Graph emailSenderAddress property."
  type        = string
  default     = null
}

variable "emailSenderName" {
  description = "Microsoft Graph emailSenderName property."
  type        = string
  default     = null
}

variable "emailSourceDomain" {
  description = "Microsoft Graph emailSourceDomain property."
  type        = string
  default     = null
}

variable "emailSourceIpAddress" {
  description = "Microsoft Graph emailSourceIpAddress property."
  type        = string
  default     = null
}

variable "emailSubject" {
  description = "Microsoft Graph emailSubject property."
  type        = string
  default     = null
}

variable "emailXMailer" {
  description = "Microsoft Graph emailXMailer property."
  type        = string
  default     = null
}

variable "expirationDateTime" {
  description = "DateTime string indicating when the Indicator expires. All indicators must have an expiration date to avoid stale indicators persisting in the system. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Required."
  type        = string
  default     = null
}

variable "externalId" {
  description = "An identification number that ties the indicator back to the indicator provider’s system (for example, a foreign key)."
  type        = string
  default     = null
}

variable "fileCompileDateTime" {
  description = "Microsoft Graph fileCompileDateTime property."
  type        = string
  default     = null
}

variable "fileCreatedDateTime" {
  description = "Microsoft Graph fileCreatedDateTime property."
  type        = string
  default     = null
}

variable "fileHashType" {
  description = "Microsoft Graph fileHashType property."
  type        = string
  default     = null

  validation {
    condition     = var.fileHashType == null ? true : contains(["unknown", "sha1", "sha256", "md5", "authenticodeHash256", "lsHash", "ctph"], var.fileHashType)
    error_message = "fileHashType must be one of the documented enum values."
  }
}

variable "fileHashValue" {
  description = "Microsoft Graph fileHashValue property."
  type        = string
  default     = null
}

variable "fileMutexName" {
  description = "Microsoft Graph fileMutexName property."
  type        = string
  default     = null
}

variable "fileName" {
  description = "Microsoft Graph fileName property."
  type        = string
  default     = null
}

variable "filePacker" {
  description = "Microsoft Graph filePacker property."
  type        = string
  default     = null
}

variable "filePath" {
  description = "Microsoft Graph filePath property."
  type        = string
  default     = null
}

variable "fileSize" {
  description = "Microsoft Graph fileSize property."
  type        = number
  default     = null
}

variable "fileType" {
  description = "Microsoft Graph fileType property."
  type        = string
  default     = null
}

variable "ingestedDateTime" {
  description = "Stamped by the system when the indicator is ingested. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "isActive" {
  description = "Used to deactivate indicators within system. By default, any indicator submitted is set as active. However, providers may submit existing indicators with this set to ‘False’ to deactivate indicators in the system."
  type        = bool
  default     = null
}

variable "killChain" {
  description = "A JSON array of strings that describes which point or points on the Kill Chain this indicator targets. See ‘killChain values’ below for exact values."
  type        = list(string)
  default     = null
}

variable "knownFalsePositives" {
  description = "Scenarios in which the indicator may cause false positives. This should be human-readable text."
  type        = string
  default     = null
}

variable "lastReportedDateTime" {
  description = "The last time the indicator was seen. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "malwareFamilyNames" {
  description = "The malware family name associated with an indicator if it exists. Microsoft prefers the Microsoft malware family name if at all possible that can be found via the Windows Defender Security Intelligence threat encyclopedia."
  type        = list(string)
  default     = null
}

variable "networkCidrBlock" {
  description = "Microsoft Graph networkCidrBlock property."
  type        = string
  default     = null
}

variable "networkDestinationAsn" {
  description = "Microsoft Graph networkDestinationAsn property."
  type        = number
  default     = null
}

variable "networkDestinationCidrBlock" {
  description = "Microsoft Graph networkDestinationCidrBlock property."
  type        = string
  default     = null
}

variable "networkDestinationIPv4" {
  description = "Microsoft Graph networkDestinationIPv4 property."
  type        = string
  default     = null
}

variable "networkDestinationIPv6" {
  description = "Microsoft Graph networkDestinationIPv6 property."
  type        = string
  default     = null
}

variable "networkDestinationPort" {
  description = "Microsoft Graph networkDestinationPort property."
  type        = number
  default     = null
}

variable "networkIPv4" {
  description = "Microsoft Graph networkIPv4 property."
  type        = string
  default     = null
}

variable "networkIPv6" {
  description = "Microsoft Graph networkIPv6 property."
  type        = string
  default     = null
}

variable "networkPort" {
  description = "Microsoft Graph networkPort property."
  type        = number
  default     = null
}

variable "networkProtocol" {
  description = "Microsoft Graph networkProtocol property."
  type        = number
  default     = null
}

variable "networkSourceAsn" {
  description = "Microsoft Graph networkSourceAsn property."
  type        = number
  default     = null
}

variable "networkSourceCidrBlock" {
  description = "Microsoft Graph networkSourceCidrBlock property."
  type        = string
  default     = null
}

variable "networkSourceIPv4" {
  description = "Microsoft Graph networkSourceIPv4 property."
  type        = string
  default     = null
}

variable "networkSourceIPv6" {
  description = "Microsoft Graph networkSourceIPv6 property."
  type        = string
  default     = null
}

variable "networkSourcePort" {
  description = "Microsoft Graph networkSourcePort property."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.tiIndicator"
  nullable    = false
}

variable "passiveOnly" {
  description = "Determines if the indicator should trigger an event that is visible to an end-user. When set to ‘true,’ security tools won't notify the end user that a ‘hit’ has occurred. This is most often treated as audit or silent mode by security products where they'll simply log that a match occurred but won't perform the action. Default value is false."
  type        = bool
  default     = null
}

variable "severity" {
  description = "An integer representing the severity of the malicious behavior identified by the data within the indicator. Acceptable values are 0 – 5 where 5 is the most severe and zero isn't severe at all. Default value is 3."
  type        = number
  default     = null
}

variable "tags" {
  description = "A JSON array of strings that stores arbitrary tags/keywords."
  type        = list(string)
  default     = null
}

variable "targetProduct" {
  description = "A string value representing a single security product to which the indicator should be applied. Acceptable values are: Azure Sentinel, Microsoft Defender ATP. Required"
  type        = string
  default     = null
}

variable "threatType" {
  description = "Each indicator must have a valid Indicator Threat Type. The possible values are: Botnet, C2, CryptoMining, Darknet, DDoS, MaliciousUrl, Malware, Phishing, Proxy, PUA, WatchList. Required."
  type        = string
  default     = null
}

variable "tlpLevel" {
  description = "Traffic Light Protocol value for the indicator. The possible values are: unknown, white, green, amber, red. Required."
  type        = string
  default     = null

  validation {
    condition     = var.tlpLevel == null ? true : contains(["unknown", "white", "green", "amber", "red"], var.tlpLevel)
    error_message = "tlpLevel must be one of the documented enum values."
  }
}

variable "url" {
  description = "Microsoft Graph url property."
  type        = string
  default     = null
}

variable "userAgent" {
  description = "Microsoft Graph userAgent property."
  type        = string
  default     = null
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
