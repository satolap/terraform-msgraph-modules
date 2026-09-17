variable "brand" {
  description = "The branch of a payload. The possible values are: unknown, other, americanExpress, capitalOne, dhl, docuSign, dropbox, facebook, firstAmerican, microsoft, netflix, scotiabank, sendGrid, stewartTitle, tesco, wellsFargo, syrinxCloud, adobe, teams, zoom, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.brand == null ? true : contains(["unknown", "other", "americanExpress", "capitalOne", "dhl", "docuSign", "dropbox", "facebook", "firstAmerican", "microsoft", "netflix", "scotiabank", "sendGrid", "stewartTitle", "tesco", "wellsFargo", "syrinxCloud", "adobe", "teams", "zoom", "unknownFutureValue"], var.brand)
    error_message = "brand must be one of the documented enum values."
  }
}

variable "complexity" {
  description = "The complexity of a payload. The possible values are: unknown, low, medium, high, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.complexity == null ? true : contains(["unknown", "low", "medium", "high", "unknownFutureValue"], var.complexity)
    error_message = "complexity must be one of the documented enum values."
  }
}

variable "created_by" {
  description = "Identity of the user who created the attack simulation and training campaign payload."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Date and time when the attack simulation and training campaign payload. The timestamp represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the attack simulation and training campaign payload."
  type        = string
  default     = null
}

variable "detail" {
  description = "More details about the payload."
  type        = any
  default     = null
}

variable "display_name" {
  description = "Display name of the attack simulation and training campaign payload. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "graph_source" {
  description = "Microsoft Graph source property."
  type        = string
  default     = null

  validation {
    condition     = var.graph_source == null ? true : contains(["unknown", "global", "tenant", "unknownFutureValue"], var.graph_source)
    error_message = "graph_source must be one of the documented enum values."
  }
}

variable "industry" {
  description = "Industry of a payload. The possible values are: unknown, other, banking, businessServices, consumerServices, education, energy, construction, consulting, financialServices, government, hospitality, insurance, legal, courierServices, IT, healthcare, manufacturing, retail, telecom, realEstate, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.industry == null ? true : contains(["unknown", "other", "banking", "businessServices", "consumerServices", "education", "energy", "construction", "consulting", "financialServices", "government", "hospitality", "insurance", "legal", "courierServices", "IT", "healthcare", "manufacturing", "retail", "telecom", "realEstate", "unknownFutureValue"], var.industry)
    error_message = "industry must be one of the documented enum values."
  }
}

variable "is_automated" {
  description = "Indicates whether the attack simulation and training campaign payload was created from an automation flow. Supports $filter and $orderby."
  type        = bool
  default     = null
}

variable "is_controversial" {
  description = "Indicates whether the payload is controversial."
  type        = bool
  default     = null
}

variable "is_current_event" {
  description = "Indicates whether the payload is from any recent event."
  type        = bool
  default     = null
}

variable "language" {
  description = "Payload language."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "Identity of the user who most recently modified the attack simulation and training campaign payload."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Date and time when the attack simulation and training campaign payload was last modified. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.payload"
  nullable    = false
}

variable "payload_tags" {
  description = "Free text tags for a payload."
  type        = list(string)
  default     = null
}

variable "platform" {
  description = "The payload delivery platform for a simulation. The possible values are: unknown, sms, email, teams, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.platform == null ? true : contains(["unknown", "sms", "email", "teams", "unknownFutureValue"], var.platform)
    error_message = "platform must be one of the documented enum values."
  }
}

variable "predicted_compromise_rate" {
  description = "Predicted probability for a payload to phish a targeted user."
  type        = any
  default     = null
}

variable "simulation_attack_type" {
  description = "Attack type of the attack simulation and training campaign. Supports $filter and $orderby. The possible values are: unknown, social, cloud, endpoint, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.simulation_attack_type == null ? true : contains(["unknown", "social", "cloud", "endpoint", "unknownFutureValue"], var.simulation_attack_type)
    error_message = "simulation_attack_type must be one of the documented enum values."
  }
}

variable "status" {
  description = "Simulation content status. Supports $filter and $orderby. The possible values are: unknown, draft, ready, archive, delete, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "draft", "ready", "archive", "delete", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "technique" {
  description = "The social engineering technique used in the attack simulation and training campaign. Supports $filter and $orderby. The possible values are: unknown, credentialHarvesting, attachmentMalware, driveByUrl, linkInAttachment, linkToMalwareFile, unknownFutureValue, oAuthConsentGrant, phishTraining. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: oAuthConsentGrant, phishTraining. For more information on the types of social engineering attack techniques, see simulations."
  type        = any
  default     = null

  validation {
    condition     = var.technique == null ? true : contains(["unknown", "credentialHarvesting", "attachmentMalware", "driveByUrl", "linkInAttachment", "linkToMalwareFile", "unknownFutureValue", "oAuthConsentGrant", "phishTraining"], var.technique)
    error_message = "technique must be one of the documented enum values."
  }
}

variable "theme" {
  description = "The theme of a payload. The possible values are: unknown, other, accountActivation, accountVerification, billing, cleanUpMail, controversial, documentReceived, expense, fax, financeReport, incomingMessages, invoice, itemReceived, loginAlert, mailReceived, password, payment, payroll, personalizedOffer, quarantine, remoteWork, reviewMessage, securityUpdate, serviceSuspended, signatureRequired, upgradeMailboxStorage, verifyMailbox, voicemail, advertisement, employeeEngagement, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.theme == null ? true : contains(["unknown", "other", "accountActivation", "accountVerification", "billing", "cleanUpMail", "controversial", "documentReceived", "expense", "fax", "financeReport", "incomingMessages", "invoice", "itemReceived", "loginAlert", "mailReceived", "password", "payment", "payroll", "personalizedOffer", "quarantine", "remoteWork", "reviewMessage", "securityUpdate", "serviceSuspended", "signatureRequired", "upgradeMailboxStorage", "verifyMailbox", "voicemail", "advertisement", "employeeEngagement", "unknownFutureValue"], var.theme)
    error_message = "theme must be one of the documented enum values."
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
