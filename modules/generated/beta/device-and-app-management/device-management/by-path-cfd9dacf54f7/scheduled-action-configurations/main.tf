# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionType"                = var.action_type
    "gracePeriodHours"          = var.grace_period_hours
    "notificationMessageCCList" = (var.notification_message_cc_list == null ? null : [for item0 in var.notification_message_cc_list : item0 if item0 != null])
    "notificationTemplateId"    = var.notification_template_id
    "@odata.type"               = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/compliancePolicies/${urlencode(var.device_management_compliance_policy_id)}/scheduledActionsForRule/${urlencode(var.device_management_compliance_scheduled_action_for_rule_id)}/scheduledActionConfigurations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
