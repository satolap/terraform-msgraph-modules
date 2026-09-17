# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "completeAfterDateTime" = var.complete_after_date_time
    "displayName"           = var.display_name
    "exchangeSettings"      = var.exchange_settings
    "jobType"               = var.job_type
    "@odata.type"           = var.odata_type
    "resourceType"          = var.resource_type
    "resources"             = (var.resources == null ? null : [for item0 in var.resources : item0 if item0 != null])
    "sourceTenantId"        = var.source_tenant_id
    "status"                = var.status
    "users"                 = (var.users == null ? null : [for item0 in var.users : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "currentStatus" = (item0["currentStatus"] == null ? null : [for item2 in item0["currentStatus"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "errors" = (item2["errors"] == null ? null : [for item4 in item2["errors"] : item4 if item4 != null]), "message" = item2["message"], "service" = item2["service"], "status" = item2["status"] } : key3 => value3 if value3 != null }) if item2 != null]), "lastUpdatedDateTime" = item0["lastUpdatedDateTime"], "taskType" = item0["taskType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "workloads"             = (var.workloads == null ? null : [for item0 in var.workloads : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/migrations/crossTenantMigrationJobs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
