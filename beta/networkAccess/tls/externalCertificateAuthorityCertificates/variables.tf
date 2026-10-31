variable "certificate" {
  description = "The signed X.509 certificate in PEM format."
  type        = string
  default     = null
}

variable "chain" {
  description = "The certificate chain in PEM format, containing all intermediate certificates up to the root CA."
  type        = string
  default     = null
}

variable "commonName" {
  description = "The common name (CN) field of the certificate. Supports $filter (eq, ne, startsWith)"
  type        = string
  default     = null
}

variable "name" {
  description = "The display name of the CA. Supports $filter (eq, ne, startsWith)"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.networkaccess.externalCertificateAuthorityCertificate"
  nullable    = false
}

variable "organizationName" {
  description = "The organization name (OU) field of the certificate. Supports $filter (eq, ne, startsWith)"
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["csrGenerated", "enrolling", "active"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "validity" {
  description = "Microsoft Graph validity property."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.networkaccess.validityDate")
    endDateTime   = optional(string)
    startDateTime = optional(string)
  })
  default = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["certificateSigningRequest", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
