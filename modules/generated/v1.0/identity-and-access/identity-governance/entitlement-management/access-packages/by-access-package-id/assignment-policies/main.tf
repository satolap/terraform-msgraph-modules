# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedTargetScope"           = var.allowed_target_scope
    "automaticRequestSettings"     = var.automatic_request_settings
    "createdDateTime"              = var.created_date_time
    "customExtensionStageSettings" = (var.custom_extension_stage_settings == null ? null : [for item0 in var.custom_extension_stage_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customExtension" = item0["customExtension"], "stage" = item0["stage"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                  = var.description
    "displayName"                  = var.display_name
    "expiration"                   = var.expiration
    "modifiedDateTime"             = var.modified_date_time
    "notificationSettings"         = var.notification_settings
    "@odata.type"                  = var.odata_type
    "questions"                    = (var.questions == null ? null : [for item0 in var.questions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isAnswerEditable" = item0["isAnswerEditable"], "isRequired" = item0["isRequired"], "localizations" = (item0["localizations"] == null ? null : [for item2 in item0["localizations"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "languageCode" = item2["languageCode"], "text" = item2["text"] } : key3 => value3 if value3 != null }) if item2 != null]), "sequence" = item0["sequence"], "text" = item0["text"] } : key1 => value1 if value1 != null }) if item0 != null])
    "requestApprovalSettings"      = var.request_approval_settings
    "requestorSettings"            = var.requestor_settings
    "reviewSettings"               = var.review_settings
    "specificAllowedTargets"       = (var.specific_allowed_targets == null ? null : [for item0 in var.specific_allowed_targets : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/accessPackages/${urlencode(var.access_package_id)}/assignmentPolicies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
