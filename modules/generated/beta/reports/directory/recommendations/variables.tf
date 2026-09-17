variable "action_steps" {
  description = "List of actions to take to complete a recommendation."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.actionStep")
    actionUrl  = optional(any)
    stepNumber = optional(number)
    text       = optional(string)
  }))
  default = null
}

variable "benefits" {
  description = "An explanation of why completing the recommendation will benefit you. Corresponds to the Value section of a recommendation shown in the Microsoft Entra admin center."
  type        = string
  default     = null
}

variable "category" {
  description = "Microsoft Graph category property."
  type        = string
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["identityBestPractice", "identitySecureScore", "unknownFutureValue", "mdiSecureScore"], var.category)
    error_message = "category must be one of the documented enum values."
  }
}

variable "category_group" {
  description = "Microsoft Graph categoryGroup property."
  type        = string
  default     = null

  validation {
    condition     = var.category_group == null ? true : contains(["strengthenAuthentication", "detectAndRespondToThreats", "enforceLeastPrivilege", "governAppsCredentialsAndAgents", "hardenInfrastructure", "defenderForIdentity", "unknownFutureValue"], var.category_group)
    error_message = "category_group must be one of the documented enum values."
  }
}

variable "completed_by_system_date_time" {
  description = "Microsoft Graph completedBySystemDateTime property."
  type        = string
  default     = null
}

variable "completed_by_user_date_time" {
  description = "Microsoft Graph completedByUserDateTime property."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the recommendation was detected as applicable to your directory."
  type        = string
  default     = null
}

variable "current_score" {
  description = "The number of points the tenant has attained. Only applies to recommendations with category set to identitySecureScore."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The title of the recommendation."
  type        = string
  default     = null
}

variable "failed_review_date_time" {
  description = "Microsoft Graph failedReviewDateTime property."
  type        = string
  default     = null
}

variable "feature_areas" {
  description = "The directory feature that the recommendation is related to."
  type        = any
  default     = null
}

variable "impact_start_date_time" {
  description = "The future date and time when a recommendation should be completed."
  type        = string
  default     = null
}

variable "impact_type" {
  description = "Indicates the scope of impact of a recommendation. tenantLevel indicates that the recommendation impacts the whole tenant. Other possible values include users, apps."
  type        = string
  default     = null
}

variable "impacted_resources" {
  description = "The list of directory objects associated with the recommendation."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.impactedResource")
    addedDateTime = optional(string)
    additionalDetails = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.keyValue")
      key        = optional(string)
      value      = optional(string)
    })))
    apiUrl                = optional(string)
    displayName           = optional(string)
    lastModifiedBy        = optional(string)
    lastModifiedDateTime  = optional(string)
    owner                 = optional(string)
    portalUrl             = optional(string)
    postponeUntilDateTime = optional(string)
    rank                  = optional(number)
    recommendationId      = optional(string)
    resourceType          = optional(string)
    status                = optional(string)
    subjectId             = optional(string)
    tags = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.recommendationTag")
      displayName = optional(string)
    })))
  }))
  default = null
}

variable "insights" {
  description = "Describes why a recommendation uniquely applies to your directory. Corresponds to the Description section of a recommendation shown in the Microsoft Entra admin center."
  type        = string
  default     = null
}

variable "last_checked_date_time" {
  description = "The most recent date and time a recommendation was deemed applicable to your directory."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "Name of the user who last updated the status of the recommendation."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time the status of a recommendation was last updated."
  type        = string
  default     = null
}

variable "max_score" {
  description = "The maximum number of points attainable. Only applies to recommendations with category set to identitySecureScore."
  type        = any
  default     = null
}

variable "needs_more_action_resource_count" {
  description = "Microsoft Graph needsMoreActionResourceCount property."
  type        = number
  default     = null
}

variable "nist_classifications" {
  description = "Microsoft Graph nistClassifications property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.nistClassification")
    category    = optional(string)
    description = optional(string)
    function    = optional(string)
    name        = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.recommendation"
  nullable    = false
}

variable "postpone_until_date_time" {
  description = "The future date and time when the status of a postponed recommendation will be active again."
  type        = string
  default     = null
}

variable "priority" {
  description = "Microsoft Graph priority property."
  type        = string
  default     = null

  validation {
    condition     = var.priority == null ? true : contains(["low", "medium", "high", "critical", "unknownFutureValue"], var.priority)
    error_message = "priority must be one of the documented enum values."
  }
}

variable "recommendation_type" {
  description = "Friendly shortname to identify the recommendation. The possible values are: adfsAppsMigration, enableDesktopSSO, enablePHS, enableProvisioning, switchFromPerUserMFA, tenantMFA, thirdPartyApps, turnOffPerUserMFA, useAuthenticatorApp, useMyApps, staleApps, staleAppCreds, applicationCredentialExpiry, servicePrincipalKeyExpiry, adminMFAV2, blockLegacyAuthentication, integratedApps, mfaRegistrationV2, pwagePolicyNew, passwordHashSync, oneAdmin, roleOverlap, selfServicePasswordReset, signinRiskPolicy, userRiskPolicy, verifyAppPublisher, privateLinkForAAD, appRoleAssignmentsGroups, appRoleAssignmentsUsers, managedIdentity, overprivilegedApps, unknownFutureValue, longLivedCredentials, aadConnectDeprecated, adalToMsalMigration, ownerlessApps, inactiveGuests, aadGraphDeprecationApplication, aadGraphDeprecationServicePrincipal, mfaServerDeprecation. Use the Prefer: include-unknown-enum-members request header to get the following members in this evolvable enum: longLivedCredentials , aadConnectDeprecated , adalToMsalMigration , ownerlessApps , inactiveGuests , aadGraphDeprecationApplication , aadGraphDeprecationServicePrincipal , mfaServerDeprecation."
  type        = any
  default     = null

  validation {
    condition     = var.recommendation_type == null ? true : contains(["adfsAppsMigration", "enableDesktopSSO", "enablePHS", "enableProvisioning", "switchFromPerUserMFA", "tenantMFA", "thirdPartyApps", "turnOffPerUserMFA", "useAuthenticatorApp", "useMyApps", "staleApps", "staleAppCreds", "applicationCredentialExpiry", "servicePrincipalKeyExpiry", "adminMFAV2", "blockLegacyAuthentication", "integratedApps", "mfaRegistrationV2", "pwagePolicyNew", "passwordHashSync", "oneAdmin", "roleOverlap", "selfServicePasswordReset", "signinRiskPolicy", "userRiskPolicy", "verifyAppPublisher", "privateLinkForAAD", "appRoleAssignmentsGroups", "appRoleAssignmentsUsers", "managedIdentity", "overprivilegedApps", "unknownFutureValue", "longLivedCredentials", "aadConnectDeprecated", "adalToMsalMigration", "ownerlessApps", "inactiveGuests", "aadGraphDeprecationApplication", "aadGraphDeprecationServicePrincipal", "mfaServerDeprecation"], var.recommendation_type)
    error_message = "recommendation_type must be one of the documented enum values."
  }
}

variable "release_type" {
  description = "The current release type of the recommendation. The possible values are: preview, generallyAvailable, unknownFutureValue."
  type        = string
  default     = null
}

variable "remediated_date_time" {
  description = "Microsoft Graph remediatedDateTime property."
  type        = string
  default     = null
}

variable "remediation_impact" {
  description = "Description of the impact on users of the remediation. Only applies to recommendations with category set to identitySecureScore."
  type        = string
  default     = null
}

variable "required_licenses" {
  description = "The required licenses to view the recommendation. The possible values are: notApplicable, microsoftEntraIdFree, microsoftEntraIdP1, microsoftEntraIdP2, microsoftEntraIdGovernance, microsoftEntraWorkloadId, unknownFutureValue, aatp. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: aatp."
  type        = any
  default     = null

  validation {
    condition     = var.required_licenses == null ? true : contains(["notApplicable", "microsoftEntraIdFree", "microsoftEntraIdP1", "microsoftEntraIdP2", "microsoftEntraIdGovernance", "microsoftEntraWorkloadId", "unknownFutureValue", "aatp", "microsoftEntraSuite"], var.required_licenses)
    error_message = "required_licenses must be one of the documented enum values."
  }
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["active", "completedBySystem", "completedByUser", "dismissed", "postponed", "unknownFutureValue", "riskAccepted", "thirdParty", "planned", "alternateMitigation", "needsMoreAction"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "status_modified_date_time" {
  description = "Microsoft Graph statusModifiedDateTime property."
  type        = string
  default     = null
}

variable "tags" {
  description = "Microsoft Graph tags property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.recommendationTag")
    displayName = optional(string)
  }))
  default = null
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
