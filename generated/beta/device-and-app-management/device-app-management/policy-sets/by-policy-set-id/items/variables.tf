variable "policy_set_id" {
  description = "The unique identifier of policySet"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.policy_set_id)) > 0
    error_message = "policy_set_id must not be empty."
  }
}

variable "created_date_time" {
  description = "Creation time of the PolicySetItem."
  type        = string
  default     = null
}

variable "display_name" {
  description = "DisplayName of the PolicySetItem."
  type        = string
  default     = null
}

variable "error_code" {
  description = "Microsoft Graph errorCode property."
  type        = string
  default     = null

  validation {
    condition     = var.error_code == null ? true : contains(["noError", "unauthorized", "notFound", "deleted"], var.error_code)
    error_message = "error_code must be one of the documented enum values."
  }
}

variable "guided_deployment_tags" {
  description = "Tags of the guided deployment"
  type        = list(string)
  default     = null
}

variable "item_type" {
  description = "policySetType of the PolicySetItem."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Last modified time of the PolicySetItem."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.policySetItem"
  nullable    = false
}

variable "payload_id" {
  description = "PayloadId of the PolicySetItem."
  type        = string
  default     = null
}

variable "status" {
  description = "The enum to specify the status of PolicySet."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "validating", "partialSuccess", "success", "error", "notAssigned"], var.status)
    error_message = "status must be one of the documented enum values."
  }
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
