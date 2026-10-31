# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "children"             = (var.children == null ? null : [for item0 in var.children : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "children" = (item0["children"] == null ? null : [for item2 in item0["children"] : item2 if item2 != null]), "definitionFile" = item0["definitionFile"], "definitions" = (item0["definitions"] == null ? null : [for item2 in item0["definitions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "category" = item2["category"], "categoryPath" = item2["categoryPath"], "classType" = item2["classType"], "definitionFile" = item2["definitionFile"], "displayName" = item2["displayName"], "explainText" = item2["explainText"], "groupPolicyCategoryId" = item2["groupPolicyCategoryId"], "hasRelatedDefinitions" = item2["hasRelatedDefinitions"], "lastModifiedDateTime" = item2["lastModifiedDateTime"], "minDeviceCspVersion" = item2["minDeviceCspVersion"], "minUserCspVersion" = item2["minUserCspVersion"], "nextVersionDefinition" = item2["nextVersionDefinition"], "policyType" = item2["policyType"], "presentations" = (item2["presentations"] == null ? null : [for item4 in item2["presentations"] : item4 if item4 != null]), "previousVersionDefinition" = item2["previousVersionDefinition"], "supportedOn" = item2["supportedOn"], "version" = item2["version"] } : key3 => value3 if value3 != null }) if item2 != null]), "displayName" = item0["displayName"], "ingestionSource" = item0["ingestionSource"], "isRoot" = item0["isRoot"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "parent" = item0["parent"] } : key1 => value1 if value1 != null }) if item0 != null])
    "definitionFile"       = var.definitionFile
    "definitions"          = (var.definitions == null ? null : [for item0 in var.definitions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "category" = item0["category"], "categoryPath" = item0["categoryPath"], "classType" = item0["classType"], "definitionFile" = item0["definitionFile"], "displayName" = item0["displayName"], "explainText" = item0["explainText"], "groupPolicyCategoryId" = item0["groupPolicyCategoryId"], "hasRelatedDefinitions" = item0["hasRelatedDefinitions"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "minDeviceCspVersion" = item0["minDeviceCspVersion"], "minUserCspVersion" = item0["minUserCspVersion"], "nextVersionDefinition" = item0["nextVersionDefinition"], "policyType" = item0["policyType"], "presentations" = (item0["presentations"] == null ? null : [for item2 in item0["presentations"] : item2 if item2 != null]), "previousVersionDefinition" = item0["previousVersionDefinition"], "supportedOn" = item0["supportedOn"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"          = var.displayName
    "ingestionSource"      = var.ingestionSource
    "isRoot"               = var.isRoot
    "lastModifiedDateTime" = var.lastModifiedDateTime
    "@odata.type"          = var.odata_type
    "parent"               = var.parent
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/groupPolicyCategories"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["children", "definitionFile", "definitions", "parent"], name)])]))))] } : null

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
