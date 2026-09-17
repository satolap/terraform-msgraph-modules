variable "assigned_plans" {
  description = "The collection of service plans associated with the tenant. Not nullable."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.assignedPlan")
    assignedDateTime = optional(string)
    capabilityStatus = optional(string)
    service          = optional(string)
    servicePlanId    = optional(string)
  }))
  default = null
}

variable "branding" {
  description = "Resource to manage the default branding for the organization. Nullable."
  type        = any
  default     = null
}

variable "business_phones" {
  description = "Telephone number for the organization. Although this property is a string collection, only one number can be set."
  type        = list(string)
  default     = null
}

variable "certificate_based_auth_configuration" {
  description = "Navigation property to manage certificate-based authentication configuration. Only a single instance of certificateBasedAuthConfiguration can be created in the collection."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.certificateBasedAuthConfiguration")
    certificateAuthorities = optional(list(object({
      odata_type                        = optional(string, "#microsoft.graph.certificateAuthority")
      certificate                       = optional(string)
      certificateRevocationListUrl      = optional(string)
      deltaCertificateRevocationListUrl = optional(string)
      isRootAuthority                   = optional(bool)
    })))
  }))
  default = null
}

variable "certificate_connector_setting" {
  description = "Certificate connector setting."
  type        = any
  default     = null
}

variable "city" {
  description = "City name of the address for the organization."
  type        = string
  default     = null
}

variable "country" {
  description = "Country/region name of the address for the organization."
  type        = string
  default     = null
}

variable "country_letter_code" {
  description = "Country or region abbreviation for the organization in ISO 3166-2 format."
  type        = string
  default     = null
}

variable "default_usage_location" {
  description = "Two-letter ISO 3166 country code indicating the default service usage location of an organization."
  type        = string
  default     = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "directory_size_quota" {
  description = "The directory size quota information of an organization."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The display name for the tenant."
  type        = string
  default     = null
}

variable "extensions" {
  description = "The collection of open extensions defined for the organization resource. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.extension")
  }))
  default = null
}

variable "marketing_notification_emails" {
  description = "Not nullable."
  type        = list(string)
  default     = null
}

variable "mobile_device_management_authority" {
  description = "Mobile device management authority."
  type        = string
  default     = null

  validation {
    condition     = var.mobile_device_management_authority == null ? true : contains(["unknown", "intune", "sccm", "office365"], var.mobile_device_management_authority)
    error_message = "mobile_device_management_authority must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.organization"
  nullable    = false
}

variable "on_premises_last_password_sync_date_time" {
  description = "The last time a password sync request was received for the tenant."
  type        = string
  default     = null
  sensitive   = true
}

variable "on_premises_last_sync_date_time" {
  description = "The time and date at which the tenant was last synced with the on-premises directory. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "on_premises_sync_enabled" {
  description = "true if this object is synced from an on-premises directory; false if this object was originally synced from an on-premises directory but is no longer synced; Nullable. null, if this object isn't synced from on-premises active directory (default)."
  type        = bool
  default     = null
}

variable "partner_information" {
  description = "Microsoft Graph partnerInformation property."
  type        = any
  default     = null
}

variable "partner_tenant_type" {
  description = "The type of partnership this tenant has with Microsoft. The possible values are: microsoftSupport, syndicatePartner, breadthPartner, breadthPartnerDelegatedAdmin, resellerPartnerDelegatedAdmin, valueAddedResellerPartnerDelegatedAdmin, unknownFutureValue. Nullable. For more information about the possible types, see partnerTenantType values."
  type        = any
  default     = null

  validation {
    condition     = var.partner_tenant_type == null ? true : contains(["microsoftSupport", "syndicatePartner", "breadthPartner", "breadthPartnerDelegatedAdmin", "resellerPartnerDelegatedAdmin", "valueAddedResellerPartnerDelegatedAdmin", "unknownFutureValue"], var.partner_tenant_type)
    error_message = "partner_tenant_type must be one of the documented enum values."
  }
}

variable "postal_code" {
  description = "Postal code of the address for the organization."
  type        = string
  default     = null
}

variable "preferred_language" {
  description = "The preferred language for the organization. Should follow ISO 639-1 code; for example, en."
  type        = string
  default     = null
}

variable "privacy_profile" {
  description = "The privacy profile of an organization."
  type        = any
  default     = null
}

variable "provisioned_plans" {
  description = "Not nullable."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.provisionedPlan")
    capabilityStatus   = optional(string)
    provisioningStatus = optional(string)
    service            = optional(string)
  }))
  default = null
}

variable "resource_quotas" {
  description = "Microsoft Graph resourceQuotas property."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.resourceQuota")
    maxPercentage = optional(number)
    resourceType  = optional(string)
    total         = optional(number)
  }))
  default = null
}

variable "security_compliance_notification_mails" {
  description = "Not nullable."
  type        = list(string)
  default     = null
}

variable "security_compliance_notification_phones" {
  description = "Not nullable."
  type        = list(string)
  default     = null
}

variable "settings" {
  description = "Retrieve the properties and relationships of organizationSettings object. Nullable."
  type        = any
  default     = null
}

variable "state" {
  description = "State name of the address for the organization."
  type        = string
  default     = null
}

variable "street" {
  description = "Street name of the address for organization."
  type        = string
  default     = null
}

variable "technical_notification_mails" {
  description = "Not nullable."
  type        = list(string)
  default     = null
}

variable "tenant_type" {
  description = "Not nullable. Can be one of the following types:  AAD - An enterprise identity access management (IAM) service that serves business-to-employee and business-to-business (B2B) scenarios.  AAD B2C An identity access management (IAM) service that serves business-to-consumer (B2C) scenarios.   CIAM - A customer identity & access management (CIAM) solution that provides an integrated platform to serve consumers, partners, and citizen scenarios."
  type        = string
  default     = null
}

variable "verified_domains" {
  description = "The collection of domains associated with this tenant. Not nullable."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.verifiedDomain")
    capabilities = optional(string)
    isDefault    = optional(bool)
    isInitial    = optional(bool)
    name         = optional(string)
    type         = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "isMultipleDataLocationsForServicesEnabled"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
