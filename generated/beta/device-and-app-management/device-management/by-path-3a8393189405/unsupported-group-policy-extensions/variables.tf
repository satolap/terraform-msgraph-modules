variable "group_policy_migration_report_id" {
  description = "The unique identifier of groupPolicyMigrationReport"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_policy_migration_report_id)) > 0
    error_message = "group_policy_migration_report_id must not be empty."
  }
}

variable "extension_type" {
  description = "ExtensionType of the unsupported extension."
  type        = string
  default     = null
}

variable "namespace_url" {
  description = "Namespace Url of the unsupported extension."
  type        = string
  default     = null
}

variable "node_name" {
  description = "Node name of the unsupported extension."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unsupportedGroupPolicyExtension"
  nullable    = false
}

variable "setting_scope" {
  description = "Scope of the group policy setting."
  type        = string
  default     = null

  validation {
    condition     = var.setting_scope == null ? true : contains(["unknown", "device", "user"], var.setting_scope)
    error_message = "setting_scope must be one of the documented enum values."
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
