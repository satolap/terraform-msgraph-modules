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

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceCompliancePolicies/${urlencode(var.device_compliance_policy_id)}/scheduledActionsForRule/${urlencode(var.device_compliance_scheduled_action_for_rule_id)}/scheduledActionConfigurations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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
