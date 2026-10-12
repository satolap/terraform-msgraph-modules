# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "currentStatus"       = (var.current_status == null ? null : [for item0 in var.current_status : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "errors" = (item0["errors"] == null ? null : [for item2 in item0["errors"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "code" = item2["code"], "message" = item2["message"] } : key3 => value3 if value3 != null }) if item2 != null]), "message" = item0["message"], "service" = item0["service"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastUpdatedDateTime" = var.last_updated_date_time
    "@odata.type"         = var.odata_type
    "taskType"            = var.task_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/migrations/crossTenantMigrationJobs/${urlencode(var.cross_tenant_migration_job_id)}/users"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
