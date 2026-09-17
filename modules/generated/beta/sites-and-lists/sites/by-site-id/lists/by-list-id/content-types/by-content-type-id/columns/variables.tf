variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "list_id" {
  description = "The unique identifier of list"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.list_id)) > 0
    error_message = "list_id must not be empty."
  }
}

variable "content_type_id" {
  description = "The unique identifier of contentType"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.content_type_id)) > 0
    error_message = "content_type_id must not be empty."
  }
}

variable "boolean" {
  description = "This column stores Boolean values."
  type        = any
  default     = null
}

variable "calculated" {
  description = "This column's data is calculated based on other columns."
  type        = any
  default     = null
}

variable "choice" {
  description = "This column stores data from a list of choices."
  type        = any
  default     = null
}

variable "column_group" {
  description = "For site columns, the name of the group this column belongs to. Helps organize related columns."
  type        = string
  default     = null
}

variable "content_approval_status" {
  description = "This column stores content approval status."
  type        = any
  default     = null
}

variable "currency" {
  description = "This column stores currency values."
  type        = any
  default     = null
}

variable "date_time" {
  description = "This column stores DateTime values."
  type        = any
  default     = null
}

variable "default_value" {
  description = "The default value for this column."
  type        = any
  default     = null
}

variable "description" {
  description = "The user-facing description of the column."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The user-facing name of the column."
  type        = string
  default     = null
}

variable "enforce_unique_values" {
  description = "If true, no two list items may have the same value for this column."
  type        = bool
  default     = null
}

variable "geolocation" {
  description = "This column stores a geolocation."
  type        = any
  default     = null
}

variable "hidden" {
  description = "Specifies whether the column is displayed in the user interface."
  type        = bool
  default     = null
}

variable "hyperlink_or_picture" {
  description = "This column stores hyperlink or picture values."
  type        = any
  default     = null
}

variable "indexed" {
  description = "Specifies whether the column values can be used for sorting and searching."
  type        = bool
  default     = null
}

variable "is_deletable" {
  description = "Indicates whether this column can be deleted."
  type        = bool
  default     = null
}

variable "is_sealed" {
  description = "Specifies whether the column can be changed."
  type        = bool
  default     = null
}

variable "is_searchable" {
  description = "Specifies whether the column values can be used for searching. Currently supported only for columns in a fileStorageContainer."
  type        = bool
  default     = null
}

variable "lookup" {
  description = "This column's data is looked up from another source in the site."
  type        = any
  default     = null
}

variable "name" {
  description = "The API-facing name of the column as it appears in the fields on a listItem. For the user-facing name, see displayName."
  type        = string
  default     = null
}

variable "number" {
  description = "This column stores number values."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.columnDefinition"
  nullable    = false
}

variable "person_or_group" {
  description = "This column stores Person or Group values."
  type        = any
  default     = null
}

variable "propagate_changes" {
  description = "If true, changes to this column will be propagated to lists that implement the column."
  type        = bool
  default     = null
}

variable "read_only" {
  description = "Specifies whether the column values can be modified."
  type        = bool
  default     = null
}

variable "required" {
  description = "Specifies whether the column value isn't optional."
  type        = bool
  default     = null
}

variable "source_column" {
  description = "The source column for content type column."
  type        = any
  default     = null
}

variable "source_content_type" {
  description = "ContentType from which this column is inherited from. Used only to fetch contentTypes columns."
  type        = any
  default     = null
}

variable "term" {
  description = "This column stores taxonomy terms."
  type        = any
  default     = null
}

variable "text" {
  description = "This column stores text values."
  type        = any
  default     = null
}

variable "thumbnail" {
  description = "This column stores thumbnail values."
  type        = any
  default     = null
}

variable "validation" {
  description = "This column stores validation formula and message for the column."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "isReorderable", "type"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
