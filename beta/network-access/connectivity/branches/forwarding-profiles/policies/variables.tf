variable "branch_site_id" {
  description = "The unique identifier of branchSite"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.branch_site_id)) > 0
    error_message = "branch_site_id must not be empty."
  }
}

variable "forwarding_profile_id" {
  description = "The unique identifier of forwardingProfile"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.forwarding_profile_id)) > 0
    error_message = "forwarding_profile_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.networkaccess.cloudFirewallPolicyLink", "#microsoft.graph.networkaccess.forwardingPolicyLink", "#microsoft.graph.networkaccess.threatIntelligencePolicyLink", "#microsoft.graph.networkaccess.tlsInspectionPolicyLink"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "graph_version" {
  description = "Version."
  type        = string
  default     = null
}

variable "policy" {
  description = "Microsoft Graph policy property."
  type        = any
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["enabled", "disabled", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
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
