variable "certificate_authorities" {
  description = "The collection of certificate authorities contained in this public key infrastructure resource."
  type = list(object({
    odata_type                        = optional(string, "#microsoft.graph.certificateAuthorityDetail")
    certificate                       = optional(string)
    certificateAuthorityType          = optional(string)
    certificateRevocationListUrl      = optional(string)
    createdDateTime                   = optional(string)
    deletedDateTime                   = optional(string)
    deltaCertificateRevocationListUrl = optional(string)
    displayName                       = optional(string)
    expirationDateTime                = optional(string)
    isIssuerHintEnabled               = optional(bool)
    issuer                            = optional(string)
    issuerSubjectKeyIdentifier        = optional(string)
    thumbprint                        = optional(string)
  }))
  default = null

  validation {
    condition     = (var.certificate_authorities == null ? true : alltrue([alltrue([for input0 in var.certificate_authorities : (input0 == null ? true : alltrue([(input0["certificateAuthorityType"] == null ? true : alltrue([(input0["certificateAuthorityType"] == null ? true : contains(["root", "intermediate"], input0["certificateAuthorityType"]))]))]))])]))
    error_message = "certificate_authorities: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the object. Maximum length is 256 characters."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the object was created or last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.certificateBasedAuthPki"
  nullable    = false
}

variable "status" {
  description = "The status of any asynchronous jobs runs on the object which can be upload or delete."
  type        = string
  default     = null
}

variable "status_details" {
  description = "The status details of the upload/deleted operation of PKI (Public Key Infrastructure)."
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
