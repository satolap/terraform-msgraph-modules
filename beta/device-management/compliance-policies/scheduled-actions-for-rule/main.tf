# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"                   = var.odata_type
    "ruleName"                      = var.rule_name
    "scheduledActionConfigurations" = (var.scheduled_action_configurations == null ? null : [for item0 in var.scheduled_action_configurations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actionType" = item0["actionType"], "gracePeriodHours" = item0["gracePeriodHours"], "notificationMessageCCList" = (item0["notificationMessageCCList"] == null ? null : [for item2 in item0["notificationMessageCCList"] : item2 if item2 != null]), "notificationTemplateId" = item0["notificationTemplateId"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/compliancePolicies/${urlencode(var.device_management_compliance_policy_id)}/scheduledActionsForRule"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
