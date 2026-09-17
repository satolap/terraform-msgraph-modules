# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "configuration"  = (var.configuration == null ? null : { for key0, value0 in { "@odata.type" = var.configuration["odata_type"], "collate" = var.configuration["collate"], "finishings" = (var.configuration["finishings"] == null ? null : [for item1 in var.configuration["finishings"] : item1 if item1 != null]), "fitPdfToPage" = var.configuration["fitPdfToPage"], "inputBin" = var.configuration["inputBin"], "margin" = var.configuration["margin"], "mediaSize" = var.configuration["mediaSize"], "mediaType" = var.configuration["mediaType"], "multipageLayout" = var.configuration["multipageLayout"], "orientation" = var.configuration["orientation"], "outputBin" = var.configuration["outputBin"], "pagesPerSheet" = var.configuration["pagesPerSheet"], "scaling" = var.configuration["scaling"] } : key0 => value0 if value0 != null })
    "createdBy"      = var.created_by
    "documents"      = (var.documents == null ? null : [for item0 in var.documents : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isFetchable"    = var.is_fetchable
    "@odata.type"    = var.odata_type
    "redirectedFrom" = var.redirected_from
    "redirectedTo"   = var.redirected_to
    "status"         = (var.status == null ? null : { for key0, value0 in { "@odata.type" = var.status["odata_type"], "state" = var.status["state"] } : key0 => value0 if value0 != null })
    "tasks"          = (var.tasks == null ? null : [for item0 in var.tasks : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "definition" = (item0["definition"] == null ? null : { for key2, value2 in { "@odata.type" = item0["definition"]["odata_type"], "createdBy" = (item0["definition"]["createdBy"] == null ? null : { for key3, value3 in { "@odata.type" = item0["definition"]["createdBy"]["odata_type"], "appId" = item0["definition"]["createdBy"]["appId"], "displayName" = item0["definition"]["createdBy"]["displayName"], "servicePrincipalId" = item0["definition"]["createdBy"]["servicePrincipalId"], "servicePrincipalName" = item0["definition"]["createdBy"]["servicePrincipalName"] } : key3 => value3 if value3 != null }), "displayName" = item0["definition"]["displayName"] } : key2 => value2 if value2 != null }), "status" = (item0["status"] == null ? null : { for key2, value2 in { "@odata.type" = item0["status"]["odata_type"], "description" = item0["status"]["description"], "state" = item0["status"]["state"] } : key2 => value2 if value2 != null }), "trigger" = (item0["trigger"] == null ? null : { for key2, value2 in { "@odata.type" = item0["trigger"]["odata_type"], "definition" = (item0["trigger"]["definition"] == null ? null : { for key3, value3 in { "@odata.type" = item0["trigger"]["definition"]["odata_type"], "createdBy" = (item0["trigger"]["definition"]["createdBy"] == null ? null : { for key4, value4 in { "@odata.type" = item0["trigger"]["definition"]["createdBy"]["odata_type"], "appId" = item0["trigger"]["definition"]["createdBy"]["appId"], "displayName" = item0["trigger"]["definition"]["createdBy"]["displayName"], "servicePrincipalId" = item0["trigger"]["definition"]["createdBy"]["servicePrincipalId"], "servicePrincipalName" = item0["trigger"]["definition"]["createdBy"]["servicePrincipalName"] } : key4 => value4 if value4 != null }), "displayName" = item0["trigger"]["definition"]["displayName"] } : key3 => value3 if value3 != null }), "event" = item0["trigger"]["event"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "print/printers/${urlencode(var.printer_id)}/jobs"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
