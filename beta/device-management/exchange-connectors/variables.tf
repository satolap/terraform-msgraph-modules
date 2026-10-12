variable "connector_server_name" {
  description = "The name of the server hosting the Exchange Connector."
  type        = string
  default     = null
}

variable "exchange_alias" {
  description = "An alias assigned to the Exchange server"
  type        = string
  default     = null
}

variable "exchange_connector_type" {
  description = "The type of Exchange Connector."
  type        = string
  default     = null

  validation {
    condition     = var.exchange_connector_type == null ? true : contains(["onPremises", "hosted", "serviceToService", "dedicated", "unknownFutureValue"], var.exchange_connector_type)
    error_message = "exchange_connector_type must be one of the documented enum values."
  }
}

variable "exchange_organization" {
  description = "Exchange Organization to the Exchange server"
  type        = string
  default     = null
}

variable "graph_version" {
  description = "The version of the ExchangeConnectorAgent"
  type        = string
  default     = null
}

variable "last_sync_date_time" {
  description = "Last sync time for the Exchange Connector"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementExchangeConnector"
  nullable    = false
}

variable "primary_smtp_address" {
  description = "Email address used to configure the Service To Service Exchange Connector."
  type        = string
  default     = null
}

variable "server_name" {
  description = "The name of the Exchange server."
  type        = string
  default     = null
}

variable "status" {
  description = "The current status of the Exchange Connector."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["none", "connectionPending", "connected", "disconnected", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
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
