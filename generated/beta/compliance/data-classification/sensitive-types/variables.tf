variable "classification_method" {
  description = "The classification method. The possible values are: patternMatch, exactDataMatch, fingerprint, machineLearning, privacyDataMatch, aiPowered, unknownFutureValue. privacyDataMatch performs privacy data matching based on tenant data. aiPowered performs AI-powered classification and can benefit from supported caller-supplied embeddings. unknownFutureValue is an evolvable enumeration sentinel value. Don't use it."
  type        = any
  default     = null

  validation {
    condition     = var.classification_method == null ? true : contains(["patternMatch", "exactDataMatch", "fingerprint", "machineLearning", "privacyDataMatch", "aiPowered", "unknownFutureValue"], var.classification_method)
    error_message = "classification_method must be one of the documented enum values."
  }
}

variable "description" {
  description = "The description of the sensitive information type."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the sensitive information type was last modified."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the sensitive information type."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.sensitiveType"
  nullable    = false
}

variable "publisher_name" {
  description = "The name of the publisher."
  type        = string
  default     = null
}

variable "rule_package_id" {
  description = "The identifier of the rule package."
  type        = string
  default     = null
}

variable "rule_package_type" {
  description = "The type of the rule package."
  type        = string
  default     = null
}

variable "scope" {
  description = "The scope of the sensitive information type. The possible values are: fullDocument, partialDocument."
  type        = any
  default     = null

  validation {
    condition     = var.scope == null ? true : contains(["fullDocument", "partialDocument"], var.scope)
    error_message = "scope must be one of the documented enum values."
  }
}

variable "sensitive_type_source" {
  description = "The source of sensitive type. The possible values are: outOfBox, tenant."
  type        = any
  default     = null

  validation {
    condition     = var.sensitive_type_source == null ? true : contains(["outOfBox", "tenant"], var.sensitive_type_source)
    error_message = "sensitive_type_source must be one of the documented enum values."
  }
}

variable "state" {
  description = "The state of the sensitive information type."
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
