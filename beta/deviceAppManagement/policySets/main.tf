# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"          = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"      = var.createdDateTime
    "description"          = var.description
    "displayName"          = var.displayName
    "errorCode"            = var.errorCode
    "guidedDeploymentTags" = (var.guidedDeploymentTags == null ? null : [for item0 in var.guidedDeploymentTags : item0 if item0 != null])
    "items"                = (var.items == null ? null : [for item0 in var.items : item0 if item0 != null])
    "lastModifiedDateTime" = var.lastModifiedDateTime
    "@odata.type"          = var.odata_type
    "roleScopeTags"        = (var.roleScopeTags == null ? null : [for item0 in var.roleScopeTags : item0 if item0 != null])
    "status"               = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/policySets"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "items"], name)])]))))] } : null

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
