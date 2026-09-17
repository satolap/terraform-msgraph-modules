# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignedPlans"                        = (var.assigned_plans == null ? null : [for item0 in var.assigned_plans : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignedDateTime" = item0["assignedDateTime"], "capabilityStatus" = item0["capabilityStatus"], "service" = item0["service"], "servicePlanId" = item0["servicePlanId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "branding"                             = var.branding
    "businessPhones"                       = (var.business_phones == null ? null : [for item0 in var.business_phones : item0 if item0 != null])
    "certificateBasedAuthConfiguration"    = (var.certificate_based_auth_configuration == null ? null : [for item0 in var.certificate_based_auth_configuration : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "certificateAuthorities" = (item0["certificateAuthorities"] == null ? null : [for item2 in item0["certificateAuthorities"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "certificate" = item2["certificate"], "certificateRevocationListUrl" = item2["certificateRevocationListUrl"], "deltaCertificateRevocationListUrl" = item2["deltaCertificateRevocationListUrl"], "isRootAuthority" = item2["isRootAuthority"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "city"                                 = var.city
    "country"                              = var.country
    "countryLetterCode"                    = var.country_letter_code
    "defaultUsageLocation"                 = var.default_usage_location
    "deletedDateTime"                      = var.deleted_date_time
    "displayName"                          = var.display_name
    "marketingNotificationEmails"          = (var.marketing_notification_emails == null ? null : [for item0 in var.marketing_notification_emails : item0 if item0 != null])
    "mobileDeviceManagementAuthority"      = var.mobile_device_management_authority
    "@odata.type"                          = var.odata_type
    "onPremisesSyncEnabled"                = var.on_premises_sync_enabled
    "partnerTenantType"                    = var.partner_tenant_type
    "postalCode"                           = var.postal_code
    "preferredLanguage"                    = var.preferred_language
    "privacyProfile"                       = var.privacy_profile
    "provisionedPlans"                     = (var.provisioned_plans == null ? null : [for item0 in var.provisioned_plans : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "capabilityStatus" = item0["capabilityStatus"], "provisioningStatus" = item0["provisioningStatus"], "service" = item0["service"] } : key1 => value1 if value1 != null }) if item0 != null])
    "securityComplianceNotificationMails"  = (var.security_compliance_notification_mails == null ? null : [for item0 in var.security_compliance_notification_mails : item0 if item0 != null])
    "securityComplianceNotificationPhones" = (var.security_compliance_notification_phones == null ? null : [for item0 in var.security_compliance_notification_phones : item0 if item0 != null])
    "state"                                = var.state
    "street"                               = var.street
    "technicalNotificationMails"           = (var.technical_notification_mails == null ? null : [for item0 in var.technical_notification_mails : item0 if item0 != null])
    "tenantType"                           = var.tenant_type
    "verifiedDomains"                      = (var.verified_domains == null ? null : [for item0 in var.verified_domains : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "capabilities" = item0["capabilities"], "isDefault" = item0["isDefault"], "isInitial" = item0["isInitial"], "name" = item0["name"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "organization"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
