variable "service_principal_id" {
  description = "The unique identifier of servicePrincipal"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.service_principal_id)) > 0
    error_message = "service_principal_id must not be empty."
  }
}

variable "synchronization_job_id" {
  description = "The unique identifier of synchronizationJob"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.synchronization_job_id)) > 0
    error_message = "synchronization_job_id must not be empty."
  }
}

variable "discoverabilities" {
  description = "Microsoft Graph discoverabilities property."
  type        = string
  default     = null

  validation {
    condition     = var.discoverabilities == null ? true : contains(["None", "AttributeNames", "AttributeDataTypes", "AttributeReadOnly", "ReferenceAttributes", "UnknownFutureValue"], var.discoverabilities)
    error_message = "discoverabilities must be one of the documented enum values."
  }
}

variable "discovery_date_time" {
  description = "Represents the discovery date and time using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the directory. Must be unique within the synchronization schema. Not nullable."
  type        = string
  default     = null
}

variable "objects" {
  description = "Collection of objects supported by the directory."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.objectDefinition")
    attributes = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.attributeDefinition")
      anchor            = optional(bool)
      apiExpressions    = optional(any)
      caseExact         = optional(bool)
      defaultValue      = optional(string)
      flowNullValues    = optional(bool)
      metadata          = optional(any)
      multivalued       = optional(bool)
      mutability        = optional(string)
      name              = optional(string)
      referencedObjects = optional(any)
      required          = optional(bool)
      type              = optional(string)
    })))
    metadata = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.objectDefinitionMetadataEntry")
      key        = optional(any)
      value      = optional(string)
    })))
    name          = optional(string)
    supportedApis = optional(list(string))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.directoryDefinition"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "readOnly", "version"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
