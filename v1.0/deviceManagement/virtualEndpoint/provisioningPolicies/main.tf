# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"              = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "autopatch"                = (var.autopatch == null ? null : { for key0, value0 in { "@odata.type" = var.autopatch["odata_type"], "autopatchGroupId" = var.autopatch["autopatchGroupId"] } : key0 => value0 if value0 != null })
    "cloudPcNamingTemplate"    = var.cloudPcNamingTemplate
    "description"              = var.description
    "displayName"              = var.displayName
    "domainJoinConfigurations" = (var.domainJoinConfigurations == null ? null : [for item0 in var.domainJoinConfigurations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "domainJoinType" = item0["domainJoinType"], "onPremisesConnectionId" = item0["onPremisesConnectionId"], "regionName" = item0["regionName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "enableSingleSignOn"       = var.enableSingleSignOn
    "imageDisplayName"         = var.imageDisplayName
    "imageId"                  = var.imageId
    "imageType"                = var.imageType
    "localAdminEnabled"        = var.localAdminEnabled
    "microsoftManagedDesktop"  = (var.microsoftManagedDesktop == null ? null : { for key0, value0 in { "@odata.type" = var.microsoftManagedDesktop["odata_type"], "managedType" = var.microsoftManagedDesktop["managedType"], "profile" = var.microsoftManagedDesktop["profile"] } : key0 => value0 if value0 != null })
    "@odata.type"              = var.odata_type
    "provisioningType"         = var.provisioningType
    "windowsSetting"           = (var.windowsSetting == null ? null : { for key0, value0 in { "@odata.type" = var.windowsSetting["odata_type"], "locale" = var.windowsSetting["locale"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/provisioningPolicies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments"], name)])]))))] } : null

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
