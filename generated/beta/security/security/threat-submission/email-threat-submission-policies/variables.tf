variable "customized_notification_sender_email_address" {
  description = "Specifies the email address of the sender from which email notifications will be sent to end users to inform them whether an email is spam, phish or clean. The default value is null. Optional for creation."
  type        = string
  default     = null
}

variable "customized_report_recipient_email_address" {
  description = "Specifies the destination where the reported messages from end users land whenever they report something as phish, junk or not junk. The default value is null. Optional for creation."
  type        = string
  default     = null
}

variable "is_always_report_enabled_for_users" {
  description = "Indicates whether end users can report a message as spam, phish or junk directly without a confirmation(popup). The default value is true.  Optional for creation."
  type        = bool
  default     = null
}

variable "is_ask_me_enabled_for_users" {
  description = "Indicates whether end users can confirm using a popup before reporting messages as spam, phish or not junk. The default value is true.  Optional for creation."
  type        = bool
  default     = null
}

variable "is_customized_message_enabled" {
  description = "Indicates whether the email notifications sent to end users to inform them if an email is a phish mail, spam or junk is customized or not. The default value is false. Optional for creation."
  type        = bool
  default     = null
}

variable "is_customized_message_enabled_for_phishing" {
  description = "If enabled, customized message only shows when email is reported as phishing. The default value is false. Optional for creation."
  type        = bool
  default     = null
}

variable "is_customized_notification_sender_enabled" {
  description = "Indicates whether to use the sender email address set using customizedNotificationSenderEmailAddress for sending email notifications to end users. The default value is false. Optional for creation."
  type        = bool
  default     = null
}

variable "is_never_report_enabled_for_users" {
  description = "Indicates whether end users can move the message from one folder to another based on the action of spam, phish or not junk without actually reporting it. The default value is true. Optional for creation."
  type        = bool
  default     = null
}

variable "is_organization_branding_enabled" {
  description = "Indicates whether the branding logo should be used in the email notifications sent to end users. The default value is false. Optional for creation."
  type        = bool
  default     = null
}

variable "is_report_from_quarantine_enabled" {
  description = "Indicates whether end users can submit from the quarantine page. The default value is true. Optional for creation."
  type        = bool
  default     = null
}

variable "is_report_to_customized_email_address_enabled" {
  description = "Indicates whether emails reported by end users should be sent to the custom mailbox configured using customizedReportRecipientEmailAddress.  The default value is false. Optional for creation."
  type        = bool
  default     = null
}

variable "is_report_to_microsoft_enabled" {
  description = "If enabled, the email is sent to Microsoft for analysis. The default value is false. Required for creation."
  type        = bool
  default     = null
}

variable "is_review_email_notification_enabled" {
  description = "Indicates whether an email notification is sent to the end user who reported the email when it has been reviewed by the admin. The default value is false. Optional for creation."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.emailThreatSubmissionPolicy"
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
