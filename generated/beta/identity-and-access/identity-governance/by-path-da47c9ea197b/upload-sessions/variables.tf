variable "access_package_assignment_id" {
  description = "The unique identifier of accessPackageAssignment"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_assignment_id)) > 0
    error_message = "access_package_assignment_id must not be empty."
  }
}

variable "access_package_resource_role_scope_id" {
  description = "The unique identifier of accessPackageResourceRoleScope"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_resource_role_scope_id)) > 0
    error_message = "access_package_resource_role_scope_id must not be empty."
  }
}

variable "data" {
  description = "An object containing the context for which this data is being uploaded."
  type        = any
  default     = null
}

variable "files" {
  description = "The files uploaded during this upload session. Supports $expand and $expand with nested $filter and $orderby."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.customDataProvidedResourceFile")
    name       = optional(string)
  }))
  default = null
}

variable "is_upload_done" {
  description = "Indicates if all the necessary files have been uploaded to this session."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.customDataProvidedResourceUploadSession"
  nullable    = false
}

variable "reference_id" {
  description = "The ID of the context for which data is being uploaded, for example, the Access Review instance ID. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "stats" {
  description = "Microsoft Graph stats property."
  type = object({
    odata_type         = optional(string, "#microsoft.graph.customDataProvidedResourceUploadStats")
    filesUploaded      = optional(number)
    totalBytesUploaded = optional(number)
  })
  default = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["active", "complete", "expired", "unknownFutureValue"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
