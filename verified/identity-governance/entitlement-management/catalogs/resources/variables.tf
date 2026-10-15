variable "enable_destroy_cleanup" {
  description = "Create the Azure CLI destroy hook. Keep true for real deployments. Set false only before the first apply when an external owner handles removal, or in offline tests. Changing true to false runs the existing cleanup hook."
  type        = bool
  default     = true
}

variable "catalog_id" {
  description = "ID of the entitlement management catalog to add the resource to."
  type        = string
}

variable "resource_origin_system" {
  description = "The origin system of the resource being added. One of \"AadGroup\", \"AadApplication\", or \"SharePointOnline\"."
  type        = string

  validation {
    condition     = contains(["AadGroup", "AadApplication", "SharePointOnline"], var.resource_origin_system)
    error_message = "resource_origin_system must be one of \"AadGroup\", \"AadApplication\", or \"SharePointOnline\"."
  }
}

variable "resource_origin_id" {
  description = <<-EOT
    The origin ID of the resource being added to the catalog:
      - AadGroup:         the Entra group's object ID
      - AadApplication:   the application's service principal object ID
      - SharePointOnline: the SharePoint Online site URL
  EOT
  type        = string
}

variable "resource_display_name" {
  description = "Optional display name to associate with the resource request."
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
  description = "If true, fail apply unless verification finds exactly one resource. If false, inspect the verified output; destruction still requires a captured resource ID."
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
