variable "display_name" {
  description = "Display name of the application registration."
  type        = string

  validation {
    condition     = length(var.display_name) > 0 && length(var.display_name) <= 120
    error_message = "display_name must be between 1 and 120 characters."
  }
}

variable "sign_in_audience" {
  description = "Which Microsoft accounts are supported for the application."
  type        = string
  default     = "AzureADMyOrg"

  validation {
    condition = contains([
      "AzureADMyOrg",
      "AzureADMultipleOrgs",
      "AzureADandPersonalMicrosoftAccount",
      "PersonalMicrosoftAccount",
    ], var.sign_in_audience)
    error_message = "sign_in_audience must be one of AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount, or PersonalMicrosoftAccount."
  }
}

variable "description" {
  description = "Free-text description of the application."
  type        = string
  default     = null
}

variable "notes" {
  description = "Notes relevant to the management of the application."
  type        = string
  default     = null
}

variable "tags" {
  description = "Custom strings used to categorize and identify the application."
  type        = list(string)
  default     = []
}

variable "web_redirect_uris" {
  description = "Redirect URIs for the web platform."
  type        = list(string)
  default     = []
}

variable "spa_redirect_uris" {
  description = "Redirect URIs for the single-page-application platform."
  type        = list(string)
  default     = []
}

variable "public_client_redirect_uris" {
  description = "Redirect URIs for the mobile/desktop (public client) platform."
  type        = list(string)
  default     = []
}

variable "app_roles" {
  description = <<-EOT
    App roles exposed by this application. These are the roles that can be granted through an
    access package when the application is added to a catalog as a resource — each role's `id`
    (a GUID you supply) becomes the role_origin_id in the access-packages/resource-role-scopes module.
  EOT
  type = list(object({
    id                   = string
    display_name         = string
    description          = string
    value                = string
    allowed_member_types = optional(list(string), ["User"])
    is_enabled           = optional(bool, true)
  }))
  default = []

  validation {
    condition = alltrue([
      for r in var.app_roles : can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", r.id))
    ])
    error_message = "Each app_roles[*].id must be a stable GUID (use a random_uuid resource or an externally generated value, not uuid() which changes every plan)."
  }

  validation {
    condition = alltrue([
      for r in var.app_roles : length(r.allowed_member_types) > 0 && alltrue([
        for t in r.allowed_member_types : contains(["User", "Application"], t)
      ])
    ])
    error_message = "app_roles[*].allowed_member_types entries must be \"User\" and/or \"Application\"."
  }

  validation {
    condition     = length(distinct([for r in var.app_roles : lower(r.id)])) == length(var.app_roles)
    error_message = "App role IDs must be unique within the application."
  }

  validation {
    condition     = length(distinct([for r in var.app_roles : r.value])) == length(var.app_roles)
    error_message = "App role values must be unique because app_role_ids is keyed by value."
  }
}

variable "api_version" {
  description = "Microsoft Graph API version to target for the applications endpoint. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
  }
}
