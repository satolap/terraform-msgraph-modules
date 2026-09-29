# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "backgroundColor"                   = var.background_color
    "backgroundImage"                   = var.background_image
    "bannerLogo"                        = var.banner_logo
    "contentCustomization"              = (var.content_customization == null ? null : { for key0, value0 in { "@odata.type" = var.content_customization["odata_type"], "attributeCollection" = (var.content_customization["attributeCollection"] == null ? null : [for item1 in var.content_customization["attributeCollection"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "key" = item1["key"], "value" = item1["value"] } : key2 => value2 if value2 != null }) if item1 != null]), "attributeCollectionRelativeUrl" = var.content_customization["attributeCollectionRelativeUrl"], "registrationCampaign" = (var.content_customization["registrationCampaign"] == null ? null : [for item1 in var.content_customization["registrationCampaign"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "key" = item1["key"], "value" = item1["value"] } : key2 => value2 if value2 != null }) if item1 != null]), "registrationCampaignRelativeUrl" = var.content_customization["registrationCampaignRelativeUrl"] } : key0 => value0 if value0 != null })
    "customAccountResetCredentialsUrl"  = var.custom_account_reset_credentials_url
    "customCannotAccessYourAccountText" = var.custom_cannot_access_your_account_text
    "customCannotAccessYourAccountUrl"  = var.custom_cannot_access_your_account_url
    "customCSS"                         = var.custom_css
    "customForgotMyPasswordText"        = var.custom_forgot_my_password_text
    "customPrivacyAndCookiesText"       = var.custom_privacy_and_cookies_text
    "customPrivacyAndCookiesUrl"        = var.custom_privacy_and_cookies_url
    "customResetItNowText"              = var.custom_reset_it_now_text
    "customTermsOfUseText"              = var.custom_terms_of_use_text
    "customTermsOfUseUrl"               = var.custom_terms_of_use_url
    "favicon"                           = var.favicon
    "headerBackgroundColor"             = var.header_background_color
    "headerLogo"                        = var.header_logo
    "loginPageLayoutConfiguration"      = (var.login_page_layout_configuration == null ? null : { for key0, value0 in { "@odata.type" = var.login_page_layout_configuration["odata_type"], "isFooterShown" = var.login_page_layout_configuration["isFooterShown"], "isHeaderShown" = var.login_page_layout_configuration["isHeaderShown"], "layoutTemplateType" = var.login_page_layout_configuration["layoutTemplateType"] } : key0 => value0 if value0 != null })
    "loginPageTextVisibilitySettings"   = (var.login_page_text_visibility_settings == null ? null : { for key0, value0 in { "@odata.type" = var.login_page_text_visibility_settings["odata_type"], "hideAccountResetCredentials" = var.login_page_text_visibility_settings["hideAccountResetCredentials"], "hideCannotAccessYourAccount" = var.login_page_text_visibility_settings["hideCannotAccessYourAccount"], "hideForgotMyPassword" = var.login_page_text_visibility_settings["hideForgotMyPassword"], "hidePrivacyAndCookies" = var.login_page_text_visibility_settings["hidePrivacyAndCookies"], "hideResetItNow" = var.login_page_text_visibility_settings["hideResetItNow"], "hideTermsOfUse" = var.login_page_text_visibility_settings["hideTermsOfUse"] } : key0 => value0 if value0 != null })
    "@odata.type"                       = var.odata_type
    "signInPageText"                    = var.sign_in_page_text
    "squareLogo"                        = var.square_logo
    "squareLogoDark"                    = var.square_logo_dark
    "usernameHintText"                  = var.username_hint_text
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "organization/${urlencode(var.organization_id)}/branding/localizations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
