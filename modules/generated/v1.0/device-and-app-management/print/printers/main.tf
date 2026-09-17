# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "capabilities"    = var.capabilities
    "connectors"      = (var.connectors == null ? null : [for item0 in var.connectors : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appVersion" = item0["appVersion"], "displayName" = item0["displayName"], "fullyQualifiedDomainName" = item0["fullyQualifiedDomainName"], "location" = item0["location"], "operatingSystem" = item0["operatingSystem"], "registeredDateTime" = item0["registeredDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "defaults"        = var.defaults
    "displayName"     = var.display_name
    "isAcceptingJobs" = var.is_accepting_jobs
    "jobs"            = (var.jobs == null ? null : [for item0 in var.jobs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "configuration" = (item0["configuration"] == null ? null : { for key2, value2 in { "@odata.type" = item0["configuration"]["odata_type"], "collate" = item0["configuration"]["collate"], "finishings" = (item0["configuration"]["finishings"] == null ? null : [for item3 in item0["configuration"]["finishings"] : item3 if item3 != null]), "fitPdfToPage" = item0["configuration"]["fitPdfToPage"], "inputBin" = item0["configuration"]["inputBin"], "margin" = item0["configuration"]["margin"], "mediaSize" = item0["configuration"]["mediaSize"], "mediaType" = item0["configuration"]["mediaType"], "multipageLayout" = item0["configuration"]["multipageLayout"], "orientation" = item0["configuration"]["orientation"], "outputBin" = item0["configuration"]["outputBin"], "pagesPerSheet" = item0["configuration"]["pagesPerSheet"], "scaling" = item0["configuration"]["scaling"] } : key2 => value2 if value2 != null }), "createdBy" = item0["createdBy"], "documents" = (item0["documents"] == null ? null : [for item2 in item0["documents"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"] } : key3 => value3 if value3 != null }) if item2 != null]), "isFetchable" = item0["isFetchable"], "redirectedFrom" = item0["redirectedFrom"], "redirectedTo" = item0["redirectedTo"], "status" = (item0["status"] == null ? null : { for key2, value2 in { "@odata.type" = item0["status"]["odata_type"], "state" = item0["status"]["state"] } : key2 => value2 if value2 != null }), "tasks" = (item0["tasks"] == null ? null : [for item2 in item0["tasks"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "definition" = (item2["definition"] == null ? null : { for key4, value4 in { "@odata.type" = item2["definition"]["odata_type"], "createdBy" = item2["definition"]["createdBy"], "displayName" = item2["definition"]["displayName"] } : key4 => value4 if value4 != null }), "status" = (item2["status"] == null ? null : { for key4, value4 in { "@odata.type" = item2["status"]["odata_type"], "description" = item2["status"]["description"], "state" = item2["status"]["state"] } : key4 => value4 if value4 != null }), "trigger" = (item2["trigger"] == null ? null : { for key4, value4 in { "@odata.type" = item2["trigger"]["odata_type"], "definition" = item2["trigger"]["definition"], "event" = item2["trigger"]["event"] } : key4 => value4 if value4 != null }) } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "location"        = var.location
    "manufacturer"    = var.manufacturer
    "model"           = var.model
    "@odata.type"     = var.odata_type
    "status"          = (var.status == null ? null : { for key0, value0 in { "@odata.type" = var.status["odata_type"], "state" = var.status["state"] } : key0 => value0 if value0 != null })
    "taskTriggers"    = (var.task_triggers == null ? null : [for item0 in var.task_triggers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "definition" = (item0["definition"] == null ? null : { for key2, value2 in { "@odata.type" = item0["definition"]["odata_type"], "createdBy" = (item0["definition"]["createdBy"] == null ? null : { for key3, value3 in { "@odata.type" = item0["definition"]["createdBy"]["odata_type"], "appId" = item0["definition"]["createdBy"]["appId"], "displayName" = item0["definition"]["createdBy"]["displayName"], "servicePrincipalId" = item0["definition"]["createdBy"]["servicePrincipalId"], "servicePrincipalName" = item0["definition"]["createdBy"]["servicePrincipalName"] } : key3 => value3 if value3 != null }), "displayName" = item0["definition"]["displayName"] } : key2 => value2 if value2 != null }), "event" = item0["event"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "print/printers"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
