variable "addressable_user_name" {
  description = "Addressable user name."
  type        = string
  default     = null
}

variable "azure_active_directory_device_id" {
  description = "AAD Device ID - to be deprecated"
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display Name"
  type        = string
  default     = null
}

variable "enrollment_state" {
  description = "Microsoft Graph enrollmentState property."
  type        = string
  default     = null

  validation {
    condition     = var.enrollment_state == null ? true : contains(["unknown", "enrolled", "pendingReset", "failed", "notContacted"], var.enrollment_state)
    error_message = "enrollment_state must be one of the documented enum values."
  }
}

variable "group_tag" {
  description = "Group Tag of the Windows autopilot device."
  type        = string
  default     = null
}

variable "last_contacted_date_time" {
  description = "Intune Last Contacted Date Time of the Windows autopilot device."
  type        = string
  default     = null
}

variable "managed_device_id" {
  description = "Managed Device ID"
  type        = string
  default     = null
}

variable "manufacturer" {
  description = "Oem manufacturer of the Windows autopilot device."
  type        = string
  default     = null
}

variable "model" {
  description = "Model name of the Windows autopilot device."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsAutopilotDeviceIdentity"
  nullable    = false
}

variable "product_key" {
  description = "Product Key of the Windows autopilot device."
  type        = string
  default     = null
}

variable "purchase_order_identifier" {
  description = "Purchase Order Identifier of the Windows autopilot device."
  type        = string
  default     = null
}

variable "resource_name" {
  description = "Resource Name."
  type        = string
  default     = null
}

variable "serial_number" {
  description = "Serial number of the Windows autopilot device."
  type        = string
  default     = null
}

variable "sku_number" {
  description = "SKU Number"
  type        = string
  default     = null
}

variable "system_family" {
  description = "System Family"
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "User Principal Name."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
