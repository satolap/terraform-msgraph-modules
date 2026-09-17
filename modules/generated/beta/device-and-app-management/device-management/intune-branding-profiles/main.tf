# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                    = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "companyPortalBlockedActions"    = (var.company_portal_blocked_actions == null ? null : [for item0 in var.company_portal_blocked_actions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "action" = item0["action"], "ownerType" = item0["ownerType"], "platform" = item0["platform"] } : key1 => value1 if value1 != null }) if item0 != null])
    "contactITEmailAddress"          = var.contact_it_email_address
    "contactITName"                  = var.contact_it_name
    "contactITNotes"                 = var.contact_it_notes
    "contactITPhoneNumber"           = var.contact_it_phone_number
    "createdDateTime"                = var.created_date_time
    "customCanSeePrivacyMessage"     = var.custom_can_see_privacy_message
    "customCantSeePrivacyMessage"    = var.custom_cant_see_privacy_message
    "customPrivacyMessage"           = var.custom_privacy_message
    "disableClientTelemetry"         = var.disable_client_telemetry
    "disableDeviceCategorySelection" = var.disable_device_category_selection
    "displayName"                    = var.display_name
    "enrollmentAvailability"         = var.enrollment_availability
    "isDefaultProfile"               = var.is_default_profile
    "isFactoryResetDisabled"         = var.is_factory_reset_disabled
    "isRemoveDeviceDisabled"         = var.is_remove_device_disabled
    "landingPageCustomizedImage"     = var.landing_page_customized_image
    "lastModifiedDateTime"           = var.last_modified_date_time
    "lightBackgroundLogo"            = var.light_background_logo
    "@odata.type"                    = var.odata_type
    "onlineSupportSiteName"          = var.online_support_site_name
    "onlineSupportSiteUrl"           = var.online_support_site_url
    "privacyUrl"                     = var.privacy_url
    "profileDescription"             = var.profile_description
    "profileName"                    = var.profile_name
    "roleScopeTagIds"                = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "showAzureADEnterpriseApps"      = var.show_azure_ad_enterprise_apps
    "showConfigurationManagerApps"   = var.show_configuration_manager_apps
    "showDisplayNameNextToLogo"      = var.show_display_name_next_to_logo
    "showLogo"                       = var.show_logo
    "showOfficeWebApps"              = var.show_office_web_apps
    "themeColor"                     = var.theme_color
    "themeColorLogo"                 = var.theme_color_logo
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/intuneBrandingProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
