variable "assignments" {
  description = "Assignments of the PolicySet."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.policySetAssignment")
    lastModifiedDateTime = optional(string)
    target               = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "Creation time of the PolicySet."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the PolicySet."
  type        = string
  default     = null
}

variable "display_name" {
  description = "DisplayName of the PolicySet."
  type        = string
  default     = null
}

variable "error_code" {
  description = "Microsoft Graph errorCode property."
  type        = string
  default     = null

  validation {
    condition     = var.error_code == null ? true : contains(["noError", "unauthorized", "notFound", "deleted"], var.error_code)
    error_message = "error_code must be one of the documented enum values."
  }
}

variable "guided_deployment_tags" {
  description = "Tags of the guided deployment"
  type        = list(string)
  default     = null
}

variable "items" {
  description = "Items of the PolicySet with maximum count 100."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.policySetItem")
    createdDateTime      = optional(string)
    displayName          = optional(string)
    errorCode            = optional(string)
    guidedDeploymentTags = optional(list(string))
    itemType             = optional(string)
    lastModifiedDateTime = optional(string)
    payloadId            = optional(string)
    status               = optional(string)
  }))
  default = null
}

variable "last_modified_date_time" {
  description = "Last modified time of the PolicySet."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.policySet"
  nullable    = false
}

variable "role_scope_tags" {
  description = "RoleScopeTags of the PolicySet"
  type        = list(string)
  default     = null
}

variable "status" {
  description = "The enum to specify the status of PolicySet."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "validating", "partialSuccess", "success", "error", "notAssigned"], var.status)
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
