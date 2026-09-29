# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"            = var.display_name
    "externalId"             = var.external_id
    "@odata.type"            = var.odata_type
    "registeredDateTime"     = var.registered_date_time
    "registeredRoot"         = var.registered_root
    "roleAssignmentRequests" = (var.role_assignment_requests == null ? null : [for item0 in var.role_assignment_requests : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignmentState" = item0["assignmentState"], "linkedEligibleRoleAssignmentId" = item0["linkedEligibleRoleAssignmentId"], "reason" = item0["reason"], "resourceId" = item0["resourceId"], "roleDefinitionId" = item0["roleDefinitionId"], "schedule" = (item0["schedule"] == null ? null : { for key2, value2 in { "@odata.type" = item0["schedule"]["odata_type"], "duration" = item0["schedule"]["duration"], "endDateTime" = item0["schedule"]["endDateTime"], "startDateTime" = item0["schedule"]["startDateTime"], "type" = item0["schedule"]["type"] } : key2 => value2 if value2 != null }), "status" = (item0["status"] == null ? null : { for key2, value2 in { "@odata.type" = item0["status"]["odata_type"], "status" = item0["status"]["status"], "statusDetails" = (item0["status"]["statusDetails"] == null ? null : [for item3 in item0["status"]["statusDetails"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "key" = item3["key"], "value" = item3["value"] } : key4 => value4 if value4 != null }) if item3 != null]), "subStatus" = item0["status"]["subStatus"] } : key2 => value2 if value2 != null }), "subjectId" = item0["subjectId"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "roleAssignments"        = (var.role_assignments == null ? null : [for item0 in var.role_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignmentState" = item0["assignmentState"], "endDateTime" = item0["endDateTime"], "externalId" = item0["externalId"], "linkedEligibleRoleAssignmentId" = item0["linkedEligibleRoleAssignmentId"], "memberType" = item0["memberType"], "resourceId" = item0["resourceId"], "roleDefinitionId" = item0["roleDefinitionId"], "startDateTime" = item0["startDateTime"], "status" = item0["status"], "subjectId" = item0["subjectId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "roleDefinitions"        = (var.role_definitions == null ? null : [for item0 in var.role_definitions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "externalId" = item0["externalId"], "resourceId" = item0["resourceId"], "roleSetting" = item0["roleSetting"], "templateId" = item0["templateId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "roleSettings"           = (var.role_settings == null ? null : [for item0 in var.role_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "adminEligibleSettings" = (item0["adminEligibleSettings"] == null ? null : [for item2 in item0["adminEligibleSettings"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "ruleIdentifier" = item2["ruleIdentifier"], "setting" = item2["setting"] } : key3 => value3 if value3 != null }) if item2 != null]), "adminMemberSettings" = (item0["adminMemberSettings"] == null ? null : [for item2 in item0["adminMemberSettings"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "ruleIdentifier" = item2["ruleIdentifier"], "setting" = item2["setting"] } : key3 => value3 if value3 != null }) if item2 != null]), "resourceId" = item0["resourceId"], "roleDefinitionId" = item0["roleDefinitionId"], "userEligibleSettings" = (item0["userEligibleSettings"] == null ? null : [for item2 in item0["userEligibleSettings"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "ruleIdentifier" = item2["ruleIdentifier"], "setting" = item2["setting"] } : key3 => value3 if value3 != null }) if item2 != null]), "userMemberSettings" = (item0["userMemberSettings"] == null ? null : [for item2 in item0["userMemberSettings"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "ruleIdentifier" = item2["ruleIdentifier"], "setting" = item2["setting"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "status"                 = var.status
    "type"                   = var.type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "governanceResources"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
