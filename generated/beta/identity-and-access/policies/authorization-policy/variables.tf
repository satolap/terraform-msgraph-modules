variable "allow_email_verified_users_to_join_organization" {
  description = "Indicates whether a user can join the tenant by email validation."
  type        = bool
  default     = null
}

variable "allow_invites_from" {
  description = "Indicates who can invite guests to the organization. The possible values are: none, adminsAndGuestInviters, adminsGuestInvitersAndAllMembers, everyone. everyone is the default setting for all cloud environments except US Government. For more information, see allowInvitesFrom values."
  type        = any
  default     = null

  validation {
    condition     = var.allow_invites_from == null ? true : contains(["none", "adminsAndGuestInviters", "adminsGuestInvitersAndAllMembers", "everyone", "unknownFutureValue"], var.allow_invites_from)
    error_message = "allow_invites_from must be one of the documented enum values."
  }
}

variable "allow_user_consent_for_risky_apps" {
  description = "Indicates whether user consent for risky apps is allowed. Default value is false. We recommend that you keep the value set to false."
  type        = bool
  default     = null
}

variable "allowed_to_sign_up_email_based_subscriptions" {
  description = "Indicates whether users can sign up for email based subscriptions."
  type        = bool
  default     = null
}

variable "allowed_to_use_sspr" {
  description = "Indicates whether administrators of the tenant can use the Self-Service Password Reset (SSPR). For more information, see Self-service password reset for administrators."
  type        = bool
  default     = null
}

variable "block_msol_power_shell" {
  description = "To disable the use of the MSOnline PowerShell module set this property to true. This also disables user-based access to the legacy service endpoint used by the MSOnline PowerShell module. This doesn't affect Microsoft Entra Connect or Microsoft Graph."
  type        = bool
  default     = null
}

variable "default_user_role_overrides" {
  description = "Microsoft Graph defaultUserRoleOverrides property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.defaultUserRoleOverride")
    isDefault  = optional(bool)
    rolePermissions = optional(list(object({
      odata_type              = optional(string, "#microsoft.graph.unifiedRolePermission")
      allowedResourceActions  = optional(list(string))
      condition               = optional(string)
      excludedResourceActions = optional(list(string))
    })))
  }))
  default = null
}

variable "default_user_role_permissions" {
  description = "Microsoft Graph defaultUserRolePermissions property."
  type = object({
    odata_type                               = optional(string, "#microsoft.graph.defaultUserRolePermissions")
    allowedToCreateApps                      = optional(bool)
    allowedToCreateSecurityGroups            = optional(bool)
    allowedToCreateTenants                   = optional(bool)
    allowedToReadBitlockerKeysForOwnedDevice = optional(bool)
    allowedToReadOtherUsers                  = optional(bool)
  })
  default = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "description" {
  description = "Description for this policy. Required."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for this policy. Required."
  type        = string
  default     = null
}

variable "enabled_preview_features" {
  description = "List of features enabled for private preview on the tenant."
  type        = list(string)
  default     = null
}

variable "guest_user_role_id" {
  description = "Represents role templateId for the role that should be granted to guests. Refer to List unifiedRoleDefinitions to find the list of available role templates. Currently following roles are supported:  User (a0b1b346-4d3e-4e8b-98f8-753987be4970), Guest User (10dae51f-b6af-4016-8d66-8c2a99b929b3), and Restricted Guest User (2af84b1e-32c8-42b7-82bc-daa82404023b)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.authorizationPolicy"
  nullable    = false
}

variable "permission_grant_policy_ids_assigned_to_default_user_role" {
  description = "Indicates if user consent to apps is allowed, and if it is, the app consent policy that governs the permission for users to grant consent. Values should be in the format managePermissionGrantsForSelf.{id} for user consent policies or managePermissionGrantsForOwnedResource.{id} for resource-specific consent policies, where {id} is the id of a built-in or custom app consent policy. An empty list indicates user consent to apps is disabled."
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
