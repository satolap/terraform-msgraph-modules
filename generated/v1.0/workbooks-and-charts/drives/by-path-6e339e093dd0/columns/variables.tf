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

variable "workbook_table_id" {
  description = "The unique identifier of workbookTable"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.workbook_table_id)) > 0
    error_message = "workbook_table_id must not be empty."
  }
}

variable "name" {
  description = "The name of the table column."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.workbookTableColumn"
  nullable    = false
}

variable "values" {
  description = "TRepresents the raw values of the specified range. The data returned could be of type string, number, or a Boolean. Cell that contain an error will return the error string."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["filter", "id", "index"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
