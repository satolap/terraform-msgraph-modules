variable "product_id" {
  description = "The unique identifier of product"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.product_id)) > 0
    error_message = "product_id must not be empty."
  }
}

variable "catalog_entry" {
  description = "Microsoft Graph catalogEntry property."
  type        = any
  default     = null
}

variable "knowledge_base_article" {
  description = "The knowledge base article associated with the product revision."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsUpdates.productRevision"
  nullable    = false
}

variable "os_build" {
  description = "Microsoft Graph osBuild property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.windowsUpdates.buildVersionDetails")
  })
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["displayName", "id", "isHotpatchUpdate", "product", "releaseDateTime", "version"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
