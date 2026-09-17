# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "azureSubscriptionId"       = var.azure_subscription_id
    "azureTenantId"             = var.azure_tenant_id
    "firstSeenDateTime"         = var.first_seen_date_time
    "fqdn"                      = var.fqdn
    "isAzureAdJoined"           = var.is_azure_ad_joined
    "isAzureAdRegistered"       = var.is_azure_ad_registered
    "isHybridAzureDomainJoined" = var.is_hybrid_azure_domain_joined
    "lastSeenDateTime"          = var.last_seen_date_time
    "logonUsers"                = (var.logon_users == null ? null : [for item0 in var.logon_users : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accountDomain" = item0["accountDomain"], "accountName" = item0["accountName"], "accountType" = item0["accountType"], "firstSeenDateTime" = item0["firstSeenDateTime"], "lastSeenDateTime" = item0["lastSeenDateTime"], "logonId" = item0["logonId"], "logonTypes" = (item0["logonTypes"] == null ? null : [for item2 in item0["logonTypes"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "netBiosName"               = var.net_bios_name
    "networkInterfaces"         = (var.network_interfaces == null ? null : [for item0 in var.network_interfaces : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "ipV4Address" = item0["ipV4Address"], "ipV6Address" = item0["ipV6Address"], "localIpV6Address" = item0["localIpV6Address"], "macAddress" = item0["macAddress"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"               = var.odata_type
    "os"                        = var.os
    "osVersion"                 = var.os_version
    "parentHost"                = var.parent_host
    "relatedHostIds"            = (var.related_host_ids == null ? null : [for item0 in var.related_host_ids : item0 if item0 != null])
    "riskScore"                 = var.risk_score
    "tags"                      = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "vendorInformation"         = var.vendor_information
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/hostSecurityProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
