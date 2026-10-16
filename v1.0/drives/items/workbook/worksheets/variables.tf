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

variable "name" {
  description = "The display name of the worksheet."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.workbookWorksheet"
  nullable    = false
}

variable "pivot_tables" {
  description = "The list of piot tables that are part of the worksheet."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.workbookPivotTable")
    name       = optional(string)
  }))
  default = null
}

variable "position" {
  description = "The zero-based position of the worksheet within the workbook."
  type        = number
  default     = null
}

variable "visibility" {
  description = "The visibility of the worksheet. The possible values are: Visible, Hidden, VeryHidden."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["charts", "id", "names", "protection", "tables"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
