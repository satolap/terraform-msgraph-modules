# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessPackageCatalog"              = var.access_package_catalog
    "accessPackageId"                   = var.access_package_id
    "accessPackageNotificationSettings" = var.access_package_notification_settings
    "accessReviewSettings"              = var.access_review_settings
    "canExtend"                         = var.can_extend
    "createdBy"                         = var.created_by
    "createdDateTime"                   = var.created_date_time
    "customExtensionHandlers"           = (var.custom_extension_handlers == null ? null : [for item0 in var.custom_extension_handlers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customExtension" = item0["customExtension"], "stage" = item0["stage"] } : key1 => value1 if value1 != null }) if item0 != null])
    "customExtensionStageSettings"      = (var.custom_extension_stage_settings == null ? null : [for item0 in var.custom_extension_stage_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customExtension" = item0["customExtension"], "stage" = item0["stage"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                       = var.description
    "displayName"                       = var.display_name
    "durationInDays"                    = var.duration_in_days
    "expirationDateTime"                = var.expiration_date_time
    "modifiedBy"                        = var.modified_by
    "modifiedDateTime"                  = var.modified_date_time
    "@odata.type"                       = var.odata_type
    "questions"                         = (var.questions == null ? null : [for item0 in var.questions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "id" = item0["id"], "isAnswerEditable" = item0["isAnswerEditable"], "isRequired" = item0["isRequired"], "sequence" = item0["sequence"], "text" = item0["text"] } : key1 => value1 if value1 != null }) if item0 != null])
    "requestApprovalSettings"           = var.request_approval_settings
    "requestorSettings"                 = var.requestor_settings
    "verifiableCredentialSettings"      = var.verifiable_credential_settings
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/accessPackageAssignmentPolicies"
  api_version             = "beta"
  update_method           = "PUT"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
