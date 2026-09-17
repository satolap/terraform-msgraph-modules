variable "admin_review" {
  description = "Specifies the admin review property that constitutes of who reviewed the user submission, when and what was it identified as."
  type        = any
  default     = null
}

variable "attack_simulation_info" {
  description = "If the email is phishing simulation, this field won't be null."
  type        = any
  default     = null
}

variable "category" {
  description = "Microsoft Graph category property."
  type        = string
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["notJunk", "spam", "phishing", "malware", "unknownFutureValue"], var.category)
    error_message = "category must be one of the documented enum values."
  }
}

variable "client_source" {
  description = "Specifies the source of the submission. The possible values are: microsoft, other, and unkownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.client_source == null ? true : contains(["microsoft", "other", "unknownFutureValue"], var.client_source)
    error_message = "client_source must be one of the documented enum values."
  }
}

variable "content_type" {
  description = "Specifies the type of content being submitted. The possible values are: email, url, file, app, and unkownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.content_type == null ? true : contains(["email", "url", "file", "app", "unknownFutureValue"], var.content_type)
    error_message = "content_type must be one of the documented enum values."
  }
}

variable "created_by" {
  description = "Specifies who submitted the email as a threat. Supports $filter = createdBy/email eq 'value'."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Specifies when the threat submission was created. Supports $filter = createdDateTime ge 2022-01-01T00:00:00Z and createdDateTime lt 2022-01-02T00:00:00Z."
  type        = string
  default     = null
}

variable "graph_source" {
  description = "Specifies the role of the submitter. Supports $filter = source eq 'value'. The possible values are: administrator,  user, and unkownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.graph_source == null ? true : contains(["user", "administrator", "unknownFutureValue"], var.graph_source)
    error_message = "graph_source must be one of the documented enum values."
  }
}

variable "internet_message_id" {
  description = "Specifies the internet message ID of the email being submitted. This information is present in the email header."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.emailThreatSubmission"
  nullable    = false
}

variable "original_category" {
  description = "The original category of the submission. The possible values are: notJunk, spam, phishing, malware and unkownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.original_category == null ? true : contains(["notJunk", "spam", "phishing", "malware", "unknownFutureValue"], var.original_category)
    error_message = "original_category must be one of the documented enum values."
  }
}

variable "received_date_time" {
  description = "Specifies the date and time stamp when the email was received."
  type        = string
  default     = null
}

variable "recipient_email_address" {
  description = "Specifies the email address (in smtp format) of the recipient who received the email."
  type        = string
  default     = null
}

variable "result" {
  description = "Specifies the result of the analysis performed by Microsoft."
  type        = any
  default     = null
}

variable "sender" {
  description = "Specifies the email address of the sender."
  type        = string
  default     = null
}

variable "sender_ip" {
  description = "Specifies the IP address of the sender."
  type        = string
  default     = null
}

variable "status" {
  description = "Indicates whether the threat submission has been analyzed by Microsoft. Supports $filter = status eq 'value'. The possible values are: notStarted, running, succeeded, failed, skipped, and unkownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["notStarted", "running", "succeeded", "failed", "skipped", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "subject" {
  description = "Specifies the subject of the email."
  type        = string
  default     = null
}

variable "tenant_allow_or_block_list_action" {
  description = "It's used to automatically add allows for the components such as URL, file, sender; which are deemed bad by Microsoft so that similar messages in the future can be allowed."
  type        = any
  default     = null
}

variable "tenant_id" {
  description = "Indicates the tenant id of the submitter. Not required when created using a POST operation. It's extracted from the token of the post API call."
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
