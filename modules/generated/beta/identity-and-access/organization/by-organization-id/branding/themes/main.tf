# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "isDefaultTheme" = var.is_default_theme
    "localizations"  = (var.localizations == null ? null : [for item0 in var.localizations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accountResetCredentials" = item0["accountResetCredentials"], "backgroundImage" = item0["backgroundImage"], "bannerLogo" = item0["bannerLogo"], "cannotAccessYourAccount" = item0["cannotAccessYourAccount"], "contentCustomization" = item0["contentCustomization"], "customCSS" = item0["customCSS"], "favicon" = item0["favicon"], "forgotMyPassword" = item0["forgotMyPassword"], "headerBackgroundColor" = item0["headerBackgroundColor"], "headerLogo" = item0["headerLogo"], "locale" = item0["locale"], "loginPageLayoutConfiguration" = item0["loginPageLayoutConfiguration"], "pageBackgroundColor" = item0["pageBackgroundColor"], "privacyAndCookies" = item0["privacyAndCookies"], "resetItNow" = item0["resetItNow"], "signInPageText" = item0["signInPageText"], "squareLogo" = item0["squareLogo"], "squareLogoDark" = item0["squareLogoDark"], "termsOfUse" = item0["termsOfUse"], "usernameHintText" = item0["usernameHintText"] } : key1 => value1 if value1 != null }) if item0 != null])
    "name"           = var.name
    "@odata.type"    = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "organization/${urlencode(var.organization_id)}/branding/themes"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
