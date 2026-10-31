variable "description" {
  description = "The description of the device."
  type        = string
  default     = null
}

variable "deviceId" {
  description = "The user-defined unique identifier of the device provided at the time of creation."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The display name of the device."
  type        = string
  default     = null
}

variable "ipV4Address" {
  description = "The IPv4 address of the device."
  type        = string
  default     = null
}

variable "ipV6Address" {
  description = "The IPv6 address of the device."
  type        = string
  default     = null
}

variable "macAddress" {
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

variable "placeId" {
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

  validation {
    condition     = (var.sensors == null ? true : alltrue([alltrue([for input0 in var.sensors : (input0 == null ? true : alltrue([(input0["sensorType"] == null ? true : alltrue([(input0["sensorType"] == null ? true : contains(["occupancy", "peopleCount", "inferredOccupancy", "heartbeat", "badge"], input0["sensorType"]))]))]))])]))
    error_message = "sensors: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "tags" {
  description = "A list of custom tags associated with the device."
  type        = list(string)
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
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
