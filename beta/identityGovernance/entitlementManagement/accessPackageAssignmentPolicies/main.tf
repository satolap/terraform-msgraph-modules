# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessPackageCatalog"              = var.accessPackageCatalog
    "accessPackageId"                   = var.accessPackageId
    "accessPackageNotificationSettings" = (var.accessPackageNotificationSettings == null ? null : { for key0, value0 in { "@odata.type" = var.accessPackageNotificationSettings["odata_type"], "isAssignmentNotificationDisabled" = var.accessPackageNotificationSettings["isAssignmentNotificationDisabled"] } : key0 => value0 if value0 != null })
    "accessReviewSettings"              = (var.accessReviewSettings == null ? null : { for key0, value0 in { "@odata.type" = var.accessReviewSettings["odata_type"], "accessReviewTimeoutBehavior" = var.accessReviewSettings["accessReviewTimeoutBehavior"], "durationInDays" = var.accessReviewSettings["durationInDays"], "isAccessRecommendationEnabled" = var.accessReviewSettings["isAccessRecommendationEnabled"], "isAgenticExperienceEnabled" = var.accessReviewSettings["isAgenticExperienceEnabled"], "isApprovalJustificationRequired" = var.accessReviewSettings["isApprovalJustificationRequired"], "isEnabled" = var.accessReviewSettings["isEnabled"], "recurrenceType" = var.accessReviewSettings["recurrenceType"], "reviewerType" = var.accessReviewSettings["reviewerType"], "reviewers" = (var.accessReviewSettings["reviewers"] == null ? null : [for item1 in var.accessReviewSettings["reviewers"] : item1 if item1 != null]), "startDateTime" = var.accessReviewSettings["startDateTime"] } : key0 => value0 if value0 != null })
    "canExtend"                         = var.canExtend
    "createdBy"                         = var.createdBy
    "createdDateTime"                   = var.createdDateTime
    "customExtensionHandlers"           = (var.customExtensionHandlers == null ? null : [for item0 in var.customExtensionHandlers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customExtension" = item0["customExtension"], "stage" = item0["stage"] } : key1 => value1 if value1 != null }) if item0 != null])
    "customExtensionStageSettings"      = (var.customExtensionStageSettings == null ? null : [for item0 in var.customExtensionStageSettings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customExtension" = item0["customExtension"], "stage" = item0["stage"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                       = var.description
    "displayName"                       = var.displayName
    "durationInDays"                    = var.durationInDays
    "expirationDateTime"                = var.expirationDateTime
    "modifiedBy"                        = var.modifiedBy
    "modifiedDateTime"                  = var.modifiedDateTime
    "@odata.type"                       = var.odata_type
    "questions"                         = (var.questions == null ? null : [for item0 in var.questions : item0 if item0 != null])
    "requestApprovalSettings"           = (var.requestApprovalSettings == null ? null : { for key0, value0 in { "@odata.type" = var.requestApprovalSettings["odata_type"], "approvalMode" = var.requestApprovalSettings["approvalMode"], "approvalStages" = (var.requestApprovalSettings["approvalStages"] == null ? null : [for item1 in var.requestApprovalSettings["approvalStages"] : item1 if item1 != null]), "isApprovalRequired" = var.requestApprovalSettings["isApprovalRequired"], "isApprovalRequiredForExtension" = var.requestApprovalSettings["isApprovalRequiredForExtension"], "isRequestorJustificationRequired" = var.requestApprovalSettings["isRequestorJustificationRequired"] } : key0 => value0 if value0 != null })
    "requestorSettings"                 = (var.requestorSettings == null ? null : { for key0, value0 in { "@odata.type" = var.requestorSettings["odata_type"], "acceptRequests" = var.requestorSettings["acceptRequests"], "allowedRequestors" = (var.requestorSettings["allowedRequestors"] == null ? null : [for item1 in var.requestorSettings["allowedRequestors"] : item1 if item1 != null]), "scopeType" = var.requestorSettings["scopeType"] } : key0 => value0 if value0 != null })
    "verifiableCredentialSettings"      = (var.verifiableCredentialSettings == null ? null : { for key0, value0 in { "@odata.type" = var.verifiableCredentialSettings["odata_type"], "credentialTypes" = (var.verifiableCredentialSettings["credentialTypes"] == null ? null : [for item1 in var.verifiableCredentialSettings["credentialTypes"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "credentialType" = item1["credentialType"], "issuers" = (item1["issuers"] == null ? null : [for item3 in item1["issuers"] : item3 if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/accessPackageAssignmentPolicies"
  api_version             = "beta"
  update_method           = "PUT"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["accessPackageCatalog", "customExtensionHandlers", "customExtensionStageSettings"], name)])]))))] } : null

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
