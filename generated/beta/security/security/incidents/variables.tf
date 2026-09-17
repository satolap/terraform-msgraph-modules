variable "alerts" {
  description = "The list of related alerts. Supports $expand."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.security.alert")
    actorDisplayName = optional(string)
    additionalData   = optional(any)
    alertPolicyId    = optional(string)
    alertWebUrl      = optional(string)
    assignedTo       = optional(string)
    categories       = optional(list(string))
    category         = optional(string)
    classification   = optional(any)
    comments = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.security.alertComment")
      comment              = optional(string)
      createdByDisplayName = optional(string)
      createdDateTime      = optional(string)
    })))
    createdDateTime = optional(string)
    customDetails   = optional(any)
    description     = optional(string)
    detectionSource = optional(any)
    detectorId      = optional(string)
    determination   = optional(any)
    evidence = optional(list(object({
      odata_type               = optional(string, "#microsoft.graph.security.alertEvidence")
      createdDateTime          = optional(string)
      detailedRoles            = optional(list(string))
      remediationStatus        = optional(string)
      remediationStatusDetails = optional(string)
      roles                    = optional(list(string))
      tags                     = optional(list(string))
      verdict                  = optional(string)
    })))
    firstActivityDateTime = optional(string)
    incidentId            = optional(string)
    incidentWebUrl        = optional(string)
    investigationState    = optional(any)
    lastActivityDateTime  = optional(string)
    lastUpdateDateTime    = optional(string)
    mitreTechniques       = optional(list(string))
    productName           = optional(string)
    providerAlertId       = optional(string)
    recommendedActions    = optional(string)
    resolvedDateTime      = optional(string)
    serviceSource         = optional(string)
    severity              = optional(string)
    status                = optional(string)
    systemTags            = optional(list(string))
    tenantId              = optional(string)
    threatDisplayName     = optional(string)
    threatFamilyName      = optional(string)
    title                 = optional(string)
  }))
  default = null
}

variable "assigned_to" {
  description = "Owner of the incident, or null if no owner is assigned. Free editable text."
  type        = string
  default     = null
}

variable "classification" {
  description = "The specification for the incident. The possible values are: unknown, falsePositive, truePositive, informationalExpectedActivity, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.classification == null ? true : contains(["unknown", "falsePositive", "truePositive", "informationalExpectedActivity", "unknownFutureValue"], var.classification)
    error_message = "classification must be one of the documented enum values."
  }
}

variable "comments" {
  description = "Array of comments created by the Security Operations (SecOps) team when the incident is managed."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.alertComment")
    comment              = optional(string)
    createdByDisplayName = optional(string)
    createdDateTime      = optional(string)
  }))
  default = null
}

variable "created_date_time" {
  description = "Time when the incident was first created."
  type        = string
  default     = null
}

variable "custom_tags" {
  description = "The collection of custom tags that are associated with an incident."
  type        = list(string)
  default     = null
}

variable "description" {
  description = "Description of the incident."
  type        = string
  default     = null
}

variable "determination" {
  description = "Specifies the determination of the incident. The possible values are: unknown, apt, malware, securityPersonnel, securityTesting, unwantedSoftware, other, multiStagedAttack, compromisedUser, phishing, maliciousUserActivity, clean, insufficientData, confirmedActivity, lineOfBusinessApplication, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.determination == null ? true : contains(["unknown", "apt", "malware", "securityPersonnel", "securityTesting", "unwantedSoftware", "other", "multiStagedAttack", "compromisedAccount", "phishing", "maliciousUserActivity", "notMalicious", "notEnoughDataToValidate", "confirmedActivity", "lineOfBusinessApplication", "unknownFutureValue"], var.determination)
    error_message = "determination must be one of the documented enum values."
  }
}

variable "display_name" {
  description = "The incident name."
  type        = string
  default     = null
}

variable "incident_web_url" {
  description = "The URL for the incident page in the Microsoft 365 Defender portal."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The identity that last modified the incident."
  type        = string
  default     = null
}

variable "last_update_date_time" {
  description = "Time when the incident was last updated."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.incident"
  nullable    = false
}

variable "priority_score" {
  description = "A priority score for the incident from 0 to 100, with > 85 being the top priority, 15 - 85 medium priority, and < 15 low priority. This score is generated using machine learning and is based on multiple factors, including severity, disruption impact, threat intelligence, alert types, asset criticality, threat analytics, incident rarity, and additional priority signals. The value can also be null which indicates the feature is not open for the tenant or the value of the score is pending calculation."
  type        = number
  default     = null
}

variable "recommended_actions" {
  description = "A rich text string that represents the actions that are reccomnded to take in order to resolve the incident."
  type        = string
  default     = null
}

variable "recommended_hunting_queries" {
  description = "List of hunting Kusto Query Language (KQL) queries related to the incident."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.recommendedHuntingQuery")
    kqlText    = optional(string)
  }))
  default = null
}

variable "redirect_incident_id" {
  description = "Only populated in case an incident is grouped together with another incident, as part of the logic that processes incidents. In such a case, the status property is redirected."
  type        = string
  default     = null
}

variable "resolving_comment" {
  description = "User input that explains the resolution of the incident and the classification choice. This property contains free editable text."
  type        = string
  default     = null
}

variable "severity" {
  description = "Microsoft Graph severity property."
  type        = string
  default     = null

  validation {
    condition     = var.severity == null ? true : contains(["unknown", "informational", "low", "medium", "high", "unknownFutureValue"], var.severity)
    error_message = "severity must be one of the documented enum values."
  }
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["active", "resolved", "inProgress", "redirected", "unknownFutureValue", "awaitingAction"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "summary" {
  description = "The overview of an attack. When applicable, the summary contains details of what occurred, impacted assets, and the type of attack."
  type        = string
  default     = null
}

variable "system_tags" {
  description = "The collection of system tags that are associated with the incident."
  type        = list(string)
  default     = null
}

variable "tenant_id" {
  description = "The Microsoft Entra tenant in which the alert was created."
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
