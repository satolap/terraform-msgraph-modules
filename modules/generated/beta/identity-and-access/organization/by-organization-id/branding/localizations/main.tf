# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "backgroundColor"                   = var.background_color
    "backgroundImage"                   = var.background_image
    "bannerLogo"                        = var.banner_logo
    "contentCustomization"              = var.content_customization
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
    "loginPageLayoutConfiguration"      = var.login_page_layout_configuration
    "loginPageTextVisibilitySettings"   = var.login_page_text_visibility_settings
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
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
