variable "drive_id" {
  description = "The unique identifier of drive"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_id)) > 0
    error_message = "drive_id must not be empty."
  }
}

variable "drive_item_id" {
  description = "The unique identifier of driveItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_item_id)) > 0
    error_message = "drive_item_id must not be empty."
  }
}

variable "highlight_first_column" {
  description = "Indicates whether the first column contains special formatting."
  type        = bool
  default     = null
}

variable "highlight_last_column" {
  description = "Indicates whether the last column contains special formatting."
  type        = bool
  default     = null
}

variable "name" {
  description = "The name of the table."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.workbookTable"
  nullable    = false
}

variable "show_banded_columns" {
  description = "Indicates whether the columns show banded formatting in which odd columns are highlighted differently from even ones to make reading the table easier."
  type        = bool
  default     = null
}

variable "show_banded_rows" {
  description = "Indicates whether the rows show banded formatting in which odd rows are highlighted differently from even ones to make reading the table easier."
  type        = bool
  default     = null
}

variable "show_filter_button" {
  description = "Indicates whether the filter buttons are visible at the top of each column header. Setting this is only allowed if the table contains a header row."
  type        = bool
  default     = null
}

variable "show_headers" {
  description = "Indicates whether the header row is visible or not. This value can be set to show or remove the header row."
  type        = bool
  default     = null
}

variable "show_totals" {
  description = "Indicates whether the total row is visible or not. This value can be set to show or remove the total row."
  type        = bool
  default     = null
}

variable "style" {
  description = "A constant value that represents the Table style. The possible values are: TableStyleLight1 through TableStyleLight21, TableStyleMedium1 through TableStyleMedium28, TableStyleStyleDark1 through TableStyleStyleDark11. A custom user-defined style present in the workbook can also be specified."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["columns", "id", "legacyId", "rows", "sort", "worksheet"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
