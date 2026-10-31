# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                    = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "companyPortalBlockedActions"    = (var.companyPortalBlockedActions == null ? null : [for item0 in var.companyPortalBlockedActions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "action" = item0["action"], "ownerType" = item0["ownerType"], "platform" = item0["platform"] } : key1 => value1 if value1 != null }) if item0 != null])
    "contactITEmailAddress"          = var.contactITEmailAddress
    "contactITName"                  = var.contactITName
    "contactITNotes"                 = var.contactITNotes
    "contactITPhoneNumber"           = var.contactITPhoneNumber
    "createdDateTime"                = var.createdDateTime
    "customCanSeePrivacyMessage"     = var.customCanSeePrivacyMessage
    "customCantSeePrivacyMessage"    = var.customCantSeePrivacyMessage
    "customPrivacyMessage"           = var.customPrivacyMessage
    "disableClientTelemetry"         = var.disableClientTelemetry
    "disableDeviceCategorySelection" = var.disableDeviceCategorySelection
    "displayName"                    = var.displayName
    "enrollmentAvailability"         = var.enrollmentAvailability
    "isDefaultProfile"               = var.isDefaultProfile
    "isFactoryResetDisabled"         = var.isFactoryResetDisabled
    "isRemoveDeviceDisabled"         = var.isRemoveDeviceDisabled
    "landingPageCustomizedImage"     = (var.landingPageCustomizedImage == null ? null : { for key0, value0 in { "@odata.type" = var.landingPageCustomizedImage["odata_type"], "type" = var.landingPageCustomizedImage["type"], "value" = var.landingPageCustomizedImage["value"] } : key0 => value0 if value0 != null })
    "lastModifiedDateTime"           = var.lastModifiedDateTime
    "lightBackgroundLogo"            = (var.lightBackgroundLogo == null ? null : { for key0, value0 in { "@odata.type" = var.lightBackgroundLogo["odata_type"], "type" = var.lightBackgroundLogo["type"], "value" = var.lightBackgroundLogo["value"] } : key0 => value0 if value0 != null })
    "@odata.type"                    = var.odata_type
    "onlineSupportSiteName"          = var.onlineSupportSiteName
    "onlineSupportSiteUrl"           = var.onlineSupportSiteUrl
    "privacyUrl"                     = var.privacyUrl
    "profileDescription"             = var.profileDescription
    "profileName"                    = var.profileName
    "roleScopeTagIds"                = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "showAzureADEnterpriseApps"      = var.showAzureADEnterpriseApps
    "showConfigurationManagerApps"   = var.showConfigurationManagerApps
    "showDisplayNameNextToLogo"      = var.showDisplayNameNextToLogo
    "showLogo"                       = var.showLogo
    "showOfficeWebApps"              = var.showOfficeWebApps
    "themeColor"                     = (var.themeColor == null ? null : { for key0, value0 in { "@odata.type" = var.themeColor["odata_type"], "b" = var.themeColor["b"], "g" = var.themeColor["g"], "r" = var.themeColor["r"] } : key0 => value0 if value0 != null })
    "themeColorLogo"                 = (var.themeColorLogo == null ? null : { for key0, value0 in { "@odata.type" = var.themeColorLogo["odata_type"], "type" = var.themeColorLogo["type"], "value" = var.themeColorLogo["value"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/intuneBrandingProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments"], name)])]))))] } : null

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
