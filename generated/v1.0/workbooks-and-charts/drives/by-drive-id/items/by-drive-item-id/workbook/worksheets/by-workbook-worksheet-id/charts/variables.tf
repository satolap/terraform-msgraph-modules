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

variable "workbook_worksheet_id" {
  description = "The unique identifier of workbookWorksheet"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.workbook_worksheet_id)) > 0
    error_message = "workbook_worksheet_id must not be empty."
  }
}

variable "height" {
  description = "Represents the height, in points, of the chart object."
  type        = any
  default     = null
}

variable "left" {
  description = "The distance, in points, from the left side of the chart to the worksheet origin."
  type        = any
  default     = null
}

variable "name" {
  description = "Represents the name of a chart object."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.workbookChart"
  nullable    = false
}

variable "top" {
  description = "Represents the distance, in points, from the top edge of the object to the top of row 1 (on a worksheet) or the top of the chart area (on a chart)."
  type        = any
  default     = null
}

variable "width" {
  description = "Represents the width, in points, of the chart object."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["axes", "dataLabels", "format", "id", "legend", "series", "title", "worksheet"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
