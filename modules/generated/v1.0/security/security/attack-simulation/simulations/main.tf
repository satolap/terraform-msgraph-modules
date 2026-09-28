# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attackTechnique"            = var.attack_technique
    "attackType"                 = var.attack_type
    "automationId"               = var.automation_id
    "completionDateTime"         = var.completion_date_time
    "createdBy"                  = (var.created_by == null ? null : { for key0, value0 in { "@odata.type" = var.created_by["odata_type"], "displayName" = var.created_by["displayName"], "email" = var.created_by["email"], "id" = var.created_by["id"] } : key0 => value0 if value0 != null })
    "createdDateTime"            = var.created_date_time
    "description"                = var.description
    "displayName"                = var.display_name
    "durationInDays"             = var.duration_in_days
    "endUserNotificationSetting" = var.end_user_notification_setting
    "excludedAccountTarget"      = var.excluded_account_target
    "includedAccountTarget"      = var.included_account_target
    "isAutomated"                = var.is_automated
    "landingPage"                = var.landing_page
    "lastModifiedBy"             = (var.last_modified_by == null ? null : { for key0, value0 in { "@odata.type" = var.last_modified_by["odata_type"], "displayName" = var.last_modified_by["displayName"], "email" = var.last_modified_by["email"], "id" = var.last_modified_by["id"] } : key0 => value0 if value0 != null })
    "lastModifiedDateTime"       = var.last_modified_date_time
    "launchDateTime"             = var.launch_date_time
    "loginPage"                  = var.login_page
    "oAuthConsentAppDetail"      = (var.o_auth_consent_app_detail == null ? null : { for key0, value0 in { "@odata.type" = var.o_auth_consent_app_detail["odata_type"], "appScope" = var.o_auth_consent_app_detail["appScope"], "displayLogo" = var.o_auth_consent_app_detail["displayLogo"], "displayName" = var.o_auth_consent_app_detail["displayName"] } : key0 => value0 if value0 != null })
    "@odata.type"                = var.odata_type
    "payload"                    = var.payload
    "payloadDeliveryPlatform"    = var.payload_delivery_platform
    "report"                     = (var.report == null ? null : { for key0, value0 in { "@odata.type" = var.report["odata_type"], "overview" = (var.report["overview"] == null ? null : { for key1, value1 in { "@odata.type" = var.report["overview"]["odata_type"], "recommendedActions" = (var.report["overview"]["recommendedActions"] == null ? null : [for item2 in var.report["overview"]["recommendedActions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "actionWebUrl" = item2["actionWebUrl"], "potentialScoreImpact" = item2["potentialScoreImpact"], "title" = item2["title"] } : key3 => value3 if value3 != null }) if item2 != null]), "resolvedTargetsCount" = var.report["overview"]["resolvedTargetsCount"], "simulationEventsContent" = (var.report["overview"]["simulationEventsContent"] == null ? null : { for key2, value2 in { "@odata.type" = var.report["overview"]["simulationEventsContent"]["odata_type"], "compromisedRate" = var.report["overview"]["simulationEventsContent"]["compromisedRate"], "events" = (var.report["overview"]["simulationEventsContent"]["events"] == null ? null : [for item3 in var.report["overview"]["simulationEventsContent"]["events"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "count" = item3["count"], "eventName" = item3["eventName"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }), "trainingEventsContent" = (var.report["overview"]["trainingEventsContent"] == null ? null : { for key2, value2 in { "@odata.type" = var.report["overview"]["trainingEventsContent"]["odata_type"], "assignedTrainingsInfos" = (var.report["overview"]["trainingEventsContent"]["assignedTrainingsInfos"] == null ? null : [for item3 in var.report["overview"]["trainingEventsContent"]["assignedTrainingsInfos"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "assignedUserCount" = item3["assignedUserCount"], "completedUserCount" = item3["completedUserCount"], "displayName" = item3["displayName"] } : key4 => value4 if value4 != null }) if item3 != null]), "trainingsAssignedUserCount" = var.report["overview"]["trainingEventsContent"]["trainingsAssignedUserCount"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }), "simulationUsers" = (var.report["simulationUsers"] == null ? null : [for item1 in var.report["simulationUsers"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "assignedTrainingsCount" = item1["assignedTrainingsCount"], "completedTrainingsCount" = item1["completedTrainingsCount"], "compromisedDateTime" = item1["compromisedDateTime"], "inProgressTrainingsCount" = item1["inProgressTrainingsCount"], "isCompromised" = item1["isCompromised"], "reportedPhishDateTime" = item1["reportedPhishDateTime"], "simulationEvents" = (item1["simulationEvents"] == null ? null : [for item3 in item1["simulationEvents"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "browser" = item3["browser"], "clickSource" = item3["clickSource"], "eventDateTime" = item3["eventDateTime"], "eventName" = item3["eventName"], "ipAddress" = item3["ipAddress"], "osPlatformDeviceDetails" = item3["osPlatformDeviceDetails"] } : key4 => value4 if value4 != null }) if item3 != null]), "simulationUser" = (item1["simulationUser"] == null ? null : { for key3, value3 in { "@odata.type" = item1["simulationUser"]["odata_type"], "displayName" = item1["simulationUser"]["displayName"], "email" = item1["simulationUser"]["email"], "userId" = item1["simulationUser"]["userId"] } : key3 => value3 if value3 != null }), "trainingEvents" = (item1["trainingEvents"] == null ? null : [for item3 in item1["trainingEvents"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "displayName" = item3["displayName"], "latestTrainingStatus" = item3["latestTrainingStatus"], "trainingAssignedProperties" = item3["trainingAssignedProperties"], "trainingCompletedProperties" = item3["trainingCompletedProperties"], "trainingUpdatedProperties" = item3["trainingUpdatedProperties"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "status"                     = var.status
    "trainingSetting"            = var.training_setting
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/attackSimulation/simulations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
