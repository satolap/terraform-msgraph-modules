# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                            = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "azureRightsManagementServicesAllowed"   = var.azureRightsManagementServicesAllowed
    "createdDateTime"                        = var.createdDateTime
    "dataRecoveryCertificate"                = (var.dataRecoveryCertificate == null ? null : { for key0, value0 in { "@odata.type" = var.dataRecoveryCertificate["odata_type"], "certificate" = var.dataRecoveryCertificate["certificate"], "description" = var.dataRecoveryCertificate["description"], "expirationDateTime" = var.dataRecoveryCertificate["expirationDateTime"], "subjectName" = var.dataRecoveryCertificate["subjectName"] } : key0 => value0 if value0 != null })
    "daysWithoutContactBeforeUnenroll"       = var.daysWithoutContactBeforeUnenroll
    "description"                            = var.description
    "displayName"                            = var.displayName
    "enforcementLevel"                       = var.enforcementLevel
    "enterpriseDomain"                       = var.enterpriseDomain
    "enterpriseIPRanges"                     = (var.enterpriseIPRanges == null ? null : [for item0 in var.enterpriseIPRanges : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "ranges" = (item0["ranges"] == null ? null : [for item2 in item0["ranges"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseIPRangesAreAuthoritative"     = var.enterpriseIPRangesAreAuthoritative
    "enterpriseInternalProxyServers"         = (var.enterpriseInternalProxyServers == null ? null : [for item0 in var.enterpriseInternalProxyServers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseNetworkDomainNames"           = (var.enterpriseNetworkDomainNames == null ? null : [for item0 in var.enterpriseNetworkDomainNames : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseProtectedDomainNames"         = (var.enterpriseProtectedDomainNames == null ? null : [for item0 in var.enterpriseProtectedDomainNames : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseProxiedDomains"               = (var.enterpriseProxiedDomains == null ? null : [for item0 in var.enterpriseProxiedDomains : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "proxiedDomains" = (item0["proxiedDomains"] == null ? null : [for item2 in item0["proxiedDomains"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "ipAddressOrFQDN" = item2["ipAddressOrFQDN"], "proxy" = item2["proxy"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseProxyServers"                 = (var.enterpriseProxyServers == null ? null : [for item0 in var.enterpriseProxyServers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseProxyServersAreAuthoritative" = var.enterpriseProxyServersAreAuthoritative
    "exemptAppLockerFiles"                   = (var.exemptAppLockerFiles == null ? null : [for item0 in var.exemptAppLockerFiles : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "file" = item0["file"], "fileHash" = item0["fileHash"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "exemptApps"                             = (var.exemptApps == null ? null : [for item0 in var.exemptApps : item0 if item0 != null])
    "version"                                = var.graph_version
    "iconsVisible"                           = var.iconsVisible
    "indexingEncryptedStoresOrItemsBlocked"  = var.indexingEncryptedStoresOrItemsBlocked
    "isAssigned"                             = var.isAssigned
    "lastModifiedDateTime"                   = var.lastModifiedDateTime
    "mdmEnrollmentUrl"                       = var.mdmEnrollmentUrl
    "minutesOfInactivityBeforeDeviceLock"    = var.minutesOfInactivityBeforeDeviceLock
    "neutralDomainResources"                 = (var.neutralDomainResources == null ? null : [for item0 in var.neutralDomainResources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "numberOfPastPinsRemembered"             = var.numberOfPastPinsRemembered
    "@odata.type"                            = var.odata_type
    "passwordMaximumAttemptCount"            = var.passwordMaximumAttemptCount
    "pinExpirationDays"                      = var.pinExpirationDays
    "pinLowercaseLetters"                    = var.pinLowercaseLetters
    "pinMinimumLength"                       = var.pinMinimumLength
    "pinSpecialCharacters"                   = var.pinSpecialCharacters
    "pinUppercaseLetters"                    = var.pinUppercaseLetters
    "protectedAppLockerFiles"                = (var.protectedAppLockerFiles == null ? null : [for item0 in var.protectedAppLockerFiles : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "file" = item0["file"], "fileHash" = item0["fileHash"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "protectedApps"                          = (var.protectedApps == null ? null : [for item0 in var.protectedApps : item0 if item0 != null])
    "protectionUnderLockConfigRequired"      = var.protectionUnderLockConfigRequired
    "revokeOnMdmHandoffDisabled"             = var.revokeOnMdmHandoffDisabled
    "revokeOnUnenrollDisabled"               = var.revokeOnUnenrollDisabled
    "rightsManagementServicesTemplateId"     = var.rightsManagementServicesTemplateId
    "smbAutoEncryptedFileExtensions"         = (var.smbAutoEncryptedFileExtensions == null ? null : [for item0 in var.smbAutoEncryptedFileExtensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "windowsHelloForBusinessBlocked"         = var.windowsHelloForBusinessBlocked
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/windowsInformationProtectionPolicies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "exemptAppLockerFiles", "protectedAppLockerFiles"], name)])]))))] } : null

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
