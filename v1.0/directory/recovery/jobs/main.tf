# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"                   = var.odata_type
    "filteringCriteria"             = var.filtering_criteria
    "jobCompletionDateTime"         = var.job_completion_date_time
    "jobStartDateTime"              = var.job_start_date_time
    "status"                        = var.status
    "targetStateDateTime"           = var.target_state_date_time
    "totalChangedLinksCalculated"   = var.total_changed_links_calculated
    "totalChangedObjectsCalculated" = var.total_changed_objects_calculated
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/recovery/jobs"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
