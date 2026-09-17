# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                      = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"                  = var.created_date_time
    "definitionValues"                 = (var.definition_values == null ? null : [for item0 in var.definition_values : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "configurationType" = item0["configurationType"], "createdDateTime" = item0["createdDateTime"], "definition" = item0["definition"], "enabled" = item0["enabled"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "presentationValues" = (item0["presentationValues"] == null ? null : [for item2 in item0["presentationValues"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "createdDateTime" = item2["createdDateTime"], "definitionValue" = item2["definitionValue"], "lastModifiedDateTime" = item2["lastModifiedDateTime"], "presentation" = item2["presentation"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                      = var.description
    "displayName"                      = var.display_name
    "lastModifiedDateTime"             = var.last_modified_date_time
    "@odata.type"                      = var.odata_type
    "policyConfigurationIngestionType" = var.policy_configuration_ingestion_type
    "roleScopeTagIds"                  = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/groupPolicyConfigurations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
