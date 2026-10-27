variable "tenant_id" {
  description = "Tenant GUID used by the msgraph provider and Azure CLI. Captured for fail-closed cleanup; ARM_TENANT_ID must match."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.tenant_id))
    error_message = "tenant_id must be the provider tenant ID (a GUID)."
  }
}

variable "principal_id" {
  description = "Object ID of the principal receiving the permanent active directory role."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.principal_id))
    error_message = "principal_id must be an object ID (a GUID)."
  }
}

variable "role_definition_id" {
  description = "Directory-specific role definition GUID. Set exactly one role selector."
  type        = string
  default     = null

  validation {
    condition     = var.role_definition_id == null ? true : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.role_definition_id))
    error_message = "role_definition_id must be null or a GUID."
  }
}

variable "template_id" {
  description = "Service-wide role template GUID, resolved through a read-only roleDefinitions lookup. Set exactly one role selector."
  type        = string
  default     = null

  validation {
    condition     = var.template_id == null ? true : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.template_id))
    error_message = "template_id must be null or a GUID."
  }
}

variable "role_display_name" {
  description = "Optional exact read-only display-name lookup; zero or multiple results are refused. Set exactly one role selector."
  type        = string
  default     = null

  validation {
    condition     = var.role_display_name == null ? true : length(trimspace(var.role_display_name)) > 0
    error_message = "role_display_name must be null or a nonempty name."
  }
}

variable "role_type" {
  description = "built_in or custom; checked against the read-only role definition. custom selects the custom-role licensing rule."
  type        = string
  default     = "built_in"
  nullable    = false

  validation {
    condition     = contains(["built_in", "custom"], var.role_type)
    error_message = "role_type must be built_in or custom."
  }
}

variable "directory_scope_id" {
  description = "Required explicit directory scope: /, /administrativeUnits/{GUID}, or /{application-object-GUID}. Application scope uses the object ID, not the client ID."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^/((administrativeUnits/)?[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})?$", var.directory_scope_id))
    error_message = "directory_scope_id must be /, /administrativeUnits/{GUID}, or /{application-object-GUID}."
  }
}

variable "scope_type" {
  description = "Required explicit scope type: tenant, administrative_unit or application; must agree with directory_scope_id. Selects the scope-specific licensing rule."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["tenant", "administrative_unit", "application"], var.scope_type)
    error_message = "scope_type must be tenant, administrative_unit or application."
  }
}
