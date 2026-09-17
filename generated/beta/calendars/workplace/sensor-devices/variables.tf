variable "description" {
  description = "The description of the device."
  type        = string
  default     = null
}

variable "device_id" {
  description = "The user-defined unique identifier of the device provided at the time of creation."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the device."
  type        = string
  default     = null
}

variable "ip_v4_address" {
  description = "The IPv4 address of the device."
  type        = string
  default     = null
}

variable "ip_v6_address" {
  description = "The IPv6 address of the device."
  type        = string
  default     = null
}

variable "mac_address" {
  description = "The MAC address of the device."
  type        = string
  default     = null
}

variable "manufacturer" {
  description = "The manufacturer of the device."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.workplaceSensorDevice"
  nullable    = false
}

variable "place_id" {
  description = "The unique identifier of the place where the device is located. If the device is installed in a room equipped with a mailbox, this property should match the ExternalDirectoryObjectId or Microsoft Entra object ID of the room mailbox."
  type        = string
  default     = null
}

variable "sensors" {
  description = "A list of sensors associated with the device that collect and report data about physical or environmental conditions, such as occupancy, people count, inferred occupancy, temperature, Wi-Fi, and more."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.workplaceSensor")
    displayName = optional(string)
    placeId     = optional(string)
    sensorId    = optional(string)
    sensorType  = optional(string)
  }))
  default = null
}

variable "tags" {
  description = "A list of custom tags associated with the device."
  type        = list(string)
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
