variable "company_id" {
  description = "The unique identifier of company"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.company_id)) > 0
    error_message = "company_id must not be empty."
  }
}

variable "base_unit_of_measure_id" {
  description = "Microsoft Graph baseUnitOfMeasureId property."
  type        = string
  default     = null
}

variable "blocked" {
  description = "Microsoft Graph blocked property."
  type        = bool
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "gtin" {
  description = "Microsoft Graph gtin property."
  type        = string
  default     = null
}

variable "id" {
  description = "Microsoft Graph id property."
  type        = string
  default     = null
}

variable "inventory" {
  description = "Microsoft Graph inventory property."
  type        = number
  default     = null
}

variable "item_category" {
  description = "Microsoft Graph itemCategory property."
  type        = any
  default     = null
}

variable "item_category_code" {
  description = "Microsoft Graph itemCategoryCode property."
  type        = string
  default     = null
}

variable "item_category_id" {
  description = "Microsoft Graph itemCategoryId property."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "number" {
  description = "Microsoft Graph number property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.item"
  nullable    = false
}

variable "picture" {
  description = "Microsoft Graph picture property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.picture")
    content     = optional(string)
    contentType = optional(string)
    height      = optional(number)
    id          = optional(string)
    width       = optional(number)
  }))
  default = null
}

variable "price_includes_tax" {
  description = "Microsoft Graph priceIncludesTax property."
  type        = bool
  default     = null
}

variable "tax_group_code" {
  description = "Microsoft Graph taxGroupCode property."
  type        = string
  default     = null
}

variable "tax_group_id" {
  description = "Microsoft Graph taxGroupId property."
  type        = string
  default     = null
}

variable "type" {
  description = "Microsoft Graph type property."
  type        = string
  default     = null
}

variable "unit_cost" {
  description = "Microsoft Graph unitCost property."
  type        = number
  default     = null
}

variable "unit_price" {
  description = "Microsoft Graph unitPrice property."
  type        = number
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains([], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
