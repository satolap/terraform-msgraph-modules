variable "created" {
  description = "Creation metadata, including user and timestamp. Supports $orderby (dateTime property only). Supports $filter (ge, le, gt, lt) on the dateTime property. For example, $filter=created/dateTime ge 2023-01-01T00:00:00Z."
  type        = any
  default     = null
}

variable "description" {
  description = "Optional description of the zone. Up to 255 characters. Supports $filter (eq, contains). For example, $filter=contains(description, 'production')."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Human-readable name of the zone. Up to 1,024 characters. Supports $filter (eq, contains), and $orderby. For example, $filter=displayName eq 'Production Zone' or $orderby=displayName asc."
  type        = string
  default     = null
}

variable "environments" {
  description = "Collection of attached environments. Supports $expand."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.environment")
    kind       = optional(string)
  }))
  default = null
}

variable "modified" {
  description = "Last modification metadata, including user and timestamp. Supports $orderby (dateTime property only). Supports $filter (ge, le, gt, lt) on the dateTime property. For example, $orderby=modified/dateTime desc."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.zone"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["aggregations", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
