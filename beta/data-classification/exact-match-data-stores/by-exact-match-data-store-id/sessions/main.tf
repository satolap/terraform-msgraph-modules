# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "checksum"                     = var.checksum
    "completionDateTime"           = var.completion_date_time
    "creationDateTime"             = var.creation_date_time
    "dataStoreId"                  = var.data_store_id
    "dataUploadURI"                = var.data_upload_uri
    "error"                        = var.error
    "fields"                       = (var.fields == null ? null : [for item0 in var.fields : item0 if item0 != null])
    "fileName"                     = var.file_name
    "lastUpdatedDateTime"          = var.last_updated_date_time
    "@odata.type"                  = var.odata_type
    "processingCompletionDateTime" = var.processing_completion_date_time
    "remainingBlockCount"          = var.remaining_block_count
    "remainingJobCount"            = var.remaining_job_count
    "rowsPerBlock"                 = var.rows_per_block
    "salt"                         = var.salt
    "startDateTime"                = var.start_date_time
    "state"                        = var.state
    "totalBlockCount"              = var.total_block_count
    "totalJobCount"                = var.total_job_count
    "uploadAgent"                  = var.upload_agent
    "uploadAgentId"                = var.upload_agent_id
    "uploadCompletionDateTime"     = var.upload_completion_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "dataClassification/exactMatchDataStores/${urlencode(var.exact_match_data_store_id)}/sessions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
