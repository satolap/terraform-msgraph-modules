# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activeUserCount"          = var.active_user_count
    "averageComparativeScores" = (var.average_comparative_scores == null ? null : [for item0 in var.average_comparative_scores : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "averageScore" = item0["averageScore"], "basis" = item0["basis"] } : key1 => value1 if value1 != null }) if item0 != null])
    "azureTenantId"            = var.azure_tenant_id
    "controlScores"            = (var.control_scores == null ? null : [for item0 in var.control_scores : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "controlCategory" = item0["controlCategory"], "controlName" = item0["controlName"], "description" = item0["description"], "score" = item0["score"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"          = var.created_date_time
    "currentScore"             = var.current_score
    "enabledServices"          = (var.enabled_services == null ? null : [for item0 in var.enabled_services : item0 if item0 != null])
    "licensedUserCount"        = var.licensed_user_count
    "maxScore"                 = var.max_score
    "@odata.type"              = var.odata_type
    "vendorInformation"        = var.vendor_information
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/secureScores"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
