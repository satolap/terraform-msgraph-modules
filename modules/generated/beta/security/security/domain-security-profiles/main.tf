# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activityGroupNames"       = (var.activity_group_names == null ? null : [for item0 in var.activity_group_names : item0 if item0 != null])
    "azureSubscriptionId"      = var.azure_subscription_id
    "azureTenantId"            = var.azure_tenant_id
    "countHits"                = var.count_hits
    "countInOrg"               = var.count_in_org
    "domainCategories"         = (var.domain_categories == null ? null : [for item0 in var.domain_categories : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "name" = item0["name"], "vendor" = item0["vendor"] } : key1 => value1 if value1 != null }) if item0 != null])
    "domainRegisteredDateTime" = var.domain_registered_date_time
    "firstSeenDateTime"        = var.first_seen_date_time
    "lastSeenDateTime"         = var.last_seen_date_time
    "name"                     = var.name
    "@odata.type"              = var.odata_type
    "registrant"               = var.registrant
    "riskScore"                = var.risk_score
    "tags"                     = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "vendorInformation"        = var.vendor_information
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/domainSecurityProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
