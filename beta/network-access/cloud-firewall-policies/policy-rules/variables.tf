variable "cloud_firewall_policy_id" {
  description = "The unique identifier of cloudFirewallPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.cloud_firewall_policy_id)) > 0
    error_message = "cloud_firewall_policy_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.networkaccess.cloudFirewallRule", "#microsoft.graph.networkaccess.fqdnFilteringRule", "#microsoft.graph.networkaccess.internetAccessForwardingRule", "#microsoft.graph.networkaccess.m365ForwardingRule", "#microsoft.graph.networkaccess.privateAccessForwardingRule", "#microsoft.graph.networkaccess.threatIntelligenceRule", "#microsoft.graph.networkaccess.tlsInspectionRule", "#microsoft.graph.networkaccess.urlDestinationFilteringRule", "#microsoft.graph.networkaccess.webCategoryFilteringRule"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "name" {
  description = "Name."
  type        = string
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
