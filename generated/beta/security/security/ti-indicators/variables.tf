variable "action" {
  description = "The action to apply if the indicator is matched from within the targetProduct security tool. The possible values are: unknown, allow, block, alert. Required."
  type        = any
  default     = null

  validation {
    condition     = var.action == null ? true : contains(["unknown", "allow", "block", "alert", "unknownFutureValue"], var.action)
    error_message = "action must be one of the documented enum values."
  }
}

variable "activity_group_names" {
  description = "The cyber threat intelligence name(s) for the parties responsible for the malicious activity covered by the threat indicator."
  type        = list(string)
  default     = null
}

variable "additional_information" {
  description = "A catchall area for extra data from the indicator that is not specifically covered by other tiIndicator properties. The security tool specified by targetProduct typically does not utilize this data."
  type        = string
  default     = null
}

variable "azure_tenant_id" {
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

variable "diamond_model" {
  description = "The area of the Diamond Model in which this indicator exists. The possible values are: unknown, adversary, capability, infrastructure, victim."
  type        = any
  default     = null

  validation {
    condition     = var.diamond_model == null ? true : contains(["unknown", "adversary", "capability", "infrastructure", "victim", "unknownFutureValue"], var.diamond_model)
    error_message = "diamond_model must be one of the documented enum values."
  }
}

variable "domain_name" {
  description = "Microsoft Graph domainName property."
  type        = string
  default     = null
}

variable "email_encoding" {
  description = "Microsoft Graph emailEncoding property."
  type        = string
  default     = null
}

variable "email_language" {
  description = "Microsoft Graph emailLanguage property."
  type        = string
  default     = null
}

variable "email_recipient" {
  description = "Microsoft Graph emailRecipient property."
  type        = string
  default     = null
}

variable "email_sender_address" {
  description = "Microsoft Graph emailSenderAddress property."
  type        = string
  default     = null
}

variable "email_sender_name" {
  description = "Microsoft Graph emailSenderName property."
  type        = string
  default     = null
}

variable "email_source_domain" {
  description = "Microsoft Graph emailSourceDomain property."
  type        = string
  default     = null
}

variable "email_source_ip_address" {
  description = "Microsoft Graph emailSourceIpAddress property."
  type        = string
  default     = null
}

variable "email_subject" {
  description = "Microsoft Graph emailSubject property."
  type        = string
  default     = null
}

variable "email_x_mailer" {
  description = "Microsoft Graph emailXMailer property."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "DateTime string indicating when the Indicator expires. All indicators must have an expiration date to avoid stale indicators persisting in the system. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Required."
  type        = string
  default     = null
}

variable "external_id" {
  description = "An identification number that ties the indicator back to the indicator provider’s system (for example, a foreign key)."
  type        = string
  default     = null
}

variable "file_compile_date_time" {
  description = "Microsoft Graph fileCompileDateTime property."
  type        = string
  default     = null
}

variable "file_created_date_time" {
  description = "Microsoft Graph fileCreatedDateTime property."
  type        = string
  default     = null
}

variable "file_hash_type" {
  description = "Microsoft Graph fileHashType property."
  type        = any
  default     = null

  validation {
    condition     = var.file_hash_type == null ? true : contains(["unknown", "sha1", "sha256", "md5", "authenticodeHash256", "lsHash", "ctph", "unknownFutureValue"], var.file_hash_type)
    error_message = "file_hash_type must be one of the documented enum values."
  }
}

variable "file_hash_value" {
  description = "Microsoft Graph fileHashValue property."
  type        = string
  default     = null
}

variable "file_mutex_name" {
  description = "Microsoft Graph fileMutexName property."
  type        = string
  default     = null
}

variable "file_name" {
  description = "Microsoft Graph fileName property."
  type        = string
  default     = null
}

variable "file_packer" {
  description = "Microsoft Graph filePacker property."
  type        = string
  default     = null
}

variable "file_path" {
  description = "Microsoft Graph filePath property."
  type        = string
  default     = null
}

variable "file_size" {
  description = "Microsoft Graph fileSize property."
  type        = number
  default     = null
}

variable "file_type" {
  description = "Microsoft Graph fileType property."
  type        = string
  default     = null
}

variable "ingested_date_time" {
  description = "Stamped by the system when the indicator is ingested. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "is_active" {
  description = "Used to deactivate indicators within system. By default, any indicator submitted is set as active. However, providers may submit existing indicators with this set to ‘False’ to deactivate indicators in the system."
  type        = bool
  default     = null
}

variable "kill_chain" {
  description = "A JSON array of strings that describes which point or points on the Kill Chain this indicator targets. See ‘killChain values’ below for exact values."
  type        = list(string)
  default     = null
}

variable "known_false_positives" {
  description = "Scenarios in which the indicator may cause false positives. This should be human-readable text."
  type        = string
  default     = null
}

variable "last_reported_date_time" {
  description = "The last time the indicator was seen. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "malware_family_names" {
  description = "The malware family name associated with an indicator if it exists. Microsoft prefers the Microsoft malware family name if at all possible that can be found via the Windows Defender Security Intelligence threat encyclopedia."
  type        = list(string)
  default     = null
}

variable "network_cidr_block" {
  description = "Microsoft Graph networkCidrBlock property."
  type        = string
  default     = null
}

variable "network_destination_asn" {
  description = "Microsoft Graph networkDestinationAsn property."
  type        = number
  default     = null
}

variable "network_destination_cidr_block" {
  description = "Microsoft Graph networkDestinationCidrBlock property."
  type        = string
  default     = null
}

variable "network_destination_i_pv4" {
  description = "Microsoft Graph networkDestinationIPv4 property."
  type        = string
  default     = null
}

variable "network_destination_i_pv6" {
  description = "Microsoft Graph networkDestinationIPv6 property."
  type        = string
  default     = null
}

variable "network_destination_port" {
  description = "Microsoft Graph networkDestinationPort property."
  type        = number
  default     = null
}

variable "network_i_pv4" {
  description = "Microsoft Graph networkIPv4 property."
  type        = string
  default     = null
}

variable "network_i_pv6" {
  description = "Microsoft Graph networkIPv6 property."
  type        = string
  default     = null
}

variable "network_port" {
  description = "Microsoft Graph networkPort property."
  type        = number
  default     = null
}

variable "network_protocol" {
  description = "Microsoft Graph networkProtocol property."
  type        = number
  default     = null
}

variable "network_source_asn" {
  description = "Microsoft Graph networkSourceAsn property."
  type        = number
  default     = null
}

variable "network_source_cidr_block" {
  description = "Microsoft Graph networkSourceCidrBlock property."
  type        = string
  default     = null
}

variable "network_source_i_pv4" {
  description = "Microsoft Graph networkSourceIPv4 property."
  type        = string
  default     = null
}

variable "network_source_i_pv6" {
  description = "Microsoft Graph networkSourceIPv6 property."
  type        = string
  default     = null
}

variable "network_source_port" {
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

variable "passive_only" {
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

variable "target_product" {
  description = "A string value representing a single security product to which the indicator should be applied. Acceptable values are: Azure Sentinel, Microsoft Defender ATP. Required"
  type        = string
  default     = null
}

variable "threat_type" {
  description = "Each indicator must have a valid Indicator Threat Type. The possible values are: Botnet, C2, CryptoMining, Darknet, DDoS, MaliciousUrl, Malware, Phishing, Proxy, PUA, WatchList. Required."
  type        = string
  default     = null
}

variable "tlp_level" {
  description = "Traffic Light Protocol value for the indicator. The possible values are: unknown, white, green, amber, red. Required."
  type        = any
  default     = null

  validation {
    condition     = var.tlp_level == null ? true : contains(["unknown", "white", "green", "amber", "red", "unknownFutureValue"], var.tlp_level)
    error_message = "tlp_level must be one of the documented enum values."
  }
}

variable "url" {
  description = "Microsoft Graph url property."
  type        = string
  default     = null
}

variable "user_agent" {
  description = "Microsoft Graph userAgent property."
  type        = string
  default     = null
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
