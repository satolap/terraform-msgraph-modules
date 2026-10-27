variable "policy_set_id" {
  description = "The unique identifier of policySet"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.policy_set_id)) > 0
    error_message = "policy_set_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.deviceCompliancePolicyPolicySetItem", "#microsoft.graph.deviceConfigurationPolicySetItem", "#microsoft.graph.deviceManagementConfigurationPolicyPolicySetItem", "#microsoft.graph.deviceManagementScriptPolicySetItem", "#microsoft.graph.enrollmentRestrictionsConfigurationPolicySetItem", "#microsoft.graph.iosLobAppProvisioningConfigurationPolicySetItem", "#microsoft.graph.managedAppProtectionPolicySetItem", "#microsoft.graph.managedDeviceMobileAppConfigurationPolicySetItem", "#microsoft.graph.mdmWindowsInformationProtectionPolicyPolicySetItem", "#microsoft.graph.mobileAppPolicySetItem", "#microsoft.graph.targetedManagedAppConfigurationPolicySetItem", "#microsoft.graph.windows10EnrollmentCompletionPageConfigurationPolicySetItem", "#microsoft.graph.windowsAutopilotDeploymentProfilePolicySetItem"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
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
  description = "Error code if any occured."
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

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
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
