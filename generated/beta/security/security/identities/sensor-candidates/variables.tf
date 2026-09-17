variable "computer_dns_name" {
  description = "The DNS name of the computer associated with the sensor."
  type        = string
  default     = null
}

variable "domain_name" {
  description = "The domain name of the sensor."
  type        = string
  default     = null
}

variable "last_seen_date_time" {
  description = "The date and time when the sensor was last seen."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.sensorCandidate"
  nullable    = false
}

variable "sense_client_version" {
  description = "The version of the Defender for Identity sensor client.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "sensor_types" {
  description = "The list of device types for the sensor. The possible values are: domainController, adfs, adcs, entraConnect unknownFutureValue. This flagged enumeration allows multiple members to be returned simultaneously."
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
