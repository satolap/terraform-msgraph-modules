variable "created_date_time" {
  description = "The date and time when the invitation was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. Supports $filter (lt, le, gt, ge, eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "The date and time when the invitation expires. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. Supports $filter (lt, le, gt, ge, eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "governed_tenant_id" {
  description = "The Microsoft Entra tenant ID of the governed tenant. Supports $filter (eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "governed_tenant_name" {
  description = "The display name of the governed tenant. Supports $filter (eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "governing_tenant_id" {
  description = "The Microsoft Entra tenant ID of the governing tenant. Supports $filter (eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "governing_tenant_name" {
  description = "The display name of the governing tenant. Supports $filter (eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.governanceInvitation"
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
