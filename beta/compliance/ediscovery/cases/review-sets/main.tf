# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName" = var.display_name
    "@odata.type" = var.odata_type
    "queries"     = (var.queries == null ? null : [for item0 in var.queries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "query" = item0["query"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "compliance/ediscovery/cases/${urlencode(var.case_id)}/reviewSets"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
