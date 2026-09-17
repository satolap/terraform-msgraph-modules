# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "aliases"                    = (var.aliases == null ? null : [for item0 in var.aliases : item0 if item0 != null])
    "countriesOrRegionsOfOrigin" = (var.countries_or_regions_of_origin == null ? null : [for item0 in var.countries_or_regions_of_origin : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "code" = item0["code"], "label" = item0["label"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                = (var.description == null ? null : { for key0, value0 in { "@odata.type" = var.description["odata_type"], "content" = var.description["content"], "format" = var.description["format"] } : key0 => value0 if value0 != null })
    "firstActiveDateTime"        = var.first_active_date_time
    "indicators"                 = (var.indicators == null ? null : [for item0 in var.indicators : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "artifact" = (item0["artifact"] == null ? null : { for key2, value2 in { "@odata.type" = item0["artifact"]["odata_type"] } : key2 => value2 if value2 != null }), "firstSeenDateTime" = item0["firstSeenDateTime"], "lastSeenDateTime" = item0["lastSeenDateTime"], "source" = item0["source"] } : key1 => value1 if value1 != null }) if item0 != null])
    "kind"                       = var.kind
    "@odata.type"                = var.odata_type
    "summary"                    = (var.summary == null ? null : { for key0, value0 in { "@odata.type" = var.summary["odata_type"], "content" = var.summary["content"], "format" = var.summary["format"] } : key0 => value0 if value0 != null })
    "targets"                    = (var.targets == null ? null : [for item0 in var.targets : item0 if item0 != null])
    "title"                      = var.title
    "tradecraft"                 = var.tradecraft
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/threatIntelligence/intelProfiles"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
