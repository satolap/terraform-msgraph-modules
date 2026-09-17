variable "follower" {
  description = "The Viva Engage identities."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.engagementIdentitySet")
    application = optional(any)
    audience    = optional(any)
    device      = optional(any)
    group       = optional(any)
    user        = optional(any)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.storylineFollower"
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
