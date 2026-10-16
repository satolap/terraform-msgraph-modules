# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "configurationEndpointUrl"                            = var.configuration_endpoint_url
    "description"                                         = var.description
    "displayName"                                         = var.display_name
    "enableAuthenticationViaCompanyPortal"                = var.enable_authentication_via_company_portal
    "@odata.type"                                         = var.odata_type
    "requireCompanyPortalOnSetupAssistantEnrolledDevices" = var.require_company_portal_on_setup_assistant_enrolled_devices
    "requiresUserAuthentication"                          = var.requires_user_authentication
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/depOnboardingSettings/${urlencode(var.dep_onboarding_setting_id)}/enrollmentProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
