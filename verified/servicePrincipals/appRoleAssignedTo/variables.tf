variable "resourceId" {
  description = "Object ID of the resource service principal that defines the app role; not its application (client) ID. A different GUID replaces the assignment."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.resourceId))
    error_message = "resourceId must be the resource service principal object ID (a GUID)."
  }
}

variable "principalId" {
  description = "Object ID of the user, group or client service principal receiving the role. A different GUID replaces the assignment."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.principalId))
    error_message = "principalId must be a user, group or client service principal object ID (a GUID)."
  }
}

variable "appRoleId" {
  description = "Explicit app role GUID, mutually exclusive with appRoleValue. The all-zero GUID explicitly requests the default role for an application with no declared roles. No role is selected by default."
  type        = string
  default     = null

  validation {
    condition     = var.appRoleId == null ? true : can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.appRoleId))
    error_message = "appRoleId must be null or a GUID, including the explicit all-zero default role ID."
  }
}

variable "appRoleValue" {
  description = "Optional exact, case-sensitive appRoles value to resolve through a read-only resource service principal lookup. Exactly one enabled role with a valid GUID must match. Mutually exclusive with appRoleId. Changing the selector or resolved GUID replaces the assignment."
  type        = string
  default     = null

  validation {
    condition     = var.appRoleValue == null ? true : length(trimspace(var.appRoleValue)) > 0
    error_message = "appRoleValue must be null or a nonempty role value."
  }
}
