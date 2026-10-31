# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "additionalInformation"       = (var.additionalInformation == null ? null : [for item0 in var.additionalInformation : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "correlationId"               = var.correlationId
    "eventDateTime"               = var.eventDateTime
    "eventName"                   = var.eventName
    "@odata.type"                 = var.odata_type
    "troubleshootingErrorDetails" = (var.troubleshootingErrorDetails == null ? null : { for key0, value0 in { "@odata.type" = var.troubleshootingErrorDetails["odata_type"], "context" = var.troubleshootingErrorDetails["context"], "failure" = var.troubleshootingErrorDetails["failure"], "failureDetails" = var.troubleshootingErrorDetails["failureDetails"], "remediation" = var.troubleshootingErrorDetails["remediation"], "resources" = (var.troubleshootingErrorDetails["resources"] == null ? null : [for item1 in var.troubleshootingErrorDetails["resources"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "link" = item1["link"], "text" = item1["text"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/troubleshootingEvents"
  api_version             = "beta"
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
