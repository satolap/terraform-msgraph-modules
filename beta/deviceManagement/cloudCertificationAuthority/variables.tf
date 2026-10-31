variable "certificateKeySize" {
  description = "Enum of possible cloud certification authority certificate cryptography and key size combinations."
  type        = string
  default     = null

  validation {
    condition     = var.certificateKeySize == null ? true : contains(["unknown", "rsa2048", "rsa3072", "rsa4096", "eCP256", "eCP256k", "eCP384", "eCP521"], var.certificateKeySize)
    error_message = "certificateKeySize must be one of the documented enum values."
  }
}

variable "certificationAuthorityStatus" {
  description = "Enum type of possible certification authority statuses. These statuses indicate whether a certification authority is currently able to issue certificates, temporarily paused, pending signing, revoked, or expired."
  type        = string
  default     = null

  validation {
    condition     = var.certificationAuthorityStatus == null ? true : contains(["unknown", "active", "paused", "revoked", "signingPending"], var.certificationAuthorityStatus)
    error_message = "certificationAuthorityStatus must be one of the documented enum values."
  }
}

variable "cloudCertificationAuthorityHashingAlgorithm" {
  description = "Enum type of possible certificate hashing algorithms used by the certification authority to create certificates."
  type        = string
  default     = null

  validation {
    condition     = var.cloudCertificationAuthorityHashingAlgorithm == null ? true : contains(["unknown", "sha256", "sha384", "sha512"], var.cloudCertificationAuthorityHashingAlgorithm)
    error_message = "cloudCertificationAuthorityHashingAlgorithm must be one of the documented enum values."
  }
}

variable "cloudCertificationAuthorityLeafCertificate" {
  description = "Required OData property to expose leaf certificate API."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.cloudCertificationAuthorityLeafCertificate")
    certificateStatus = optional(string)
  }))
  default = null

  validation {
    condition     = (var.cloudCertificationAuthorityLeafCertificate == null ? true : alltrue([alltrue([for input0 in var.cloudCertificationAuthorityLeafCertificate : (input0 == null ? true : alltrue([(input0["certificateStatus"] == null ? true : alltrue([(input0["certificateStatus"] == null ? true : contains(["unknown", "active", "revoked", "expired"], input0["certificateStatus"]))]))]))])]))
    error_message = "cloudCertificationAuthorityLeafCertificate: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "cloudCertificationAuthorityType" {
  description = "Enum type of possible certificate authority types. This feature supports a two-tier certification authority model with a root certification authority and one or more child issuing (intermediate) certification authorities."
  type        = string
  default     = null

  validation {
    condition     = var.cloudCertificationAuthorityType == null ? true : contains(["unknown", "rootCertificationAuthority", "issuingCertificationAuthority", "issuingCertificationAuthorityWithExternalRoot"], var.cloudCertificationAuthorityType)
    error_message = "cloudCertificationAuthorityType must be one of the documented enum values."
  }
}

variable "description" {
  description = "The certification authority description displayed in the Intune admin console. Nullable. Read/write. Returns null if not set."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The certification authority display name the Intune admin console. Read/write. Supports $select and $orderby."
  type        = string
  default     = null
}

variable "eTag" {
  description = "ETag for optimistic concurrency control. Read/write."
  type        = string
  default     = null
}

variable "issuerCommonName" {
  description = "Microsoft Graph issuerCommonName property."
  type        = string
  default     = null
}

variable "keyPlatform" {
  description = "Enum type of possible key platforms used by the certification authority."
  type        = string
  default     = null

  validation {
    condition     = var.keyPlatform == null ? true : contains(["unknown", "software", "hardwareSecurityModule"], var.keyPlatform)
    error_message = "keyPlatform must be one of the documented enum values."
  }
}

variable "lastModifiedDateTime" {
  description = "Last modification date and time of this certification authority entity instance. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 would look like this: '2014-01-01T00:00:00Z'. Nullable. Read/write."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudCertificationAuthority"
  nullable    = false
}

variable "roleScopeTagIds" {
  description = "List of Scope Tags for this entity instance. Scope tags limit access to an entity instance. Nullable. Read/write."
  type        = list(string)
  default     = null
}

variable "validityPeriodInYears" {
  description = "The certification authority validity period in years configured by admins."
  type        = number
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["activeVersion", "certificateDownloadUrl", "certificateRevocationListUrl", "certificateSigningRequest", "certificationAuthorityIssuerId", "certificationAuthorityIssuerUri", "commonName", "countryName", "createdDateTime", "extendedKeyUsages", "geographicRegion", "id", "localityName", "ocspResponderUri", "organizationName", "organizationUnit", "rootCertificateCommonName", "scepServerUrl", "serialNumber", "stateName", "subjectName", "thumbprint", "validityEndDateTime", "validityStartDateTime", "versionNumber", "versions"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
