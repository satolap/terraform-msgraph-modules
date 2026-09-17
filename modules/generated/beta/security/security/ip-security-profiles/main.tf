# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activityGroupNames"  = (var.activity_group_names == null ? null : [for item0 in var.activity_group_names : item0 if item0 != null])
    "address"             = var.address
    "azureSubscriptionId" = var.azure_subscription_id
    "azureTenantId"       = var.azure_tenant_id
    "countHits"           = var.count_hits
    "countHosts"          = var.count_hosts
    "firstSeenDateTime"   = var.first_seen_date_time
    "ipCategories"        = (var.ip_categories == null ? null : [for item0 in var.ip_categories : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "name" = item0["name"], "vendor" = item0["vendor"] } : key1 => value1 if value1 != null }) if item0 != null])
    "ipReferenceData"     = (var.ip_reference_data == null ? null : [for item0 in var.ip_reference_data : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "asn" = item0["asn"], "city" = item0["city"], "countryOrRegionCode" = item0["countryOrRegionCode"], "organization" = item0["organization"], "state" = item0["state"], "vendor" = item0["vendor"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastSeenDateTime"    = var.last_seen_date_time
    "@odata.type"         = var.odata_type
    "riskScore"           = var.risk_score
    "tags"                = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "vendorInformation"   = var.vendor_information
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/ipSecurityProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
