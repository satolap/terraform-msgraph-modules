# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "definition"  = (var.definition == null ? null : { for key0, value0 in { "@odata.type" = var.definition["odata_type"], "createdBy" = (var.definition["createdBy"] == null ? null : { for key1, value1 in { "@odata.type" = var.definition["createdBy"]["odata_type"], "appId" = var.definition["createdBy"]["appId"], "displayName" = var.definition["createdBy"]["displayName"], "servicePrincipalId" = var.definition["createdBy"]["servicePrincipalId"], "servicePrincipalName" = var.definition["createdBy"]["servicePrincipalName"] } : key1 => value1 if value1 != null }), "displayName" = var.definition["displayName"] } : key0 => value0 if value0 != null })
    "@odata.type" = var.odata_type
    "status"      = (var.status == null ? null : { for key0, value0 in { "@odata.type" = var.status["odata_type"], "description" = var.status["description"], "state" = var.status["state"] } : key0 => value0 if value0 != null })
    "trigger"     = (var.trigger == null ? null : { for key0, value0 in { "@odata.type" = var.trigger["odata_type"], "definition" = (var.trigger["definition"] == null ? null : { for key1, value1 in { "@odata.type" = var.trigger["definition"]["odata_type"], "createdBy" = (var.trigger["definition"]["createdBy"] == null ? null : { for key2, value2 in { "@odata.type" = var.trigger["definition"]["createdBy"]["odata_type"], "appId" = var.trigger["definition"]["createdBy"]["appId"], "displayName" = var.trigger["definition"]["createdBy"]["displayName"], "servicePrincipalId" = var.trigger["definition"]["createdBy"]["servicePrincipalId"], "servicePrincipalName" = var.trigger["definition"]["createdBy"]["servicePrincipalName"] } : key2 => value2 if value2 != null }), "displayName" = var.trigger["definition"]["displayName"] } : key1 => value1 if value1 != null }), "event" = var.trigger["event"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "print/shares/${urlencode(var.printer_share_id)}/jobs/${urlencode(var.print_job_id)}/tasks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
