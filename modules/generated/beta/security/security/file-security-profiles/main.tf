# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activityGroupNames"    = (var.activity_group_names == null ? null : [for item0 in var.activity_group_names : item0 if item0 != null])
    "azureSubscriptionId"   = var.azure_subscription_id
    "azureTenantId"         = var.azure_tenant_id
    "certificateThumbprint" = var.certificate_thumbprint
    "extensions"            = (var.extensions == null ? null : [for item0 in var.extensions : item0 if item0 != null])
    "fileType"              = var.file_type
    "firstSeenDateTime"     = var.first_seen_date_time
    "hashes"                = (var.hashes == null ? null : [for item0 in var.hashes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "hashType" = item0["hashType"], "hashValue" = item0["hashValue"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastSeenDateTime"      = var.last_seen_date_time
    "malwareStates"         = (var.malware_states == null ? null : [for item0 in var.malware_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "category" = item0["category"], "family" = item0["family"], "name" = item0["name"], "severity" = item0["severity"], "wasRunning" = item0["wasRunning"] } : key1 => value1 if value1 != null }) if item0 != null])
    "names"                 = (var.names == null ? null : [for item0 in var.names : item0 if item0 != null])
    "@odata.type"           = var.odata_type
    "riskScore"             = var.risk_score
    "size"                  = var.size
    "tags"                  = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "vendorInformation"     = var.vendor_information
    "vulnerabilityStates"   = (var.vulnerability_states == null ? null : [for item0 in var.vulnerability_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "cve" = item0["cve"], "severity" = item0["severity"], "wasRunning" = item0["wasRunning"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/fileSecurityProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
