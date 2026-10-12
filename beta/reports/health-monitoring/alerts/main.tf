# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alertType"       = var.alert_type
    "category"        = var.category
    "createdDateTime" = var.created_date_time
    "documentation"   = var.documentation
    "enrichment"      = (var.enrichment == null ? null : { for key0, value0 in { "@odata.type" = var.enrichment["odata_type"], "impacts" = (var.enrichment["impacts"] == null ? null : [for item1 in var.enrichment["impacts"] : item1 if item1 != null]), "state" = var.enrichment["state"], "supportingData" = var.enrichment["supportingData"] } : key0 => value0 if value0 != null })
    "@odata.type"     = var.odata_type
    "scenario"        = var.scenario
    "signals"         = var.signals
    "state"           = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "reports/healthMonitoring/alerts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
