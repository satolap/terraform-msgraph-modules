# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "customData"       = var.custom_data
    "deDuplicationId"  = var.de_duplication_id
    "description"      = var.description
    "displayName"      = var.display_name
    "@odata.type"      = var.odata_type
    "policy"           = (var.policy == null ? null : { for key0, value0 in { "@odata.type" = var.policy["odata_type"], "decisionMakerCriteria" = (var.policy["decisionMakerCriteria"] == null ? null : [for item1 in var.policy["decisionMakerCriteria"] : item1 if item1 != null]), "notificationPolicy" = (var.policy["notificationPolicy"] == null ? null : { for key1, value1 in { "@odata.type" = var.policy["notificationPolicy"]["odata_type"], "enabledTemplateTypes" = (var.policy["notificationPolicy"]["enabledTemplateTypes"] == null ? null : [for item2 in var.policy["notificationPolicy"]["enabledTemplateTypes"] : item2 if item2 != null]), "notificationTemplates" = (var.policy["notificationPolicy"]["notificationTemplates"] == null ? null : [for item2 in var.policy["notificationPolicy"]["notificationTemplates"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "culture" = item2["culture"], "id" = item2["id"], "source" = item2["source"], "type" = item2["type"], "version" = item2["version"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "policyTemplateId" = var.policy_template_id
    "recordVersion"    = var.record_version
    "schemaId"         = var.schema_id
    "settings"         = (var.settings == null ? null : { for key0, value0 in { "@odata.type" = var.settings["odata_type"], "accessRecommendationsEnabled" = var.settings["accessRecommendationsEnabled"], "activityDurationInDays" = var.settings["activityDurationInDays"], "autoApplyReviewResultsEnabled" = var.settings["autoApplyReviewResultsEnabled"], "autoReviewEnabled" = var.settings["autoReviewEnabled"], "autoReviewSettings" = (var.settings["autoReviewSettings"] == null ? null : { for key1, value1 in { "@odata.type" = var.settings["autoReviewSettings"]["odata_type"], "notReviewedResult" = var.settings["autoReviewSettings"]["notReviewedResult"] } : key1 => value1 if value1 != null }), "durationInDays" = var.settings["durationInDays"], "justificationRequiredOnApproval" = var.settings["justificationRequiredOnApproval"], "mailNotificationsEnabled" = var.settings["mailNotificationsEnabled"], "recurrenceSettings" = (var.settings["recurrenceSettings"] == null ? null : { for key1, value1 in { "@odata.type" = var.settings["recurrenceSettings"]["odata_type"], "durationInDays" = var.settings["recurrenceSettings"]["durationInDays"], "recurrenceCount" = var.settings["recurrenceSettings"]["recurrenceCount"], "recurrenceEndType" = var.settings["recurrenceSettings"]["recurrenceEndType"], "recurrenceType" = var.settings["recurrenceSettings"]["recurrenceType"] } : key1 => value1 if value1 != null }), "remindersEnabled" = var.settings["remindersEnabled"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "approvalWorkflowProviders/${urlencode(var.approval_workflow_provider_id)}/businessFlowsWithRequestsAwaitingMyDecision"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
