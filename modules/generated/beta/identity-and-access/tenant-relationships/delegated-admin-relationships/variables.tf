variable "access_assignments" {
  description = "The access assignments associated with the delegated admin relationship."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.delegatedAdminAccessAssignment")
    accessContainer = optional(object({
      odata_type          = optional(string, "#microsoft.graph.delegatedAdminAccessContainer")
      accessContainerId   = optional(string)
      accessContainerType = optional(string)
    }))
    accessDetails = optional(object({
      odata_type = optional(string, "#microsoft.graph.delegatedAdminAccessDetails")
      unifiedRoles = optional(list(object({
        odata_type       = optional(string, "#microsoft.graph.unifiedRole")
        roleDefinitionId = optional(string)
      })))
    }))
  }))
  default = null
}

variable "access_details" {
  description = "Microsoft Graph accessDetails property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.delegatedAdminAccessDetails")
    unifiedRoles = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.unifiedRole")
      roleDefinitionId = optional(string)
    })))
  })
  default = null
}

variable "auto_extend_duration" {
  description = "The duration by which the validity of the relationship is automatically extended, denoted in ISO 8601 format. Supported values are: P0D, PT0S, P180D. The default value is PT0S. PT0S indicates that the relationship expires when the endDateTime is reached and it isn't automatically extended."
  type        = string
  default     = null
}

variable "customer" {
  description = "The display name and unique identifier of the customer of the relationship. This is configured either by the partner at the time the relationship is created or by the system after the customer approves the relationship. Can't be changed by the customer."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The display name of the relationship used for ease of identification. Must be unique across all delegated admin relationships of the partner. This is set by the partner only when the relationship is in the created status and can't be changed by the customer. Maximum length is 50 characters."
  type        = string
  default     = null
}

variable "duration" {
  description = "The duration of the relationship in ISO 8601 format. Must be a value between P1D and P2Y inclusive. This is set by the partner only when the relationship is in the created status and can't be changed by the customer."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.delegatedAdminRelationship"
  nullable    = false
}

variable "operations" {
  description = "The long running operations associated with the delegated admin relationship."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.delegatedAdminRelationshipOperation")
    operationType = optional(string)
    status        = optional(string)
  }))
  default = null
}

variable "requests" {
  description = "The requests associated with the delegated admin relationship."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.delegatedAdminRelationshipRequest")
    action     = optional(string)
  }))
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["activatedDateTime", "createdDateTime", "endDateTime", "id", "lastModifiedDateTime", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
