# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                       = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "source" = item0["source"], "sourceId" = item0["sourceId"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"                   = var.created_date_time
    "creationSource"                    = var.creation_source
    "description"                       = var.description
    "disableEntraGroupPolicyAssignment" = var.disable_entra_group_policy_assignment
    "lastModifiedDateTime"              = var.last_modified_date_time
    "name"                              = var.name
    "@odata.type"                       = var.odata_type
    "platforms"                         = var.platforms
    "priorityMetaData"                  = var.priority_meta_data
    "roleScopeTagIds"                   = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "settingCount"                      = var.setting_count
    "settings"                          = (var.settings == null ? null : [for item0 in var.settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "settingInstance" = (item0["settingInstance"] == null ? null : { for key2, value2 in { "@odata.type" = item0["settingInstance"]["odata_type"], "settingDefinitionId" = item0["settingInstance"]["settingDefinitionId"], "settingInstanceTemplateReference" = item0["settingInstance"]["settingInstanceTemplateReference"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "technologies"                      = var.technologies
    "templateReference"                 = var.template_reference
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/reusablePolicySettings/${urlencode(var.device_management_reusable_policy_setting_id)}/referencingConfigurationPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
