# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "completeAfterDateTime" = var.completeAfterDateTime
    "displayName"           = var.displayName
    "exchangeSettings"      = (var.exchangeSettings == null ? null : { for key0, value0 in { "@odata.type" = var.exchangeSettings["odata_type"], "sourceEndpoint" = var.exchangeSettings["sourceEndpoint"], "targetDeliveryDomain" = var.exchangeSettings["targetDeliveryDomain"] } : key0 => value0 if value0 != null })
    "jobType"               = var.jobType
    "@odata.type"           = var.odata_type
    "resourceType"          = var.resourceType
    "resources"             = (var.resources == null ? null : [for item0 in var.resources : item0 if item0 != null])
    "sourceTenantId"        = var.sourceTenantId
    "status"                = var.status
    "users"                 = (var.users == null ? null : [for item0 in var.users : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "currentStatus" = (item0["currentStatus"] == null ? null : [for item2 in item0["currentStatus"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "errors" = (item2["errors"] == null ? null : [for item4 in item2["errors"] : item4 if item4 != null]), "message" = item2["message"], "service" = item2["service"], "status" = item2["status"] } : key3 => value3 if value3 != null }) if item2 != null]), "lastUpdatedDateTime" = item0["lastUpdatedDateTime"], "taskType" = item0["taskType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "workloads"             = (var.workloads == null ? null : [for item0 in var.workloads : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "solutions/migrations/crossTenantMigrationJobs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["users"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
