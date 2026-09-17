variable "app_id" {
  description = "The globally unique appId (also called client ID on the Microsoft Entra admin center) of the credentialed resource application."
  type        = string
  default     = null
}

variable "application_authentication_client_sign_in_activity" {
  description = "The sign-in activity of the application in a app-only authentication flow (app-to-app tokens) where the application acts like a client."
  type        = any
  default     = null
}

variable "application_authentication_resource_sign_in_activity" {
  description = "The sign-in activity of the application in a app-only authentication flow (app-to-app tokens) where the application acts like a resource."
  type        = any
  default     = null
}

variable "delegated_client_sign_in_activity" {
  description = "The sign-in activity of the application in a delegated flow (user sign-in) where the application acts like a client."
  type        = any
  default     = null
}

variable "delegated_resource_sign_in_activity" {
  description = "The sign-in activity of the application in a delegated flow (user sign-in) where the application acts like a resource."
  type        = any
  default     = null
}

variable "last_sign_in_activity" {
  description = "The most recent sign-in activity of the application across delegated or app-only flows where the application is used either as a client or resource."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.servicePrincipalSignInActivity"
  nullable    = false
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
