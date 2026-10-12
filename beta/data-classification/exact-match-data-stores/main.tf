# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "columns"                 = (var.columns == null ? null : [for item0 in var.columns : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "ignoredDelimiters" = (item0["ignoredDelimiters"] == null ? null : [for item2 in item0["ignoredDelimiters"] : item2 if item2 != null]), "isCaseInsensitive" = item0["isCaseInsensitive"], "isSearchable" = item0["isSearchable"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "dataLastUpdatedDateTime" = var.data_last_updated_date_time
    "description"             = var.description
    "displayName"             = var.display_name
    "@odata.type"             = var.odata_type
    "sessions"                = (var.sessions == null ? null : [for item0 in var.sessions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "checksum" = item0["checksum"], "completionDateTime" = item0["completionDateTime"], "creationDateTime" = item0["creationDateTime"], "dataStoreId" = item0["dataStoreId"], "dataUploadURI" = item0["dataUploadURI"], "error" = item0["error"], "fields" = (item0["fields"] == null ? null : [for item2 in item0["fields"] : item2 if item2 != null]), "fileName" = item0["fileName"], "lastUpdatedDateTime" = item0["lastUpdatedDateTime"], "processingCompletionDateTime" = item0["processingCompletionDateTime"], "remainingBlockCount" = item0["remainingBlockCount"], "remainingJobCount" = item0["remainingJobCount"], "rowsPerBlock" = item0["rowsPerBlock"], "salt" = item0["salt"], "startDateTime" = item0["startDateTime"], "state" = item0["state"], "totalBlockCount" = item0["totalBlockCount"], "totalJobCount" = item0["totalJobCount"], "uploadAgent" = item0["uploadAgent"], "uploadAgentId" = item0["uploadAgentId"], "uploadCompletionDateTime" = item0["uploadCompletionDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "dataClassification/exactMatchDataStores"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
