variable "principal_id" {
  description = "Object ID of the user, group or service principal that receives the role. Microsoft Learn names \"identities, groups of identities, or service principals\" for entitlement management roles."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.principal_id))
    error_message = "principal_id must be an object ID (GUID)."
  }
}

variable "role" {
  description = <<-EOT
    The entitlement management role, by name. Set this or role_definition_id.
      - catalog_creator:                    tenant-wide; refuses catalog_id
      - catalog_owner:                      requires catalog_id
      - catalog_reader:                     requires catalog_id
      - access_package_manager:             requires catalog_id
      - access_package_assignment_manager:  requires catalog_id
  EOT
  type        = string
  default     = null

  validation {
    condition     = var.role == null || contains(["catalog_creator", "catalog_owner", "catalog_reader", "access_package_manager", "access_package_assignment_manager"], coalesce(var.role, "-"))
    error_message = "role must be one of \"catalog_creator\", \"catalog_owner\", \"catalog_reader\", \"access_package_manager\" or \"access_package_assignment_manager\"."
  }
}

variable "role_definition_id" {
  description = "The role definition ID (GUID) of an entitlement management role that has no name here, such as the Connected Organization Administrator. Set this or role. The scope is the catalog when catalog_id is set and the tenant otherwise."
  type        = string
  default     = null

  validation {
    condition     = var.role_definition_id == null || can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", coalesce(var.role_definition_id, "-")))
    error_message = "role_definition_id must be a role definition ID (GUID)."
  }
}

variable "catalog_id" {
  description = "ID (GUID) of the catalog the role applies to. Required for catalog roles, refused for catalog_creator. With role_definition_id, a set value scopes the assignment to the catalog and null to the tenant."
  type        = string
  default     = null

  validation {
    condition     = var.catalog_id == null || can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", coalesce(var.catalog_id, "-")))
    error_message = "catalog_id must be a catalog ID (GUID)."
  }
}

variable "api_version" {
  description = "Microsoft Graph API version to target. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
  }
}
