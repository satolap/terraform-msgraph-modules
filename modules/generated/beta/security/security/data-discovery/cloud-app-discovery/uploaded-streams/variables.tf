variable "anonymize_machine_data" {
  description = "Use 1 if the machine information is anonymized; otherwise use 0."
  type        = bool
  default     = null
}

variable "anonymize_user_data" {
  description = "Use 1 if the user information is anonymized; otherwise use 0."
  type        = bool
  default     = null
}

variable "created_date_time" {
  description = "The date in the format specified. The Timestamp represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "description" {
  description = "A comment or description for the report."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the continuous report."
  type        = string
  default     = null
}

variable "is_snapshot_report" {
  description = "Use 1 for a snapshot report; otherwise use 0."
  type        = bool
  default     = null
}

variable "last_data_received_date_time" {
  description = "The date when the data was last received. The Timestamp represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date when the continuous report was last modified. The Timestamp represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "log_data_provider" {
  description = "The applicable log data provider. The possible values are: barracuda, bluecoat, checkpoint, ciscoAsa, ciscoIronportProxy, fortigate, paloAlto, squid, zscaler, mcafeeSwg, ciscoScanSafe, juniperSrx, sophosSg, websenseV75, websenseSiemCef, machineZoneMeraki, squidNative, ciscoFwsm, microsoftIsaW3C, sonicwall, sophosCyberoam, clavister, customParser, juniperSsg, zscalerQradar, juniperSrxSd, juniperSrxWelf, microsoftConditionalAppAccess, ciscoAsaFirepower, genericCef, genericLeef, genericW3C, iFilter, checkpointXml, checkpointSmartViewTracker, barracudaNextGenFw, barracudaNextGenFwWeblog, microsoftDefenderForEndpoint, zscalerCef, sophosXg, iboss, forcepoint, fortios, ciscoIronportWsaIi, paloAltoLeef, forcepointLeef, stormshield, contentkeeper, ciscoIronportWsaIii, checkpointCef, corrata, ciscoFirepowerV6, menloSecurityCef, watchguardXtm, openSystemsSecureWebGateway, wandera, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.log_data_provider == null ? true : contains(["barracuda", "bluecoat", "checkpoint", "ciscoAsa", "ciscoIronportProxy", "fortigate", "paloAlto", "squid", "zscaler", "mcafeeSwg", "ciscoScanSafe", "juniperSrx", "sophosSg", "websenseV75", "websenseSiemCef", "machineZoneMeraki", "squidNative", "ciscoFwsm", "microsoftIsaW3C", "sonicwall", "sophosCyberoam", "clavister", "customParser", "juniperSsg", "zscalerQradar", "juniperSrxSd", "juniperSrxWelf", "microsoftConditionalAppAccess", "ciscoAsaFirepower", "genericCef", "genericLeef", "genericW3C", "iFilter", "checkpointXml", "checkpointSmartViewTracker", "barracudaNextGenFw", "barracudaNextGenFwWeblog", "microsoftDefenderForEndpoint", "zscalerCef", "sophosXg", "iboss", "forcepoint", "fortios", "ciscoIronportWsaIi", "paloAltoLeef", "forcepointLeef", "stormshield", "contentkeeper", "ciscoIronportWsaIii", "checkpointCef", "corrata", "ciscoFirepowerV6", "menloSecurityCef", "watchguardXtm", "openSystemsSecureWebGateway", "wandera", "unknownFutureValue"], var.log_data_provider)
    error_message = "log_data_provider must be one of the documented enum values."
  }
}

variable "log_file_count" {
  description = "The count of log files history."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.cloudAppDiscoveryReport"
  nullable    = false
}

variable "receiver_protocol" {
  description = "The applicable receiver protocol. The possible values are: ftp, ftps, syslogUdp, syslogTcp, syslogTls, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.receiver_protocol == null ? true : contains(["ftp", "ftps", "syslogUdp", "syslogTcp", "syslogTls", "unknownFutureValue"], var.receiver_protocol)
    error_message = "receiver_protocol must be one of the documented enum values."
  }
}

variable "supported_entity_types" {
  description = "The supported entity type. The possible values are: userName, ipAddress, machineName, other, unknown, unknownFutureValue."
  type        = list(string)
  default     = null
}

variable "supported_traffic_types" {
  description = "The supported traffic type. The possible values are: downloadedBytes, uploadedBytes, unknown, unknownFutureValue."
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
