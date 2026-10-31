# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignedSensitivityLabel" = (var.assignedSensitivityLabel == null ? null : { for key0, value0 in { "@odata.type" = var.assignedSensitivityLabel["odata_type"], "assignmentMethod" = var.assignedSensitivityLabel["assignmentMethod"], "sensitivityLabelId" = var.assignedSensitivityLabel["sensitivityLabelId"], "tenantId" = var.assignedSensitivityLabel["tenantId"] } : key0 => value0 if value0 != null })
    "members"                  = (var.members == null ? null : [for item0 in var.members : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "roles" = (item0["roles"] == null ? null : [for item2 in item0["roles"] : item2 if item2 != null]), "tenantId" = item0["tenantId"], "userId" = item0["userId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"              = var.odata_type
    "plans"                    = (var.plans == null ? null : [for item0 in var.plans : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "container" = item0["container"], "contentSensitivityLabelAssignment" = (item0["contentSensitivityLabelAssignment"] == null ? null : { for key2, value2 in { "@odata.type" = item0["contentSensitivityLabelAssignment"]["odata_type"], "assignmentMethod" = item0["contentSensitivityLabelAssignment"]["assignmentMethod"], "justificationText" = item0["contentSensitivityLabelAssignment"]["justificationText"], "sensitivityLabelId" = item0["contentSensitivityLabelAssignment"]["sensitivityLabelId"], "tenantId" = item0["contentSensitivityLabelAssignment"]["tenantId"] } : key2 => value2 if value2 != null }), "creationSource" = item0["creationSource"], "owner" = item0["owner"], "sharedWithContainers" = (item0["sharedWithContainers"] == null ? null : [for item2 in item0["sharedWithContainers"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "accessLevel" = item2["accessLevel"], "containerId" = item2["containerId"], "type" = item2["type"], "url" = item2["url"] } : key3 => value3 if value3 != null }) if item2 != null]), "title" = item0["title"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "planner/rosters"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["members", "plans"], name)])]))))] } : null

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
