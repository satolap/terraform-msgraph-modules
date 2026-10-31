variable "enable_destroy_cleanup" {
  description = "Create the provider-native destroy cleanup. Keep true for real deployments. Set false only before the first apply when an external owner handles removal, or in offline tests. Changing true to false runs the registered removal action."
  type        = bool
  default     = true
}

variable "accessPackageCatalog-id" {
  description = "ID of the entitlement management catalog to add the resource to."
  type        = string
}

variable "resource_origin_system" {
  description = "The origin system of the resource being added. One of \"AadGroup\", \"AadApplication\", \"SharePointOnline\", \"AzureResources\", or \"DirectoryRole\" (preview catalog onboarding only; AzureResources is an Azure subscription or management group, whose Azure RBAC roles access packages can then grant)."
  type        = string

  validation {
    condition     = contains(["AadGroup", "AadApplication", "SharePointOnline", "AzureResources", "DirectoryRole"], var.resource_origin_system)
    error_message = "resource_origin_system must be one of \"AadGroup\", \"AadApplication\", \"SharePointOnline\", \"AzureResources\", or \"DirectoryRole\"."
  }
}

variable "acknowledge_directory_role_preview" {
  description = "Explicitly acknowledge DirectoryRole preview catalog onboarding, its privileged caller requirements and that onboarding lets catalog owners and access package managers include this role in access packages; onboard only roles you would delegate to them, and avoid privileged roles. Package role scopes and preview restrictions need separate acceptance before granting access."
  type        = bool
  default     = false
  nullable    = false

  validation {
    condition     = var.resource_origin_system == "DirectoryRole" ? var.acknowledge_directory_role_preview : true
    error_message = "DirectoryRole onboarding requires acknowledge_directory_role_preview = true. This adds a catalog resource only; it does not itself assign an Entra role or establish support for a package role scope."
  }
}

variable "resource_origin_id" {
  description = <<-EOT
    The origin ID of the resource being added to the catalog:
      - AadGroup:         the Entra group's object ID
      - AadApplication:   the application's service principal object ID
      - DirectoryRole:    the Entra role definition ID (GUID), not a role assignment or template name
      - SharePointOnline: the SharePoint Online site URL
      - AzureResources:   the Azure resource ID of a subscription (/subscriptions/<subscription GUID>)
                          or a management group (/providers/Microsoft.Management/managementGroups/<ID>)
  EOT
  type        = string

  validation {
    condition     = var.resource_origin_system == "DirectoryRole" ? can(regex("(?i)^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.resource_origin_id)) : true
    error_message = "For DirectoryRole, resource_origin_id must be an Entra role definition ID in GUID form."
  }
}

variable "resource_display_name" {
  description = "Optional display name to associate with the resource request. Microsoft's Azure resource examples set it to the subscription or management group name."
  type        = string
  default     = null
}

variable "verification_delay_seconds" {
  description = "Seconds to wait after submitting the add/remove request before querying the catalog to verify the resource landed (or was removed). Entitlement management resource provisioning is asynchronous, especially for SharePoint Online sites."
  type        = number
  default     = 30

  validation {
    condition     = var.verification_delay_seconds >= 0 && floor(var.verification_delay_seconds) == var.verification_delay_seconds
    error_message = "verification_delay_seconds must be a non-negative whole number."
  }
}

variable "fail_on_verification_mismatch" {
  description = "If true, fail apply unless verification finds exactly one resource. If false, the optional verification gate is disabled only; enable_destroy_cleanup = true still requires strict independent identity verification and fails apply on a mismatch. With cleanup disabled too, inspect the verified output and arrange external removal."
  type        = bool
  default     = true
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
