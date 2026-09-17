variable "created_type" {
  description = "Microsoft Graph createdType property."
  type        = string
  default     = null

  validation {
    condition     = var.created_type == null ? true : contains(["approvedByAdmin", "addOnTenant", "unknownFutureValue"], var.created_type)
    error_message = "created_type must be one of the documented enum values."
  }
}

variable "creation_date_time" {
  description = "Microsoft Graph creationDateTime property."
  type        = string
  default     = null
}

variable "governed_tenant_id" {
  description = "Microsoft Graph governedTenantId property."
  type        = string
  default     = null
}

variable "governed_tenant_name" {
  description = "Microsoft Graph governedTenantName property."
  type        = string
  default     = null
}

variable "governing_tenant_id" {
  description = "Microsoft Graph governingTenantId property."
  type        = string
  default     = null
}

variable "governing_tenant_name" {
  description = "Microsoft Graph governingTenantName property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.governanceRelationship"
  nullable    = false
}

variable "policy_snapshot" {
  description = "Microsoft Graph policySnapshot property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.relationshipPolicy")
    delegatedAdministrationRoleAssignments = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.delegatedAdministrationRoleAssignmentSnapshot")
      groupDisplayName = optional(string)
      groupId          = optional(string)
      roleTemplates = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.roleTemplate")
        id         = optional(string)
        name       = optional(string)
      })))
    })))
    governedTenantCanTerminate = optional(bool)
    multiTenantApplicationsToProvision = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.multiTenantApplicationsToProvisionSnapshot")
      appId       = optional(string)
      displayName = optional(string)
      objectId    = optional(string)
      requiredResourceAccesses = optional(list(object({
        odata_type    = optional(string, "#microsoft.graph.applicationsRequiredResourceAccess")
        permissions   = optional(any)
        resourceAppId = optional(string)
      })))
    })))
    policyId = optional(string)
  })
  default = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["active", "terminated", "terminationRequestedByGoverningTenant", "unknownFutureValue"], var.status)
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
