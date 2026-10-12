variable "authentication_method" {
  description = "Indicates the method used by Intune to authenticate with ServiceNow. Currently supports only web authentication with ServiceNow using the specified app id."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Date Time when connection properties were created. The value cannot be modified and is automatically populated when the connection properties were entered."
  type        = string
  default     = null
}

variable "incident_api_url" {
  description = "Indicates the ServiceNow incident API URL that Intune will use the fetch incidents. Saved in the format of /api/now/table/incident"
  type        = string
  default     = null
}

variable "instance_url" {
  description = "Indicates the ServiceNow instance URL that Intune will connect to. Saved in the format of https://<instance>.service-now.com"
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Date Time when connection properties were last updated. The value cannot be modified and is automatically populated when the connection properties were updated."
  type        = string
  default     = null
}

variable "last_queried_date_time" {
  description = "Date Time when incidents from ServiceNow were last queried"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.serviceNowConnection"
  nullable    = false
}

variable "service_now_connection_status" {
  description = "Status of ServiceNow Connection"
  type        = string
  default     = null

  validation {
    condition     = var.service_now_connection_status == null ? true : contains(["disabled", "enabled", "unknownFutureValue"], var.service_now_connection_status)
    error_message = "service_now_connection_status must be one of the documented enum values."
  }
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
