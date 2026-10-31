# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "backgroundColor"                   = var.backgroundColor
    "backgroundImage"                   = var.backgroundImage
    "bannerLogo"                        = var.bannerLogo
    "contentCustomization"              = (var.contentCustomization == null ? null : { for key0, value0 in { "@odata.type" = var.contentCustomization["odata_type"], "attributeCollection" = (var.contentCustomization["attributeCollection"] == null ? null : [for item1 in var.contentCustomization["attributeCollection"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "key" = item1["key"], "value" = item1["value"] } : key2 => value2 if value2 != null }) if item1 != null]), "attributeCollectionRelativeUrl" = var.contentCustomization["attributeCollectionRelativeUrl"], "registrationCampaign" = (var.contentCustomization["registrationCampaign"] == null ? null : [for item1 in var.contentCustomization["registrationCampaign"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "key" = item1["key"], "value" = item1["value"] } : key2 => value2 if value2 != null }) if item1 != null]), "registrationCampaignRelativeUrl" = var.contentCustomization["registrationCampaignRelativeUrl"] } : key0 => value0 if value0 != null })
    "customAccountResetCredentialsUrl"  = var.customAccountResetCredentialsUrl
    "customCSS"                         = var.customCSS
    "customCannotAccessYourAccountText" = var.customCannotAccessYourAccountText
    "customCannotAccessYourAccountUrl"  = var.customCannotAccessYourAccountUrl
    "customForgotMyPasswordText"        = var.customForgotMyPasswordText
    "customPrivacyAndCookiesText"       = var.customPrivacyAndCookiesText
    "customPrivacyAndCookiesUrl"        = var.customPrivacyAndCookiesUrl
    "customResetItNowText"              = var.customResetItNowText
    "customTermsOfUseText"              = var.customTermsOfUseText
    "customTermsOfUseUrl"               = var.customTermsOfUseUrl
    "favicon"                           = var.favicon
    "headerBackgroundColor"             = var.headerBackgroundColor
    "headerLogo"                        = var.headerLogo
    "loginPageLayoutConfiguration"      = (var.loginPageLayoutConfiguration == null ? null : { for key0, value0 in { "@odata.type" = var.loginPageLayoutConfiguration["odata_type"], "isFooterShown" = var.loginPageLayoutConfiguration["isFooterShown"], "isHeaderShown" = var.loginPageLayoutConfiguration["isHeaderShown"], "layoutTemplateType" = var.loginPageLayoutConfiguration["layoutTemplateType"] } : key0 => value0 if value0 != null })
    "loginPageTextVisibilitySettings"   = (var.loginPageTextVisibilitySettings == null ? null : { for key0, value0 in { "@odata.type" = var.loginPageTextVisibilitySettings["odata_type"], "hideAccountResetCredentials" = var.loginPageTextVisibilitySettings["hideAccountResetCredentials"], "hideCannotAccessYourAccount" = var.loginPageTextVisibilitySettings["hideCannotAccessYourAccount"], "hideForgotMyPassword" = var.loginPageTextVisibilitySettings["hideForgotMyPassword"], "hidePrivacyAndCookies" = var.loginPageTextVisibilitySettings["hidePrivacyAndCookies"], "hideResetItNow" = var.loginPageTextVisibilitySettings["hideResetItNow"], "hideTermsOfUse" = var.loginPageTextVisibilitySettings["hideTermsOfUse"] } : key0 => value0 if value0 != null })
    "@odata.type"                       = var.odata_type
    "signInPageText"                    = var.signInPageText
    "squareLogo"                        = var.squareLogo
    "squareLogoDark"                    = var.squareLogoDark
    "usernameHintText"                  = var.usernameHintText
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "organization/${urlencode(var.organization-id)}/branding/localizations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
