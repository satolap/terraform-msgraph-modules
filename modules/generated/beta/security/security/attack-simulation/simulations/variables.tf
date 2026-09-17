variable "attack_technique" {
  description = "The social engineering technique used in the attack simulation and training campaign. Supports $filter and $orderby. The possible values are: unknown, credentialHarvesting, attachmentMalware, driveByUrl, linkInAttachment, linkToMalwareFile, unknownFutureValue, oAuthConsentGrant, phishTraining. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: oAuthConsentGrant, phishTraining. For more information on the types of social engineering attack techniques, see simulations."
  type        = any
  default     = null

  validation {
    condition     = var.attack_technique == null ? true : contains(["unknown", "credentialHarvesting", "attachmentMalware", "driveByUrl", "linkInAttachment", "linkToMalwareFile", "unknownFutureValue", "oAuthConsentGrant", "phishTraining"], var.attack_technique)
    error_message = "attack_technique must be one of the documented enum values."
  }
}

variable "attack_type" {
  description = "Attack type of the attack simulation and training campaign. Supports $filter and $orderby. The possible values are: unknown, social, cloud, endpoint, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.attack_type == null ? true : contains(["unknown", "social", "cloud", "endpoint", "unknownFutureValue"], var.attack_type)
    error_message = "attack_type must be one of the documented enum values."
  }
}

variable "automation_id" {
  description = "Unique identifier for the attack simulation automation."
  type        = string
  default     = null
}

variable "completion_date_time" {
  description = "Date and time of completion of the attack simulation and training campaign. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "created_by" {
  description = "Identity of the user who created the attack simulation and training campaign."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Date and time of creation of the attack simulation and training campaign."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the attack simulation and training campaign."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name of the attack simulation and training campaign. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "duration_in_days" {
  description = "Simulation duration in days."
  type        = number
  default     = null
}

variable "end_user_notification_setting" {
  description = "Details about the end user notification setting."
  type        = any
  default     = null
}

variable "excluded_account_target" {
  description = "Users excluded from the simulation."
  type        = any
  default     = null
}

variable "included_account_target" {
  description = "Users targeted in the simulation."
  type        = any
  default     = null
}

variable "is_automated" {
  description = "Flag that represents if the attack simulation and training campaign was created from a simulation automation flow. Supports $filter and $orderby."
  type        = bool
  default     = null
}

variable "landing_page" {
  description = "The landing page associated with a simulation during its creation."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "Identity of the user who most recently modified the attack simulation and training campaign."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Date and time of the most recent modification of the attack simulation and training campaign."
  type        = string
  default     = null
}

variable "launch_date_time" {
  description = "Date and time of the launch/start of the attack simulation and training campaign. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "login_page" {
  description = "The login page associated with a simulation during its creation."
  type        = any
  default     = null
}

variable "o_auth_consent_app_detail" {
  description = "OAuth app details for the OAuth technique."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.simulation"
  nullable    = false
}

variable "payload" {
  description = "The payload associated with a simulation during its creation."
  type        = any
  default     = null
}

variable "payload_delivery_platform" {
  description = "Method of delivery of the phishing payload used in the attack simulation and training campaign. The possible values are: unknown, sms, email, teams, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.payload_delivery_platform == null ? true : contains(["unknown", "sms", "email", "teams", "unknownFutureValue"], var.payload_delivery_platform)
    error_message = "payload_delivery_platform must be one of the documented enum values."
  }
}

variable "report" {
  description = "Report of the attack simulation and training campaign."
  type        = any
  default     = null
}

variable "status" {
  description = "Status of the attack simulation and training campaign. Supports $filter and $orderby. The possible values are: unknown, draft, running, scheduled, succeeded, failed, cancelled, excluded, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "draft", "running", "scheduled", "succeeded", "failed", "cancelled", "excluded", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "training_setting" {
  description = "Details about the training settings for a simulation."
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
