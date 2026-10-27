variable "displayName" {
  description = "Display name of the custom Microsoft Entra directory role."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.displayName)) > 0
    error_message = "displayName must not be empty or whitespace."
  }
}

# A control of this module, not a Graph property, so it keeps the snake_case name
# that every verified module uses for it.
variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that displayName must match, such as the pattern of a naming convention. When it is set and displayName does not match, the plan fails. Null, the default, accepts any displayName."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}

variable "description" {
  description = "Description of the custom role. Null omits the property and does not request clearing an existing description."
  type        = string
  default     = null
}

variable "isEnabled" {
  description = "Whether the custom role is available for assignment. This module creates no assignment."
  type        = bool
  default     = true
  nullable    = false
}

variable "rolePermissions" {
  description = "One or more permission objects, each containing only a nonempty allowedResourceActions list. Actions use microsoft.directory/Entity/Action or microsoft.directory/Entity/PropertySet/Action syntax, including documented servicePrincipals consent actions qualified by a permission-grant policy ID. This checks syntax, not availability in custom roles or policy existence. Literal wildcards are refused; broad permissions, credential/owner updates and consent delegation need careful privilege review."
  # Maps retain unknown keys so unsupported properties are rejected rather than
  # silently discarded by Terraform's conversion to an object type.
  type     = list(map(list(string)))
  nullable = false

  validation {
    condition = length(var.rolePermissions) > 0 && alltrue([
      for permission in var.rolePermissions : try(
        length(permission) == 1 &&
        contains(keys(permission), "allowedResourceActions") &&
        length(permission.allowedResourceActions) > 0 &&
        alltrue([
          for action in permission.allowedResourceActions :
          (
            can(regex("^microsoft[.]directory/[A-Za-z][A-Za-z0-9]*([.][A-Za-z0-9]+)*(/[A-Za-z][A-Za-z0-9]*([.][A-Za-z0-9]+)*)?/[A-Za-z][A-Za-z0-9]*$", action)) &&
            !can(regex("^microsoft[.]directory/servicePrincipals/managePermissionGrantsFor(Self|All)([.]|$)", action))
          ) ||
          can(regex("^microsoft[.]directory/servicePrincipals/managePermissionGrantsFor(Self|All)[.][A-Za-z0-9_-]+$", action))
        ]),
        false
      )
    ])
    error_message = "rolePermissions must contain nonempty allowedResourceActions lists only, with microsoft.directory/Entity/Action, microsoft.directory/Entity/PropertySet/Action or documented servicePrincipals policy-qualified consent action values. Wildcards, condition and excludedResourceActions are not supported."
  }
}

variable "templateId" {
  description = "Optional cross-directory custom template GUID. A different GUID, including null to or from a value, replaces the role definition; changing only hexadecimal letter case does not. The old role is deleted first. Keep this stable."
  type        = string
  default     = null

  validation {
    condition     = var.templateId == null ? true : can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.templateId))
    error_message = "templateId must be null or a GUID."
  }
}
