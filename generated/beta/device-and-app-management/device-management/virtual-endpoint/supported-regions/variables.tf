variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcSupportedRegion"
  nullable    = false
}

variable "region_group" {
  description = "Microsoft Graph regionGroup property."
  type        = string
  default     = null

  validation {
    condition     = var.region_group == null ? true : contains(["default", "australia", "canada", "usCentral", "usEast", "usWest", "france", "germany", "europeUnion", "unitedKingdom", "japan", "asia", "india", "southAmerica", "euap", "usGovernment", "usGovernmentDOD", "unknownFutureValue", "norway", "switzerland", "southKorea", "middleEast", "mexico", "australasia", "europe", "singapore", "hongKong", "ireland", "sweden", "poland", "italy", "spain", "netherlands", "brazil", "israel", "automatic", "indonesia", "taiwan", "malaysia", "newZealand", "austria", "denmark", "belgium", "kenya"], var.region_group)
    error_message = "region_group must be one of the documented enum values."
  }
}

variable "supported_solution" {
  description = "Microsoft Graph supportedSolution property."
  type        = string
  default     = null

  validation {
    condition     = var.supported_solution == null ? true : contains(["windows365", "devBox", "unknownFutureValue", "rpaBox", "microsoft365Opal", "microsoft365BizChat"], var.supported_solution)
    error_message = "supported_solution must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["displayName", "geographicLocationType", "id", "regionRestrictionDetail", "regionStatus"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
