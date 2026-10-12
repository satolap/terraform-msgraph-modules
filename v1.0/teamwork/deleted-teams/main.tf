# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "channels"    = (var.channels == null ? null : [for item0 in var.channels : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allMembers" = (item0["allMembers"] == null ? null : [for item2 in item0["allMembers"] : item2 if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"], "enabledApps" = (item0["enabledApps"] == null ? null : [for item2 in item0["enabledApps"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "appDefinitions" = (item2["appDefinitions"] == null ? null : [for item4 in item2["appDefinitions"] : item4 if item4 != null]), "displayName" = item2["displayName"], "externalId" = item2["externalId"] } : key3 => value3 if value3 != null }) if item2 != null]), "filesFolder" = item0["filesFolder"], "isFavoriteByDefault" = item0["isFavoriteByDefault"], "layoutType" = item0["layoutType"], "members" = (item0["members"] == null ? null : [for item2 in item0["members"] : item2 if item2 != null]), "membershipType" = item0["membershipType"], "messages" = (item0["messages"] == null ? null : [for item2 in item0["messages"] : item2 if item2 != null]), "migrationMode" = item0["migrationMode"], "originalCreatedDateTime" = item0["originalCreatedDateTime"], "sharedWithTeams" = (item0["sharedWithTeams"] == null ? null : [for item2 in item0["sharedWithTeams"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "allowedMembers" = (item2["allowedMembers"] == null ? null : [for item4 in item2["allowedMembers"] : item4 if item4 != null]), "displayName" = item2["displayName"], "isHostTeam" = item2["isHostTeam"], "team" = item2["team"], "tenantId" = item2["tenantId"] } : key3 => value3 if value3 != null }) if item2 != null]), "summary" = (item0["summary"] == null ? null : { for key2, value2 in { "@odata.type" = item0["summary"]["odata_type"], "guestsCount" = item0["summary"]["guestsCount"], "hasMembersFromOtherTenants" = item0["summary"]["hasMembersFromOtherTenants"], "membersCount" = item0["summary"]["membersCount"], "ownersCount" = item0["summary"]["ownersCount"] } : key2 => value2 if value2 != null }), "tabs" = (item0["tabs"] == null ? null : [for item2 in item0["tabs"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "configuration" = (item2["configuration"] == null ? null : { for key4, value4 in { "@odata.type" = item2["configuration"]["odata_type"], "contentUrl" = item2["configuration"]["contentUrl"], "entityId" = item2["configuration"]["entityId"], "removeUrl" = item2["configuration"]["removeUrl"], "websiteUrl" = item2["configuration"]["websiteUrl"] } : key4 => value4 if value4 != null }), "displayName" = item2["displayName"], "teamsApp" = item2["teamsApp"] } : key3 => value3 if value3 != null }) if item2 != null]), "tenantId" = item0["tenantId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamwork/deletedTeams"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
