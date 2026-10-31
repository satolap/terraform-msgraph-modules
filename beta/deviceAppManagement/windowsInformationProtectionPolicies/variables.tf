variable "assignments" {
  description = "Navigation property to list of security groups targeted for policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.targetedManagedAppPolicyAssignment")
    source     = optional(string)
    sourceId   = optional(string)
    target     = optional(any)
  }))
  default = null

  validation {
    condition     = (var.assignments == null ? true : alltrue([alltrue([for input0 in var.assignments : (input0 == null ? true : alltrue([(input0["source"] == null ? true : alltrue([(input0["source"] == null ? true : contains(["direct", "policySets"], input0["source"]))]))]))])]))
    error_message = "assignments: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "azureRightsManagementServicesAllowed" {
  description = "Specifies whether to allow Azure RMS encryption for WIP"
  type        = bool
  default     = null
}

variable "createdDateTime" {
  description = "The date and time the policy was created."
  type        = string
  default     = null
}

variable "dataRecoveryCertificate" {
  description = "Specifies a recovery certificate that can be used for data recovery of encrypted files. This is the same as the data recovery agent(DRA) certificate for encrypting file system(EFS)"
  type = object({
    odata_type         = optional(string, "#microsoft.graph.windowsInformationProtectionDataRecoveryCertificate")
    certificate        = optional(string)
    description        = optional(string)
    expirationDateTime = optional(string)
    subjectName        = optional(string)
  })
  default = null
}

variable "daysWithoutContactBeforeUnenroll" {
  description = "Offline interval before app data is wiped (days) . Valid values 0 to 999"
  type        = number
  default     = null
}

variable "description" {
  description = "The policy's description."
  type        = string
  default     = null
}

variable "displayName" {
  description = "Policy display name."
  type        = string
  default     = null
}

variable "enforcementLevel" {
  description = "Possible values for WIP Protection enforcement levels"
  type        = string
  default     = null

  validation {
    condition     = var.enforcementLevel == null ? true : contains(["noProtection", "encryptAndAuditOnly", "encryptAuditAndPrompt", "encryptAuditAndBlock"], var.enforcementLevel)
    error_message = "enforcementLevel must be one of the documented enum values."
  }
}

variable "enterpriseDomain" {
  description = "Primary enterprise domain"
  type        = string
  default     = null
}

variable "enterpriseIPRanges" {
  description = "Sets the enterprise IP ranges that define the computers in the enterprise network. Data that comes from those computers will be considered part of the enterprise and protected. These locations will be considered a safe destination for enterprise data to be shared to"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionIPRangeCollection")
    displayName = optional(string)
    ranges      = optional(any)
  }))
  default = null
}

variable "enterpriseIPRangesAreAuthoritative" {
  description = "Boolean value that tells the client to accept the configured list and not to use heuristics to attempt to find other subnets. Default is false"
  type        = bool
  default     = null
}

variable "enterpriseInternalProxyServers" {
  description = "This is the comma-separated list of internal proxy servers. For example, '157.54.14.28, 157.54.11.118, 10.202.14.167, 157.53.14.163, 157.69.210.59'. These proxies have been configured by the admin to connect to specific resources on the Internet. They are considered to be enterprise network locations. The proxies are only leveraged in configuring the EnterpriseProxiedDomains policy to force traffic to the matched domains through these proxies"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
  }))
  default = null
}

variable "enterpriseNetworkDomainNames" {
  description = "This is the list of domains that comprise the boundaries of the enterprise. Data from one of these domains that is sent to a device will be considered enterprise data and protected These locations will be considered a safe destination for enterprise data to be shared to"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
  }))
  default = null
}

variable "enterpriseProtectedDomainNames" {
  description = "List of enterprise domains to be protected"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
  }))
  default = null
}

variable "enterpriseProxiedDomains" {
  description = "Contains a list of Enterprise resource domains hosted in the cloud that need to be protected. Connections to these resources are considered enterprise data. If a proxy is paired with a cloud resource, traffic to the cloud resource will be routed through the enterprise network via the denoted proxy server (on Port 80). A proxy server used for this purpose must also be configured using the EnterpriseInternalProxyServers policy"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionProxiedDomainCollection")
    displayName = optional(string)
    proxiedDomains = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.proxiedDomain")
      ipAddressOrFQDN = optional(string)
      proxy           = optional(string)
    })))
  }))
  default = null
}

variable "enterpriseProxyServers" {
  description = "This is a list of proxy servers. Any server not on this list is considered non-enterprise"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
  }))
  default = null
}

variable "enterpriseProxyServersAreAuthoritative" {
  description = "Boolean value that tells the client to accept the configured list of proxies and not try to detect other work proxies. Default is false"
  type        = bool
  default     = null
}

variable "exemptAppLockerFiles" {
  description = "Another way to input exempt apps through xml files"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionAppLockerFile")
    displayName = optional(string)
    file        = optional(string)
    fileHash    = optional(string)
    version     = optional(string)
  }))
  default = null
}

variable "exemptApps" {
  description = "Exempt applications can also access enterprise data, but the data handled by those applications are not protected. This is because some critical enterprise applications may have compatibility problems with encrypted data."
  type        = any
  default     = null
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "iconsVisible" {
  description = "Determines whether overlays are added to icons for WIP protected files in Explorer and enterprise only app tiles in the Start menu. Starting in Windows 10, version 1703 this setting also configures the visibility of the WIP icon in the title bar of a WIP-protected app"
  type        = bool
  default     = null
}

variable "indexingEncryptedStoresOrItemsBlocked" {
  description = "This switch is for the Windows Search Indexer, to allow or disallow indexing of items"
  type        = bool
  default     = null
}

variable "isAssigned" {
  description = "Indicates if the policy is deployed to any inclusion groups or not."
  type        = bool
  default     = null
}

variable "lastModifiedDateTime" {
  description = "Last time the policy was modified."
  type        = string
  default     = null
}

variable "mdmEnrollmentUrl" {
  description = "Enrollment url for the MDM"
  type        = string
  default     = null
}

variable "minutesOfInactivityBeforeDeviceLock" {
  description = "Specifies the maximum amount of time (in minutes) allowed after the device is idle that will cause the device to become PIN or password locked.   Range is an integer X where 0 <= X <= 999. Valid values 0 to 999"
  type        = number
  default     = null
}

variable "neutralDomainResources" {
  description = "List of domain names that can used for work or personal resource"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
  }))
  default = null
}

variable "numberOfPastPinsRemembered" {
  description = "Integer value that specifies the number of past PINs that can be associated to a user account that can't be reused. The largest number you can configure for this policy setting is 50. The lowest number you can configure for this policy setting is 0. If this policy is set to 0, then storage of previous PINs is not required. This node was added in Windows 10, version 1511. Default is 0. Valid values 0 to 50"
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsInformationProtectionPolicy"
  nullable    = false
}

variable "passwordMaximumAttemptCount" {
  description = "The number of authentication failures allowed before the device will be wiped. A value of 0 disables device wipe functionality. Range is an integer X where 4 <= X <= 16 for desktop and 0 <= X <= 999 for mobile devices. Valid values 0 to 999"
  type        = number
  default     = null
  sensitive   = true
}

variable "pinExpirationDays" {
  description = "Integer value specifies the period of time (in days) that a PIN can be used before the system requires the user to change it. The largest number you can configure for this policy setting is 730. The lowest number you can configure for this policy setting is 0. If this policy is set to 0, then the user's PIN will never expire. This node was added in Windows 10, version 1511. Default is 0. Valid values 0 to 730"
  type        = number
  default     = null
}

variable "pinLowercaseLetters" {
  description = "Pin Character Requirements"
  type        = string
  default     = null

  validation {
    condition     = var.pinLowercaseLetters == null ? true : contains(["notAllow", "requireAtLeastOne", "allow"], var.pinLowercaseLetters)
    error_message = "pinLowercaseLetters must be one of the documented enum values."
  }
}

variable "pinMinimumLength" {
  description = "Integer value that sets the minimum number of characters required for the PIN. Default value is 4. The lowest number you can configure for this policy setting is 4. The largest number you can configure must be less than the number configured in the Maximum PIN length policy setting or the number 127, whichever is the lowest. Valid values 0 to 127"
  type        = number
  default     = null
}

variable "pinSpecialCharacters" {
  description = "Pin Character Requirements"
  type        = string
  default     = null

  validation {
    condition     = var.pinSpecialCharacters == null ? true : contains(["notAllow", "requireAtLeastOne", "allow"], var.pinSpecialCharacters)
    error_message = "pinSpecialCharacters must be one of the documented enum values."
  }
}

variable "pinUppercaseLetters" {
  description = "Pin Character Requirements"
  type        = string
  default     = null

  validation {
    condition     = var.pinUppercaseLetters == null ? true : contains(["notAllow", "requireAtLeastOne", "allow"], var.pinUppercaseLetters)
    error_message = "pinUppercaseLetters must be one of the documented enum values."
  }
}

variable "protectedAppLockerFiles" {
  description = "Another way to input protected apps through xml files"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionAppLockerFile")
    displayName = optional(string)
    file        = optional(string)
    fileHash    = optional(string)
    version     = optional(string)
  }))
  default = null
}

variable "protectedApps" {
  description = "Protected applications can access enterprise data and the data handled by those applications are protected with encryption"
  type        = any
  default     = null
}

variable "protectionUnderLockConfigRequired" {
  description = "Specifies whether the protection under lock feature (also known as encrypt under pin) should be configured"
  type        = bool
  default     = null
}

variable "revokeOnMdmHandoffDisabled" {
  description = "New property in RS2, pending documentation"
  type        = bool
  default     = null
}

variable "revokeOnUnenrollDisabled" {
  description = "This policy controls whether to revoke the WIP keys when a device unenrolls from the management service. If set to 1 (Don't revoke keys), the keys will not be revoked and the user will continue to have access to protected files after unenrollment. If the keys are not revoked, there will be no revoked file cleanup subsequently."
  type        = bool
  default     = null
}

variable "rightsManagementServicesTemplateId" {
  description = "TemplateID GUID to use for RMS encryption. The RMS template allows the IT admin to configure the details about who has access to RMS-protected file and how long they have access"
  type        = string
  default     = null
}

variable "roleScopeTagIds" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "smbAutoEncryptedFileExtensions" {
  description = "Specifies a list of file extensions, so that files with these extensions are encrypted when copying from an SMB share within the corporate boundary"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
  }))
  default = null
}

variable "windowsHelloForBusinessBlocked" {
  description = "Boolean value that sets Windows Hello for Business as a method for signing into Windows."
  type        = bool
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
