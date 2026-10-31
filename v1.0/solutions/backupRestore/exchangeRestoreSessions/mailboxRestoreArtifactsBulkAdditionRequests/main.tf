# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"              = var.createdBy
    "createdDateTime"        = var.createdDateTime
    "destinationType"        = var.destinationType
    "directoryObjectIds"     = (var.directoryObjectIds == null ? null : [for item0 in var.directoryObjectIds : item0 if item0 != null])
    "displayName"            = var.displayName
    "error"                  = (var.error == null ? null : { for key0, value0 in { "@odata.type" = var.error["odata_type"], "code" = var.error["code"], "details" = (var.error["details"] == null ? null : [for item1 in var.error["details"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "code" = item1["code"], "message" = item1["message"], "target" = item1["target"] } : key2 => value2 if value2 != null }) if item1 != null]), "innerError" = (var.error["innerError"] == null ? null : { for key1, value1 in { "@odata.type" = var.error["innerError"]["odata_type"], "code" = var.error["innerError"]["code"], "details" = (var.error["innerError"]["details"] == null ? null : [for item2 in var.error["innerError"]["details"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "code" = item2["code"], "message" = item2["message"], "target" = item2["target"] } : key3 => value3 if value3 != null }) if item2 != null]), "message" = var.error["innerError"]["message"], "target" = var.error["innerError"]["target"] } : key1 => value1 if value1 != null }), "message" = var.error["message"], "target" = var.error["target"] } : key0 => value0 if value0 != null })
    "lastModifiedBy"         = var.lastModifiedBy
    "lastModifiedDateTime"   = var.lastModifiedDateTime
    "mailboxes"              = (var.mailboxes == null ? null : [for item0 in var.mailboxes : item0 if item0 != null])
    "@odata.type"            = var.odata_type
    "protectionTimePeriod"   = (var.protectionTimePeriod == null ? null : { for key0, value0 in { "@odata.type" = var.protectionTimePeriod["odata_type"], "endDateTime" = var.protectionTimePeriod["endDateTime"], "startDateTime" = var.protectionTimePeriod["startDateTime"] } : key0 => value0 if value0 != null })
    "protectionUnitIds"      = (var.protectionUnitIds == null ? null : [for item0 in var.protectionUnitIds : item0 if item0 != null])
    "restorePointPreference" = var.restorePointPreference
    "status"                 = var.status
    "tags"                   = var.tags
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/exchangeRestoreSessions/${urlencode(var.exchangeRestoreSession-id)}/mailboxRestoreArtifactsBulkAdditionRequests"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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
