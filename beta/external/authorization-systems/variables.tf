variable "authorization_system_id" {
  description = "ID of the authorization system retrieved from the customer cloud environment. Supports $filter(eq, contains) and $orderBy."
  type        = string
  default     = null
}

variable "authorization_system_name" {
  description = "Name of the authorization system detected after onboarding. Supports $filter(eq,contains) and $orderBy."
  type        = string
  default     = null
}

variable "authorization_system_type" {
  description = "The type of authorization system. Can be gcp, azure, or aws. Supports $filter(eq)."
  type        = string
  default     = null
}

variable "data_collection_info" {
  description = "Defines how and whether Permissions Management collects data from the onboarded authorization system. Supports $filter (eq) as follows:  $filter=dataCollectionInfo/entitlements/permissionsModificationCapability and $filter=dataCollectionInfo/entitlements/status."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.authorizationSystem"
  nullable    = false
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
