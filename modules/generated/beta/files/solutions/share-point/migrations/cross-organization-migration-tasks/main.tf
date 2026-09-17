# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "error"       = (var.error == null ? null : { for key0, value0 in { "@odata.type" = var.error["odata_type"], "code" = var.error["code"], "details" = (var.error["details"] == null ? null : [for item1 in var.error["details"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "code" = item1["code"], "message" = item1["message"], "target" = item1["target"] } : key2 => value2 if value2 != null }) if item1 != null]), "innerError" = var.error["innerError"], "message" = var.error["message"], "target" = var.error["target"] } : key0 => value0 if value0 != null })
    "@odata.type" = var.odata_type
    "parameters"  = (var.parameters == null ? null : { for key0, value0 in { "@odata.type" = var.parameters["odata_type"], "preferredLatestStartDateTime" = var.parameters["preferredLatestStartDateTime"], "preferredStartDateTime" = var.parameters["preferredStartDateTime"], "sourceSiteUrl" = var.parameters["sourceSiteUrl"], "targetDataLocationCode" = var.parameters["targetDataLocationCode"], "targetOrganizationHost" = var.parameters["targetOrganizationHost"], "targetOrganizationId" = var.parameters["targetOrganizationId"], "targetSiteUrl" = var.parameters["targetSiteUrl"], "validateOnly" = var.parameters["validateOnly"] } : key0 => value0 if value0 != null })
    "status"      = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/sharePoint/migrations/crossOrganizationMigrationTasks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
