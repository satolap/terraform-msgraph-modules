variable "access_package_resource_request_id" {
  description = "The unique identifier of accessPackageResourceRequest"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_resource_request_id)) > 0
    error_message = "access_package_resource_request_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension", "#microsoft.graph.accessPackageAssignmentWorkflowExtension", "#microsoft.graph.identityGovernance.customTaskExtension", "#microsoft.graph.onAttributeCollectionStartCustomExtension", "#microsoft.graph.onAttributeCollectionSubmitCustomExtension", "#microsoft.graph.onOtpSendCustomExtension", "#microsoft.graph.onPasswordSubmitCustomExtension", "#microsoft.graph.onTokenIssuanceStartCustomExtension", "#microsoft.graph.onVerifiedIdClaimValidationCustomExtension"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "authentication_configuration" {
  description = "Configuration for securing the API call to the logic app. For example, using OAuth client credentials flow."
  type        = any
  default     = null
}

variable "client_configuration" {
  description = "HTTP connection settings that define how long Microsoft Entra ID can wait for a connection to a logic app, how many times you can retry a timed-out connection and the exception scenarios when retries are allowed."
  type = object({
    odata_type            = optional(string, "#microsoft.graph.customExtensionClientConfiguration")
    maximumRetries        = optional(number)
    timeoutInMilliseconds = optional(number)
  })
  default = null
}

variable "description" {
  description = "Description for the customCalloutExtension object."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for the customCalloutExtension object."
  type        = string
  default     = null
}

variable "endpoint_configuration" {
  description = "The type and details for configuring the endpoint to call the logic app's workflow."
  type        = any
  default     = null
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
