variable "active_exploits_observed" {
  description = "Indicates whether this vulnerability has any known exploits associated to known bad actors."
  type        = bool
  default     = null
}

variable "articles" {
  description = "Articles related to this vulnerability."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.article")
    body = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.formattedContent")
      content    = optional(string)
      format     = optional(any)
    }))
    createdDateTime = optional(string)
    imageUrl        = optional(string)
    indicators = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.security.articleIndicator")
      artifact = optional(object({
        odata_type = optional(string, "#microsoft.graph.security.artifact")
      }))
      source = optional(string)
    })))
    isFeatured          = optional(bool)
    lastUpdatedDateTime = optional(string)
    summary = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.formattedContent")
      content    = optional(string)
      format     = optional(any)
    }))
    tags  = optional(list(string))
    title = optional(string)
  }))
  default = null
}

variable "common_weakness_enumeration_ids" {
  description = "Community-defined common weakness enumerations (CWE)."
  type        = list(string)
  default     = null
}

variable "components" {
  description = "Components related to this vulnerability article."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.vulnerabilityComponent")
    name       = optional(string)
  }))
  default = null
}

variable "created_date_time" {
  description = "The date and time when this vulnerability article was first created."
  type        = string
  default     = null
}

variable "cvss2_summary" {
  description = "Microsoft Graph cvss2Summary property."
  type = object({
    odata_type   = optional(string, "#microsoft.graph.security.cvssSummary")
    score        = optional(any)
    severity     = optional(any)
    vectorString = optional(string)
  })
  default = null
}

variable "cvss3_summary" {
  description = "Microsoft Graph cvss3Summary property."
  type = object({
    odata_type   = optional(string, "#microsoft.graph.security.cvssSummary")
    score        = optional(any)
    severity     = optional(any)
    vectorString = optional(string)
  })
  default = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.formattedContent")
    content    = optional(string)
    format     = optional(any)
  })
  default = null
}

variable "exploits" {
  description = "Known exploits for this vulnerability."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.hyperlink")
    name       = optional(string)
    url        = optional(string)
  }))
  default = null
}

variable "exploits_available" {
  description = "Indicates whether this vulnerability has exploits in public sources (such as Packetstorm or Exploit-DB) online."
  type        = bool
  default     = null
}

variable "has_chatter" {
  description = "Indicates whether chatter about this vulnerability has been discovered online."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when this vulnerability article was most recently updated."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.vulnerability"
  nullable    = false
}

variable "priority_score" {
  description = "A unique algorithm that reflects the priority of a vulnerability based on the CVSS score, exploits, chatter, and linkage to malware. This property also evaluates the recency of these components so users can understand which vulnerability should be remediated first."
  type        = number
  default     = null
}

variable "published_date_time" {
  description = "The date and time when this vulnerability article was published."
  type        = string
  default     = null
}

variable "references" {
  description = "Reference links where further information can be learned about this vulnerability."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.hyperlink")
    name       = optional(string)
    url        = optional(string)
  }))
  default = null
}

variable "remediation" {
  description = "Any known remediation steps."
  type        = any
  default     = null
}

variable "severity" {
  description = "Microsoft Graph severity property."
  type        = string
  default     = null

  validation {
    condition     = var.severity == null ? true : contains(["none", "low", "medium", "high", "critical", "unknownFutureValue"], var.severity)
    error_message = "severity must be one of the documented enum values."
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
