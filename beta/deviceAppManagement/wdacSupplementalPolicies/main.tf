# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"          = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "content"              = var.content
    "contentFileName"      = var.contentFileName
    "creationDateTime"     = var.creationDateTime
    "deploySummary"        = var.deploySummary
    "description"          = var.description
    "deviceStatuses"       = (var.deviceStatuses == null ? null : [for item0 in var.deviceStatuses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deploymentStatus" = item0["deploymentStatus"], "deviceId" = item0["deviceId"], "deviceName" = item0["deviceName"], "lastSyncDateTime" = item0["lastSyncDateTime"], "osDescription" = item0["osDescription"], "osVersion" = item0["osVersion"], "policy" = item0["policy"], "policyVersion" = item0["policyVersion"], "userName" = item0["userName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"          = var.displayName
    "version"              = var.graph_version
    "lastModifiedDateTime" = var.lastModifiedDateTime
    "@odata.type"          = var.odata_type
    "roleScopeTagIds"      = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/wdacSupplementalPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "deploySummary", "deviceStatuses"], name)])]))))] } : null

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
