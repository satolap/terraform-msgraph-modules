# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedTargetScope"           = var.allowedTargetScope
    "automaticRequestSettings"     = (var.automaticRequestSettings == null ? null : { for key0, value0 in { "@odata.type" = var.automaticRequestSettings["odata_type"], "gracePeriodBeforeAccessRemoval" = var.automaticRequestSettings["gracePeriodBeforeAccessRemoval"], "removeAccessWhenTargetLeavesAllowedTargets" = var.automaticRequestSettings["removeAccessWhenTargetLeavesAllowedTargets"], "requestAccessForAllowedTargets" = var.automaticRequestSettings["requestAccessForAllowedTargets"] } : key0 => value0 if value0 != null })
    "createdDateTime"              = var.createdDateTime
    "customExtensionStageSettings" = (var.customExtensionStageSettings == null ? null : [for item0 in var.customExtensionStageSettings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customExtension" = item0["customExtension"], "stage" = item0["stage"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                  = var.description
    "displayName"                  = var.displayName
    "expiration"                   = (var.expiration == null ? null : { for key0, value0 in { "@odata.type" = var.expiration["odata_type"], "duration" = var.expiration["duration"], "endDateTime" = var.expiration["endDateTime"], "type" = var.expiration["type"] } : key0 => value0 if value0 != null })
    "modifiedDateTime"             = var.modifiedDateTime
    "notificationSettings"         = (var.notificationSettings == null ? null : { for key0, value0 in { "@odata.type" = var.notificationSettings["odata_type"], "isAssignmentNotificationDisabled" = var.notificationSettings["isAssignmentNotificationDisabled"] } : key0 => value0 if value0 != null })
    "@odata.type"                  = var.odata_type
    "questions"                    = (var.questions == null ? null : [for item0 in var.questions : item0 if item0 != null])
    "requestApprovalSettings"      = (var.requestApprovalSettings == null ? null : { for key0, value0 in { "@odata.type" = var.requestApprovalSettings["odata_type"], "isApprovalRequiredForAdd" = var.requestApprovalSettings["isApprovalRequiredForAdd"], "isApprovalRequiredForUpdate" = var.requestApprovalSettings["isApprovalRequiredForUpdate"], "isRequestorJustificationRequired" = var.requestApprovalSettings["isRequestorJustificationRequired"], "stages" = (var.requestApprovalSettings["stages"] == null ? null : [for item1 in var.requestApprovalSettings["stages"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "approverInformationVisibility" = item1["approverInformationVisibility"], "durationBeforeAutomaticDenial" = item1["durationBeforeAutomaticDenial"], "durationBeforeEscalation" = item1["durationBeforeEscalation"], "escalationApprovers" = (item1["escalationApprovers"] == null ? null : [for item3 in item1["escalationApprovers"] : item3 if item3 != null]), "fallbackEscalationApprovers" = (item1["fallbackEscalationApprovers"] == null ? null : [for item3 in item1["fallbackEscalationApprovers"] : item3 if item3 != null]), "fallbackPrimaryApprovers" = (item1["fallbackPrimaryApprovers"] == null ? null : [for item3 in item1["fallbackPrimaryApprovers"] : item3 if item3 != null]), "isApproverJustificationRequired" = item1["isApproverJustificationRequired"], "isEscalationEnabled" = item1["isEscalationEnabled"], "primaryApprovers" = (item1["primaryApprovers"] == null ? null : [for item3 in item1["primaryApprovers"] : item3 if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "requestorSettings"            = (var.requestorSettings == null ? null : { for key0, value0 in { "@odata.type" = var.requestorSettings["odata_type"], "allowCustomAssignmentSchedule" = var.requestorSettings["allowCustomAssignmentSchedule"], "enableOnBehalfRequestorsToAddAccess" = var.requestorSettings["enableOnBehalfRequestorsToAddAccess"], "enableOnBehalfRequestorsToRemoveAccess" = var.requestorSettings["enableOnBehalfRequestorsToRemoveAccess"], "enableOnBehalfRequestorsToUpdateAccess" = var.requestorSettings["enableOnBehalfRequestorsToUpdateAccess"], "enableTargetsToSelfAddAccess" = var.requestorSettings["enableTargetsToSelfAddAccess"], "enableTargetsToSelfRemoveAccess" = var.requestorSettings["enableTargetsToSelfRemoveAccess"], "enableTargetsToSelfUpdateAccess" = var.requestorSettings["enableTargetsToSelfUpdateAccess"], "onBehalfRequestors" = (var.requestorSettings["onBehalfRequestors"] == null ? null : [for item1 in var.requestorSettings["onBehalfRequestors"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "reviewSettings"               = (var.reviewSettings == null ? null : { for key0, value0 in { "@odata.type" = var.reviewSettings["odata_type"], "expirationBehavior" = var.reviewSettings["expirationBehavior"], "fallbackReviewers" = (var.reviewSettings["fallbackReviewers"] == null ? null : [for item1 in var.reviewSettings["fallbackReviewers"] : item1 if item1 != null]), "isEnabled" = var.reviewSettings["isEnabled"], "isRecommendationEnabled" = var.reviewSettings["isRecommendationEnabled"], "isReviewerJustificationRequired" = var.reviewSettings["isReviewerJustificationRequired"], "isSelfReview" = var.reviewSettings["isSelfReview"], "primaryReviewers" = (var.reviewSettings["primaryReviewers"] == null ? null : [for item1 in var.reviewSettings["primaryReviewers"] : item1 if item1 != null]), "schedule" = (var.reviewSettings["schedule"] == null ? null : { for key1, value1 in { "@odata.type" = var.reviewSettings["schedule"]["odata_type"], "expiration" = (var.reviewSettings["schedule"]["expiration"] == null ? null : { for key2, value2 in { "@odata.type" = var.reviewSettings["schedule"]["expiration"]["odata_type"], "duration" = var.reviewSettings["schedule"]["expiration"]["duration"], "endDateTime" = var.reviewSettings["schedule"]["expiration"]["endDateTime"], "type" = var.reviewSettings["schedule"]["expiration"]["type"] } : key2 => value2 if value2 != null }), "recurrence" = (var.reviewSettings["schedule"]["recurrence"] == null ? null : { for key2, value2 in { "@odata.type" = var.reviewSettings["schedule"]["recurrence"]["odata_type"], "pattern" = (var.reviewSettings["schedule"]["recurrence"]["pattern"] == null ? null : { for key3, value3 in { "@odata.type" = var.reviewSettings["schedule"]["recurrence"]["pattern"]["odata_type"], "dayOfMonth" = var.reviewSettings["schedule"]["recurrence"]["pattern"]["dayOfMonth"], "daysOfWeek" = (var.reviewSettings["schedule"]["recurrence"]["pattern"]["daysOfWeek"] == null ? null : [for item4 in var.reviewSettings["schedule"]["recurrence"]["pattern"]["daysOfWeek"] : item4 if item4 != null]), "firstDayOfWeek" = var.reviewSettings["schedule"]["recurrence"]["pattern"]["firstDayOfWeek"], "index" = var.reviewSettings["schedule"]["recurrence"]["pattern"]["index"], "interval" = var.reviewSettings["schedule"]["recurrence"]["pattern"]["interval"], "month" = var.reviewSettings["schedule"]["recurrence"]["pattern"]["month"], "type" = var.reviewSettings["schedule"]["recurrence"]["pattern"]["type"] } : key3 => value3 if value3 != null }), "range" = (var.reviewSettings["schedule"]["recurrence"]["range"] == null ? null : { for key3, value3 in { "@odata.type" = var.reviewSettings["schedule"]["recurrence"]["range"]["odata_type"], "endDate" = var.reviewSettings["schedule"]["recurrence"]["range"]["endDate"], "numberOfOccurrences" = var.reviewSettings["schedule"]["recurrence"]["range"]["numberOfOccurrences"], "recurrenceTimeZone" = var.reviewSettings["schedule"]["recurrence"]["range"]["recurrenceTimeZone"], "startDate" = var.reviewSettings["schedule"]["recurrence"]["range"]["startDate"], "type" = var.reviewSettings["schedule"]["recurrence"]["range"]["type"] } : key3 => value3 if value3 != null }) } : key2 => value2 if value2 != null }), "startDateTime" = var.reviewSettings["schedule"]["startDateTime"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "specificAllowedTargets"       = (var.specificAllowedTargets == null ? null : [for item0 in var.specificAllowedTargets : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/assignmentPolicies"
  api_version             = "v1.0"
  update_method           = "PUT"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["customExtensionStageSettings", "questions"], name)])]))))] } : null

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
