# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                            = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "azureRightsManagementServicesAllowed"   = var.azure_rights_management_services_allowed
    "createdDateTime"                        = var.created_date_time
    "dataRecoveryCertificate"                = var.data_recovery_certificate
    "description"                            = var.description
    "displayName"                            = var.display_name
    "enforcementLevel"                       = var.enforcement_level
    "enterpriseDomain"                       = var.enterprise_domain
    "enterpriseInternalProxyServers"         = (var.enterprise_internal_proxy_servers == null ? null : [for item0 in var.enterprise_internal_proxy_servers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseIPRanges"                     = (var.enterprise_ip_ranges == null ? null : [for item0 in var.enterprise_ip_ranges : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "ranges" = (item0["ranges"] == null ? null : [for item2 in item0["ranges"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseIPRangesAreAuthoritative"     = var.enterprise_ip_ranges_are_authoritative
    "enterpriseNetworkDomainNames"           = (var.enterprise_network_domain_names == null ? null : [for item0 in var.enterprise_network_domain_names : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseProtectedDomainNames"         = (var.enterprise_protected_domain_names == null ? null : [for item0 in var.enterprise_protected_domain_names : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseProxiedDomains"               = (var.enterprise_proxied_domains == null ? null : [for item0 in var.enterprise_proxied_domains : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "proxiedDomains" = (item0["proxiedDomains"] == null ? null : [for item2 in item0["proxiedDomains"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "ipAddressOrFQDN" = item2["ipAddressOrFQDN"], "proxy" = item2["proxy"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseProxyServers"                 = (var.enterprise_proxy_servers == null ? null : [for item0 in var.enterprise_proxy_servers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "enterpriseProxyServersAreAuthoritative" = var.enterprise_proxy_servers_are_authoritative
    "exemptAppLockerFiles"                   = (var.exempt_app_locker_files == null ? null : [for item0 in var.exempt_app_locker_files : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "file" = item0["file"], "fileHash" = item0["fileHash"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "exemptApps"                             = (var.exempt_apps == null ? null : [for item0 in var.exempt_apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "denied" = item0["denied"], "description" = item0["description"], "displayName" = item0["displayName"], "productName" = item0["productName"], "publisherName" = item0["publisherName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "version"                                = var.graph_version
    "iconsVisible"                           = var.icons_visible
    "indexingEncryptedStoresOrItemsBlocked"  = var.indexing_encrypted_stores_or_items_blocked
    "isAssigned"                             = var.is_assigned
    "lastModifiedDateTime"                   = var.last_modified_date_time
    "neutralDomainResources"                 = (var.neutral_domain_resources == null ? null : [for item0 in var.neutral_domain_resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                            = var.odata_type
    "protectedAppLockerFiles"                = (var.protected_app_locker_files == null ? null : [for item0 in var.protected_app_locker_files : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "file" = item0["file"], "fileHash" = item0["fileHash"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "protectedApps"                          = (var.protected_apps == null ? null : [for item0 in var.protected_apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "denied" = item0["denied"], "description" = item0["description"], "displayName" = item0["displayName"], "productName" = item0["productName"], "publisherName" = item0["publisherName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "protectionUnderLockConfigRequired"      = var.protection_under_lock_config_required
    "revokeOnUnenrollDisabled"               = var.revoke_on_unenroll_disabled
    "rightsManagementServicesTemplateId"     = var.rights_management_services_template_id
    "smbAutoEncryptedFileExtensions"         = (var.smb_auto_encrypted_file_extensions == null ? null : [for item0 in var.smb_auto_encrypted_file_extensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "resources" = (item0["resources"] == null ? null : [for item2 in item0["resources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/mdmWindowsInformationProtectionPolicies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
