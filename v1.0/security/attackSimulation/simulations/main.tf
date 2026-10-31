# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attackTechnique"            = var.attackTechnique
    "attackType"                 = var.attackType
    "automationId"               = var.automationId
    "completionDateTime"         = var.completionDateTime
    "createdBy"                  = (var.createdBy == null ? null : { for key0, value0 in { "@odata.type" = var.createdBy["odata_type"], "displayName" = var.createdBy["displayName"], "email" = var.createdBy["email"], "id" = var.createdBy["id"] } : key0 => value0 if value0 != null })
    "createdDateTime"            = var.createdDateTime
    "description"                = var.description
    "displayName"                = var.displayName
    "durationInDays"             = var.durationInDays
    "endUserNotificationSetting" = var.endUserNotificationSetting
    "excludedAccountTarget"      = var.excludedAccountTarget
    "includedAccountTarget"      = var.includedAccountTarget
    "isAutomated"                = var.isAutomated
    "landingPage"                = var.landingPage
    "lastModifiedBy"             = (var.lastModifiedBy == null ? null : { for key0, value0 in { "@odata.type" = var.lastModifiedBy["odata_type"], "displayName" = var.lastModifiedBy["displayName"], "email" = var.lastModifiedBy["email"], "id" = var.lastModifiedBy["id"] } : key0 => value0 if value0 != null })
    "lastModifiedDateTime"       = var.lastModifiedDateTime
    "launchDateTime"             = var.launchDateTime
    "loginPage"                  = var.loginPage
    "oAuthConsentAppDetail"      = (var.oAuthConsentAppDetail == null ? null : { for key0, value0 in { "@odata.type" = var.oAuthConsentAppDetail["odata_type"], "appScope" = var.oAuthConsentAppDetail["appScope"], "displayLogo" = var.oAuthConsentAppDetail["displayLogo"], "displayName" = var.oAuthConsentAppDetail["displayName"] } : key0 => value0 if value0 != null })
    "@odata.type"                = var.odata_type
    "payload"                    = var.payload
    "payloadDeliveryPlatform"    = var.payloadDeliveryPlatform
    "report"                     = (var.report == null ? null : { for key0, value0 in { "@odata.type" = var.report["odata_type"], "overview" = (var.report["overview"] == null ? null : { for key1, value1 in { "@odata.type" = var.report["overview"]["odata_type"], "recommendedActions" = (var.report["overview"]["recommendedActions"] == null ? null : [for item2 in var.report["overview"]["recommendedActions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "actionWebUrl" = item2["actionWebUrl"], "potentialScoreImpact" = item2["potentialScoreImpact"], "title" = item2["title"] } : key3 => value3 if value3 != null }) if item2 != null]), "resolvedTargetsCount" = var.report["overview"]["resolvedTargetsCount"], "simulationEventsContent" = (var.report["overview"]["simulationEventsContent"] == null ? null : { for key2, value2 in { "@odata.type" = var.report["overview"]["simulationEventsContent"]["odata_type"], "compromisedRate" = var.report["overview"]["simulationEventsContent"]["compromisedRate"], "events" = (var.report["overview"]["simulationEventsContent"]["events"] == null ? null : [for item3 in var.report["overview"]["simulationEventsContent"]["events"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "count" = item3["count"], "eventName" = item3["eventName"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }), "trainingEventsContent" = (var.report["overview"]["trainingEventsContent"] == null ? null : { for key2, value2 in { "@odata.type" = var.report["overview"]["trainingEventsContent"]["odata_type"], "assignedTrainingsInfos" = (var.report["overview"]["trainingEventsContent"]["assignedTrainingsInfos"] == null ? null : [for item3 in var.report["overview"]["trainingEventsContent"]["assignedTrainingsInfos"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "assignedUserCount" = item3["assignedUserCount"], "completedUserCount" = item3["completedUserCount"], "displayName" = item3["displayName"] } : key4 => value4 if value4 != null }) if item3 != null]), "trainingsAssignedUserCount" = var.report["overview"]["trainingEventsContent"]["trainingsAssignedUserCount"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }), "simulationUsers" = (var.report["simulationUsers"] == null ? null : [for item1 in var.report["simulationUsers"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "assignedTrainingsCount" = item1["assignedTrainingsCount"], "completedTrainingsCount" = item1["completedTrainingsCount"], "compromisedDateTime" = item1["compromisedDateTime"], "inProgressTrainingsCount" = item1["inProgressTrainingsCount"], "isCompromised" = item1["isCompromised"], "reportedPhishDateTime" = item1["reportedPhishDateTime"], "simulationEvents" = (item1["simulationEvents"] == null ? null : [for item3 in item1["simulationEvents"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "browser" = item3["browser"], "clickSource" = item3["clickSource"], "eventDateTime" = item3["eventDateTime"], "eventName" = item3["eventName"], "ipAddress" = item3["ipAddress"], "osPlatformDeviceDetails" = item3["osPlatformDeviceDetails"] } : key4 => value4 if value4 != null }) if item3 != null]), "simulationUser" = (item1["simulationUser"] == null ? null : { for key3, value3 in { "@odata.type" = item1["simulationUser"]["odata_type"], "displayName" = item1["simulationUser"]["displayName"], "email" = item1["simulationUser"]["email"], "userId" = item1["simulationUser"]["userId"] } : key3 => value3 if value3 != null }), "trainingEvents" = (item1["trainingEvents"] == null ? null : [for item3 in item1["trainingEvents"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "displayName" = item3["displayName"], "latestTrainingStatus" = item3["latestTrainingStatus"], "trainingAssignedProperties" = item3["trainingAssignedProperties"], "trainingCompletedProperties" = item3["trainingCompletedProperties"], "trainingUpdatedProperties" = item3["trainingUpdatedProperties"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "status"                     = var.status
    "trainingSetting"            = var.trainingSetting
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "security/attackSimulation/simulations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["landingPage", "loginPage", "payload"], name)])]))))] } : null

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
