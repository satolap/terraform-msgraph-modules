# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "category"                  = var.category
    "categoryPath"              = var.categoryPath
    "classType"                 = var.classType
    "definitionFile"            = var.definitionFile
    "displayName"               = var.displayName
    "explainText"               = var.explainText
    "version"                   = var.graph_version
    "groupPolicyCategoryId"     = var.groupPolicyCategoryId
    "hasRelatedDefinitions"     = var.hasRelatedDefinitions
    "lastModifiedDateTime"      = var.lastModifiedDateTime
    "minDeviceCspVersion"       = var.minDeviceCspVersion
    "minUserCspVersion"         = var.minUserCspVersion
    "nextVersionDefinition"     = var.nextVersionDefinition
    "@odata.type"               = var.odata_type
    "policyType"                = var.policyType
    "presentations"             = (var.presentations == null ? null : [for item0 in var.presentations : item0 if item0 != null])
    "previousVersionDefinition" = var.previousVersionDefinition
    "supportedOn"               = var.supportedOn
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/groupPolicyDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["category", "definitionFile", "nextVersionDefinition", "presentations", "previousVersionDefinition"], name)])]))))] } : null

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
