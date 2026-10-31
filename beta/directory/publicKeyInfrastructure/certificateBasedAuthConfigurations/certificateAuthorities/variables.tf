variable "certificateBasedAuthPki-id" {
  description = "The unique identifier of certificateBasedAuthPki"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.certificateBasedAuthPki-id)) > 0
    error_message = "certificateBasedAuthPki-id must not be empty."
  }
}

variable "certificate" {
  description = "The public key of the certificate authority."
  type        = string
  default     = null
}

variable "certificateAuthorityType" {
  description = "The type of certificate authority. The possible values are: root, intermediate, unknownFutureValue. Supports $filter (eq)."
  type        = string
  default     = null

  validation {
    condition     = var.certificateAuthorityType == null ? true : contains(["root", "intermediate"], var.certificateAuthorityType)
    error_message = "certificateAuthorityType must be one of the documented enum values."
  }
}

variable "certificateRevocationListUrl" {
  description = "The URL to check if the certificate is revoked."
  type        = string
  default     = null
}

variable "createdDateTime" {
  description = "The date and time when the certificate authority was created."
  type        = string
  default     = null
}

variable "deletedDateTime" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "deltaCertificateRevocationListUrl" {
  description = "Microsoft Graph deltaCertificateRevocationListUrl property."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The display name of the certificate authority."
  type        = string
  default     = null
}

variable "expirationDateTime" {
  description = "The date and time when the certificate authority expires. Supports $filter (eq) and $orderby."
  type        = string
  default     = null
}

variable "isIssuerHintEnabled" {
  description = "Indicates whether the certificate picker presents the certificate authority to the user to use for authentication. Default value is false. Optional."
  type        = bool
  default     = null
}

variable "issuer" {
  description = "The issuer of the certificate authority."
  type        = string
  default     = null
}

variable "issuerSubjectKeyIdentifier" {
  description = "The subject key identifier of certificate authority."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.certificateAuthorityDetail"
  nullable    = false
}

variable "thumbprint" {
  description = "The thumbprint of certificate authority certificate. Supports $filter (eq, startswith)."
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
