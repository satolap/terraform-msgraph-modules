variable "activation_state" {
  description = "Microsoft Graph activationState property."
  type        = string
  default     = null

  validation {
    condition     = var.activation_state == null ? true : contains(["activated", "assignmentPending", "assignmentFailed", "updatePending", "updateFailed", "unknownFutureValue"], var.activation_state)
    error_message = "activation_state must be one of the documented enum values."
  }
}

variable "assignment_category" {
  description = "Contains the assignment category such as Primary or Private. The possible values are: primary, private, alternate, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.assignment_category == null ? true : contains(["primary", "private", "alternate", "unknownFutureValue"], var.assignment_category)
    error_message = "assignment_category must be one of the documented enum values."
  }
}

variable "assignment_status" {
  description = "The assignment status of the phone number. The possible values are: unassigned, internalError, userAssigned, conferenceAssigned, voiceApplicationAssigned, thirdPartyAppAssigned, policyAssigned, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.assignment_status == null ? true : contains(["unassigned", "internalError", "userAssigned", "conferenceAssigned", "voiceApplicationAssigned", "thirdPartyAppAssigned", "policyAssigned", "unknownFutureValue"], var.assignment_status)
    error_message = "assignment_status must be one of the documented enum values."
  }
}

variable "assignment_target_id" {
  description = "The ID of the object the phone number is assigned to, either the ObjectId of a user or resource account, or the policy instance ID of a Teams shared calling routing policy instance."
  type        = string
  default     = null
}

variable "capabilities" {
  description = "The list of capabilities assigned to the phone number."
  type        = list(string)
  default     = null
}

variable "city" {
  description = "The city where the phone number is located or associated with."
  type        = string
  default     = null
}

variable "civic_address_id" {
  description = "The ID of the civic address assigned to the phone number."
  type        = string
  default     = null
}

variable "iso_country_code" {
  description = "The ISO country code assigned to the phone number."
  type        = string
  default     = null
}

variable "location_id" {
  description = "The ID of the location assigned to the phone number."
  type        = string
  default     = null
}

variable "network_site_id" {
  description = "This property is reserved for internal Microsoft use."
  type        = string
  default     = null
}

variable "number_source" {
  description = "The source of the phone number. online is used for phone numbers assigned in Microsoft 365, and onPremises is used for phone numbers assigned in AD on-premises, which are synchronized into Microsoft 365. The possible values are: online, onPremises, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.number_source == null ? true : contains(["online", "onPremises", "unknownFutureValue"], var.number_source)
    error_message = "number_source must be one of the documented enum values."
  }
}

variable "number_type" {
  description = "Microsoft Graph numberType property."
  type        = string
  default     = null

  validation {
    condition     = var.number_type == null ? true : contains(["internalError", "directRouting", "callingPlan", "operatorConnect", "unknownFutureValue"], var.number_type)
    error_message = "number_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsAdministration.numberAssignment"
  nullable    = false
}

variable "operator_id" {
  description = "The ID of the operator."
  type        = string
  default     = null
}

variable "port_in_status" {
  description = "The status of any port in order covering the phone number. The possible values are: completed, firmOrderCommitmentAccepted, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.port_in_status == null ? true : contains(["completed", "firmOrderCommitmentAccepted", "unknownFutureValue"], var.port_in_status)
    error_message = "port_in_status must be one of the documented enum values."
  }
}

variable "reverse_number_lookup_options" {
  description = "Status of Reverse Number Lookup (RNL). If set to skipInternalVoip, calls are routed through the external Public Switched Telephone Network (PSTN) instead of using internal VoIP resolution."
  type        = list(string)
  default     = null
}

variable "supported_customer_actions" {
  description = "Indicates what customer actions are available to modify the number."
  type        = list(string)
  default     = null
}

variable "telephone_number" {
  description = "The telephone number in the record. The recorded telephone number is always displayed with a '+' prefix, regardless of whether it was originally assigned with one."
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
