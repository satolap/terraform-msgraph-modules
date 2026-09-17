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

variable "created_by_user" {
  description = "Microsoft Graph createdByUser property."
  type        = any
  default     = null
}

variable "description" {
  description = "The description of the item."
  type        = string
  default     = null
}

variable "last_modified_by_user" {
  description = "Microsoft Graph lastModifiedByUser property."
  type        = any
  default     = null
}

variable "name" {
  description = "The name of the item. Read-write."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.baseSitePage"
  nullable    = false
}

variable "page_layout" {
  description = "The name of the page layout of the page. The possible values are: microsoftReserved, article, home, unknownFutureValue, newsLink. Use the Prefer: include-unknown-enum-members request header to get the following members in this evolvable enum: newsLink."
  type        = any
  default     = null

  validation {
    condition     = var.page_layout == null ? true : contains(["microsoftReserved", "article", "home", "unknownFutureValue", "newsLink", "videoNewsLink"], var.page_layout)
    error_message = "page_layout must be one of the documented enum values."
  }
}

variable "parent_reference" {
  description = "Parent information, if the item has a parent. Read-write."
  type        = any
  default     = null
}

variable "publishing_state" {
  description = "The publishing status and the MM.mm version of the page."
  type        = any
  default     = null
}

variable "title" {
  description = "Title of the sitePage."
  type        = string
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "eTag", "id", "lastModifiedBy", "lastModifiedDateTime", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
