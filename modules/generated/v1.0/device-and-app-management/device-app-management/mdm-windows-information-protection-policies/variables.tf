variable "assignments" {
  description = "Navigation property to list of security groups targeted for policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.targetedManagedAppPolicyAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "azure_rights_management_services_allowed" {
  description = "Specifies whether to allow Azure RMS encryption for WIP"
  type        = bool
  default     = null
}

variable "created_date_time" {
  description = "The date and time the policy was created."
  type        = string
  default     = null
}

variable "data_recovery_certificate" {
  description = "Specifies a recovery certificate that can be used for data recovery of encrypted files. This is the same as the data recovery agent(DRA) certificate for encrypting file system(EFS)"
  type        = any
  default     = null
}

variable "description" {
  description = "The policy's description."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Policy display name."
  type        = string
  default     = null
}

variable "enforcement_level" {
  description = "Possible values for WIP Protection enforcement levels"
  type        = string
  default     = null

  validation {
    condition     = var.enforcement_level == null ? true : contains(["noProtection", "encryptAndAuditOnly", "encryptAuditAndPrompt", "encryptAuditAndBlock"], var.enforcement_level)
    error_message = "enforcement_level must be one of the documented enum values."
  }
}

variable "enterprise_domain" {
  description = "Primary enterprise domain"
  type        = string
  default     = null
}

variable "enterprise_internal_proxy_servers" {
  description = "This is the comma-separated list of internal proxy servers. For example, '157.54.14.28, 157.54.11.118, 10.202.14.167, 157.53.14.163, 157.69.210.59'. These proxies have been configured by the admin to connect to specific resources on the Internet. They are considered to be enterprise network locations. The proxies are only leveraged in configuring the EnterpriseProxiedDomains policy to force traffic to the matched domains through these proxies"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
  }))
  default = null
}

variable "enterprise_ip_ranges" {
  description = "Sets the enterprise IP ranges that define the computers in the enterprise network. Data that comes from those computers will be considered part of the enterprise and protected. These locations will be considered a safe destination for enterprise data to be shared to"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionIPRangeCollection")
    displayName = optional(string)
    ranges = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.ipRange")
    })))
  }))
  default = null
}

variable "enterprise_ip_ranges_are_authoritative" {
  description = "Boolean value that tells the client to accept the configured list and not to use heuristics to attempt to find other subnets. Default is false"
  type        = bool
  default     = null
}

variable "enterprise_network_domain_names" {
  description = "This is the list of domains that comprise the boundaries of the enterprise. Data from one of these domains that is sent to a device will be considered enterprise data and protected These locations will be considered a safe destination for enterprise data to be shared to"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
  }))
  default = null
}

variable "enterprise_protected_domain_names" {
  description = "List of enterprise domains to be protected"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
  }))
  default = null
}

variable "enterprise_proxied_domains" {
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

variable "enterprise_proxy_servers" {
  description = "This is a list of proxy servers. Any server not on this list is considered non-enterprise"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
  }))
  default = null
}

variable "enterprise_proxy_servers_are_authoritative" {
  description = "Boolean value that tells the client to accept the configured list of proxies and not try to detect other work proxies. Default is false"
  type        = bool
  default     = null
}

variable "exempt_app_locker_files" {
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

variable "exempt_apps" {
  description = "Exempt applications can also access enterprise data, but the data handled by those applications are not protected. This is because some critical enterprise applications may have compatibility problems with encrypted data."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.windowsInformationProtectionApp")
    denied        = optional(bool)
    description   = optional(string)
    displayName   = optional(string)
    productName   = optional(string)
    publisherName = optional(string)
  }))
  default = null
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "icons_visible" {
  description = "Determines whether overlays are added to icons for WIP protected files in Explorer and enterprise only app tiles in the Start menu. Starting in Windows 10, version 1703 this setting also configures the visibility of the WIP icon in the title bar of a WIP-protected app"
  type        = bool
  default     = null
}

variable "indexing_encrypted_stores_or_items_blocked" {
  description = "This switch is for the Windows Search Indexer, to allow or disallow indexing of items"
  type        = bool
  default     = null
}

variable "is_assigned" {
  description = "Indicates if the policy is deployed to any inclusion groups or not."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "Last time the policy was modified."
  type        = string
  default     = null
}

variable "neutral_domain_resources" {
  description = "List of domain names that can used for work or personal resource"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mdmWindowsInformationProtectionPolicy"
  nullable    = false
}

variable "protected_app_locker_files" {
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

variable "protected_apps" {
  description = "Protected applications can access enterprise data and the data handled by those applications are protected with encryption"
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.windowsInformationProtectionApp")
    denied        = optional(bool)
    description   = optional(string)
    displayName   = optional(string)
    productName   = optional(string)
    publisherName = optional(string)
  }))
  default = null
}

variable "protection_under_lock_config_required" {
  description = "Specifies whether the protection under lock feature (also known as encrypt under pin) should be configured"
  type        = bool
  default     = null
}

variable "revoke_on_unenroll_disabled" {
  description = "This policy controls whether to revoke the WIP keys when a device unenrolls from the management service. If set to 1 (Don't revoke keys), the keys will not be revoked and the user will continue to have access to protected files after unenrollment. If the keys are not revoked, there will be no revoked file cleanup subsequently."
  type        = bool
  default     = null
}

variable "rights_management_services_template_id" {
  description = "TemplateID GUID to use for RMS encryption. The RMS template allows the IT admin to configure the details about who has access to RMS-protected file and how long they have access"
  type        = string
  default     = null
}

variable "smb_auto_encrypted_file_extensions" {
  description = "Specifies a list of file extensions, so that files with these extensions are encrypted when copying from an SMB share within the corporate boundary"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")
    displayName = optional(string)
    resources   = optional(list(string))
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
