# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "buckets"     = (var.buckets == null ? null : [for item0 in var.buckets : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "externalBucketId" = item0["externalBucketId"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "languageTag" = var.language_tag
    "@odata.type" = var.odata_type
    "planTitle"   = var.plan_title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/businessScenarios/${urlencode(var.business_scenario_id)}/planner/planConfiguration/localizations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
