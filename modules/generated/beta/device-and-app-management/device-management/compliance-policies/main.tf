# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"             = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "source" = item0["source"], "sourceId" = item0["sourceId"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "creationSource"          = var.creation_source
    "description"             = var.description
    "name"                    = var.name
    "@odata.type"             = var.odata_type
    "platforms"               = var.platforms
    "roleScopeTagIds"         = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "scheduledActionsForRule" = (var.scheduled_actions_for_rule == null ? null : [for item0 in var.scheduled_actions_for_rule : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "ruleName" = item0["ruleName"], "scheduledActionConfigurations" = (item0["scheduledActionConfigurations"] == null ? null : [for item2 in item0["scheduledActionConfigurations"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "actionType" = item2["actionType"], "gracePeriodHours" = item2["gracePeriodHours"], "notificationMessageCCList" = (item2["notificationMessageCCList"] == null ? null : [for item4 in item2["notificationMessageCCList"] : item4 if item4 != null]), "notificationTemplateId" = item2["notificationTemplateId"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "settings"                = (var.settings == null ? null : [for item0 in var.settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "settingInstance" = (item0["settingInstance"] == null ? null : { for key2, value2 in { "@odata.type" = item0["settingInstance"]["odata_type"], "settingDefinitionId" = item0["settingInstance"]["settingDefinitionId"], "settingInstanceTemplateReference" = item0["settingInstance"]["settingInstanceTemplateReference"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "technologies"            = var.technologies
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/compliancePolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
