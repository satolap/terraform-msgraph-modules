variable "enable_destroy_cleanup" {
  description = "Create the Azure CLI destroy hook. Keep true for real deployments. Set false only before the first apply when an external owner handles removal, or in offline tests. Changing true to false runs the existing cleanup hook."
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
    The origin system of the underlying catalog resource this role/scope applies to.
    Microsoft Graph currently supports exactly three values for access package resources:
    "AadGroup" (an Entra ID group), "AadApplication" (an application/service principal's
    app roles), or "SharePointOnline" (a SharePoint Online site).
  EOT
  type        = string

  validation {
    condition     = contains(["AadGroup", "AadApplication", "SharePointOnline"], var.resource_origin_system)
    error_message = "resource_origin_system must be one of \"AadGroup\", \"AadApplication\", or \"SharePointOnline\"."
  }
}

variable "role_display_name" {
  description = <<-EOT
    Display name of the role to grant, matched (case-insensitively) against the roles
    Microsoft Graph reports for the resource in the catalog's resourceRoles list:
      - AadGroup:          "Member" or "Owner"
      - AadApplication:    the app role's display name (e.g. "Contributor")
      - SharePointOnline:  the site role's name (e.g. "Read", "Contribute", "Full Control")
  EOT
  type        = string

  validation {
    condition     = length(var.role_display_name) > 0
    error_message = "role_display_name must not be empty."
  }
}

variable "role_origin_id" {
  description = "Optional override of the role's origin ID. When set, the role is matched by originId in the catalog's resourceRoles list instead of by role_display_name. Normally leave null and let the module resolve it, per the documented list-roles-then-create-roleScope flow."
  type        = string
  default     = null
}

variable "scope_origin_id" {
  description = "Origin ID of the scope this role applies to. Defaults to the resource's own origin ID (its root scope); override to scope to a sub-resource, e.g. a specific SharePoint Online list within a site."
  type        = string
  default     = null
}

variable "scope_display_name" {
  description = "Display name of the scope. Defaults to \"Root\" when scope_origin_id is not set."
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
