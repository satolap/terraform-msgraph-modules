# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attackTechnique"            = var.attack_technique
    "attackType"                 = var.attack_type
    "automationId"               = var.automation_id
    "completionDateTime"         = var.completion_date_time
    "createdBy"                  = var.created_by
    "createdDateTime"            = var.created_date_time
    "description"                = var.description
    "displayName"                = var.display_name
    "durationInDays"             = var.duration_in_days
    "endUserNotificationSetting" = var.end_user_notification_setting
    "excludedAccountTarget"      = var.excluded_account_target
    "includedAccountTarget"      = var.included_account_target
    "isAutomated"                = var.is_automated
    "landingPage"                = var.landing_page
    "lastModifiedBy"             = var.last_modified_by
    "lastModifiedDateTime"       = var.last_modified_date_time
    "launchDateTime"             = var.launch_date_time
    "loginPage"                  = var.login_page
    "oAuthConsentAppDetail"      = var.o_auth_consent_app_detail
    "@odata.type"                = var.odata_type
    "payload"                    = var.payload
    "payloadDeliveryPlatform"    = var.payload_delivery_platform
    "report"                     = var.report
    "status"                     = var.status
    "trainingSetting"            = var.training_setting
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/attackSimulation/simulations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
