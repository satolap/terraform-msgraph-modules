variable "enable_destroy_cleanup" {
  description = "Register provider-native destroy cleanup after independent verification. Keep true for real deployments. Set false only before the first apply when an external owner handles removal, or in offline tests. Changing true to false removes the owned scope."
  type        = bool
  default     = true
}

variable "access_package_id" {
  description = "ID of the access package to attach this resource role scope to."
  type        = string
}

variable "catalog_id" {
  description = "ID of the entitlement management catalog that contains both the access package and the resource. Used to look the resource's roles up from the catalog's resourceRoles endpoint."
  type        = string
}

variable "catalog_resource_id" {
  description = "The catalog-internal ID of the accessPackageResource (NOT the group/service principal object ID or site URL). Use the resource_id output of the catalogs/resources module, which captures it after adding the resource to the catalog."
  type        = string
}

variable "resource_origin_system" {
  description = <<-EOT
    The origin system of the underlying catalog resource this role/scope applies to:
    "AadGroup" (an Entra ID group), "AadApplication" (an application/service principal's
    app roles), "SharePointOnline" (a SharePoint Online site), or "AzureResources" (an
    Azure subscription or management group, whose Azure RBAC roles the package grants).
  EOT
  type        = string

  validation {
    condition     = contains(["AadGroup", "AadApplication", "SharePointOnline", "AzureResources"], var.resource_origin_system)
    error_message = "resource_origin_system must be one of \"AadGroup\", \"AadApplication\", \"SharePointOnline\", or \"AzureResources\"."
  }
}

variable "role_display_name" {
  description = <<-EOT
    Display name of the role to grant, matched (case-insensitively) against the roles
    Microsoft Graph reports for the resource in the catalog's resourceRoles list:
      - AadGroup:          "Member" or "Owner"
      - AadApplication:    the app role's display name (e.g. "Contributor")
      - SharePointOnline:  the site role's name (e.g. "Read", "Contribute", "Full Control")
      - AzureResources:    the Azure role's name (e.g. "Reader"). Graph cannot list Azure
                           roles, so it is sent as given and the role is identified by
                           role_definition_id or role_origin_id instead.
  EOT
  type        = string

  validation {
    condition     = length(var.role_display_name) > 0
    error_message = "role_display_name must not be empty."
  }
}

variable "role_origin_id" {
  description = "Optional override of the role's origin ID. When set, the role is matched by originId in the catalog's resourceRoles list instead of by role_display_name. Normally leave null and let the module resolve it, per the documented list-roles-then-create-roleScope flow. For AzureResources it is sent verbatim as the role definition's full resource ID, as an alternative to role_definition_id."
  type        = string
  default     = null
}

variable "role_definition_id" {
  description = "AzureResources only: the GUID of the Azure role definition to grant: the ID that Azure built-in roles lists for each role, or the name that `az role definition list` returns. The module builds the documented origin ID: /subscriptions/<subscription GUID>/providers/Microsoft.Authorization/roleDefinitions/<GUID> for a subscription (any role assignable there, including a custom role from a parent management group), /providers/Microsoft.Authorization/roleDefinitions/<GUID> for a management group (built-in roles; for a custom role assignable only on the management group, set role_origin_id to the id that `az role definition list --scope <management group ID>` returns). Set this or role_origin_id."
  type        = string
  default     = null

  validation {
    condition     = var.role_definition_id == null || can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.role_definition_id))
    error_message = "role_definition_id must be a role definition GUID, not a resource ID; pass a full role definition ID as role_origin_id instead."
  }
}

variable "role_type" {
  description = "AzureResources only, and required there: \"active\" for a standing Azure role assignment, or \"eligible\" for an assignment the user activates through Privileged Identity Management. Leave null for other origin systems."
  type        = string
  default     = null

  validation {
    condition     = var.role_type == null || contains(["active", "eligible"], coalesce(var.role_type, "active"))
    error_message = "role_type must be \"active\", \"eligible\", or null."
  }
}

variable "scope_origin_id" {
  description = "Origin ID of the scope this role applies to. Defaults to the resource's own origin ID (its root scope); override to scope to a sub-resource, e.g. a specific SharePoint Online list within a site. For AzureResources, set it to a resource group in the subscription (/subscriptions/<subscription GUID>/resourceGroups/<name>) that Graph lists among the catalog resource's scopes; a management group offers only its root scope."
  type        = string
  default     = null
}

variable "scope_display_name" {
  description = "Display name of the scope. Defaults to \"Root\" when scope_origin_id is not set. For AzureResources it defaults to the display name Graph lists for the scope, such as \"/resourceGroups/<name>\"."
  type        = string
  default     = null
}

variable "api_version" {
  description = "Microsoft Graph API version to target for the resourceRoleScopes endpoint. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
  }
}
