# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "definition"  = (var.definition == null ? null : { for key0, value0 in { "@odata.type" = var.definition["odata_type"], "createdBy" = (var.definition["createdBy"] == null ? null : { for key1, value1 in { "@odata.type" = var.definition["createdBy"]["odata_type"], "appId" = var.definition["createdBy"]["appId"], "displayName" = var.definition["createdBy"]["displayName"], "servicePrincipalId" = var.definition["createdBy"]["servicePrincipalId"], "servicePrincipalName" = var.definition["createdBy"]["servicePrincipalName"] } : key1 => value1 if value1 != null }), "displayName" = var.definition["displayName"] } : key0 => value0 if value0 != null })
    "event"       = var.event
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "print/printers/${urlencode(var.printer_id)}/taskTriggers"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
