# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessPackageCatalog"              = var.access_package_catalog
    "accessPackageId"                   = var.access_package_id_2
    "accessPackageNotificationSettings" = (var.access_package_notification_settings == null ? null : { for key0, value0 in { "@odata.type" = var.access_package_notification_settings["odata_type"], "isAssignmentNotificationDisabled" = var.access_package_notification_settings["isAssignmentNotificationDisabled"] } : key0 => value0 if value0 != null })
    "accessReviewSettings"              = (var.access_review_settings == null ? null : { for key0, value0 in { "@odata.type" = var.access_review_settings["odata_type"], "accessReviewTimeoutBehavior" = var.access_review_settings["accessReviewTimeoutBehavior"], "durationInDays" = var.access_review_settings["durationInDays"], "isAccessRecommendationEnabled" = var.access_review_settings["isAccessRecommendationEnabled"], "isAgenticExperienceEnabled" = var.access_review_settings["isAgenticExperienceEnabled"], "isApprovalJustificationRequired" = var.access_review_settings["isApprovalJustificationRequired"], "isEnabled" = var.access_review_settings["isEnabled"], "recurrenceType" = var.access_review_settings["recurrenceType"], "reviewerType" = var.access_review_settings["reviewerType"], "reviewers" = (var.access_review_settings["reviewers"] == null ? null : [for item1 in var.access_review_settings["reviewers"] : item1 if item1 != null]), "startDateTime" = var.access_review_settings["startDateTime"] } : key0 => value0 if value0 != null })
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
    "questions"                         = (var.questions == null ? null : [for item0 in var.questions : item0 if item0 != null])
    "requestApprovalSettings"           = (var.request_approval_settings == null ? null : { for key0, value0 in { "@odata.type" = var.request_approval_settings["odata_type"], "approvalMode" = var.request_approval_settings["approvalMode"], "approvalStages" = (var.request_approval_settings["approvalStages"] == null ? null : [for item1 in var.request_approval_settings["approvalStages"] : item1 if item1 != null]), "isApprovalRequired" = var.request_approval_settings["isApprovalRequired"], "isApprovalRequiredForExtension" = var.request_approval_settings["isApprovalRequiredForExtension"], "isRequestorJustificationRequired" = var.request_approval_settings["isRequestorJustificationRequired"] } : key0 => value0 if value0 != null })
    "requestorSettings"                 = (var.requestor_settings == null ? null : { for key0, value0 in { "@odata.type" = var.requestor_settings["odata_type"], "acceptRequests" = var.requestor_settings["acceptRequests"], "allowedRequestors" = (var.requestor_settings["allowedRequestors"] == null ? null : [for item1 in var.requestor_settings["allowedRequestors"] : item1 if item1 != null]), "scopeType" = var.requestor_settings["scopeType"] } : key0 => value0 if value0 != null })
    "verifiableCredentialSettings"      = (var.verifiable_credential_settings == null ? null : { for key0, value0 in { "@odata.type" = var.verifiable_credential_settings["odata_type"], "credentialTypes" = (var.verifiable_credential_settings["credentialTypes"] == null ? null : [for item1 in var.verifiable_credential_settings["credentialTypes"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "credentialType" = item1["credentialType"], "issuers" = (item1["issuers"] == null ? null : [for item3 in item1["issuers"] : item3 if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/accessPackages/${urlencode(var.access_package_id)}/accessPackageAssignmentPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
