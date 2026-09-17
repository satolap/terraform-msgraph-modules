variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "store_id" {
  description = "The unique identifier of store"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.store_id)) > 0
    error_message = "store_id must not be empty."
  }
}

variable "set_id" {
  description = "The unique identifier of set"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.set_id)) > 0
    error_message = "set_id must not be empty."
  }
}

variable "from_term" {
  description = "The from [term] of the relation. The term from which the relationship is defined. A null value would indicate the relation is directly with the [set]."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.termStore.relation"
  nullable    = false
}

variable "relationship" {
  description = "The type of relation. The possible values are: pin, reuse."
  type        = any
  default     = null

  validation {
    condition     = var.relationship == null ? true : contains(["pin", "reuse", "unknownFutureValue"], var.relationship)
    error_message = "relationship must be one of the documented enum values."
  }
}

variable "set" {
  description = "The [set] in which the relation is relevant."
  type        = any
  default     = null
}

variable "to_term" {
  description = "The to [term] of the relation. The term to which the relationship is defined."
  type        = any
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
