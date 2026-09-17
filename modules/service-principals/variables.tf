variable "app_id" {
  description = "The application (client) ID of the application this service principal is associated with. Typically the app_id output of the applications module."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.app_id))
    error_message = "app_id must be a GUID."
  }
}

variable "account_enabled" {
  description = "Whether the service principal account is enabled. If false, no users can sign in to the app."
  type        = bool
  default     = true
}

variable "app_role_assignment_required" {
  description = "Whether an app role assignment is required before a user can sign in or an app can get a token for this service principal."
  type        = bool
  default     = false
}

variable "description" {
  description = "Free-text description of the service principal."
  type        = string
  default     = null
}

variable "notes" {
  description = "Free-text notes for managing the service principal."
  type        = string
  default     = null
}

variable "tags" {
  description = "Custom strings used to categorize the service principal. Setting [\"WindowsAzureActiveDirectoryIntegratedApp\"] makes the app visible as an enterprise application."
  type        = list(string)
  default     = []
}

variable "login_url" {
  description = "The home page or landing page of the application, used for SSO."
  type        = string
  default     = null
}

variable "preferred_single_sign_on_mode" {
  description = "The single sign-on mode configured for the application: \"password\", \"saml\", \"notSupported\", or \"oidc\"."
  type        = string
  default     = null

  validation {
    condition     = var.preferred_single_sign_on_mode == null ? true : contains(["password", "saml", "notSupported", "oidc"], var.preferred_single_sign_on_mode)
    error_message = "preferred_single_sign_on_mode must be one of \"password\", \"saml\", \"notSupported\", or \"oidc\"."
  }
}

variable "api_version" {
  description = "Microsoft Graph API version to target for the servicePrincipals endpoint. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
  }
}
