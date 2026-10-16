# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allMembers"              = (var.all_members == null ? null : [for item0 in var.all_members : item0 if item0 != null])
    "description"             = var.description
    "displayName"             = var.display_name
    "enabledApps"             = (var.enabled_apps == null ? null : [for item0 in var.enabled_apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appDefinitions" = (item0["appDefinitions"] == null ? null : [for item2 in item0["appDefinitions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "allowedInstallationScopes" = item2["allowedInstallationScopes"], "authorization" = (item2["authorization"] == null ? null : { for key4, value4 in { "@odata.type" = item2["authorization"]["odata_type"], "clientAppId" = item2["authorization"]["clientAppId"], "requiredPermissionSet" = item2["authorization"]["requiredPermissionSet"] } : key4 => value4 if value4 != null }), "azureADAppId" = item2["azureADAppId"], "bot" = item2["bot"], "colorIcon" = item2["colorIcon"], "createdBy" = item2["createdBy"], "dashboardCards" = (item2["dashboardCards"] == null ? null : [for item4 in item2["dashboardCards"] : item4 if item4 != null]), "description" = item2["description"], "displayName" = item2["displayName"], "lastModifiedDateTime" = item2["lastModifiedDateTime"], "outlineIcon" = item2["outlineIcon"], "publishingState" = item2["publishingState"], "shortdescription" = item2["shortdescription"], "teamsAppId" = item2["teamsAppId"], "version" = item2["version"] } : key3 => value3 if value3 != null }) if item2 != null]), "displayName" = item0["displayName"], "externalId" = item0["externalId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "filesFolder"             = var.files_folder
    "isFavoriteByDefault"     = var.is_favorite_by_default
    "joinedUsers"             = (var.joined_users == null ? null : [for item0 in var.joined_users : item0 if item0 != null])
    "layoutType"              = var.layout_type
    "members"                 = (var.members == null ? null : [for item0 in var.members : item0 if item0 != null])
    "membershipType"          = var.membership_type
    "messages"                = (var.messages == null ? null : [for item0 in var.messages : item0 if item0 != null])
    "migrationMode"           = var.migration_mode
    "moderationSettings"      = (var.moderation_settings == null ? null : { for key0, value0 in { "@odata.type" = var.moderation_settings["odata_type"], "allowNewMessageFromBots" = var.moderation_settings["allowNewMessageFromBots"], "allowNewMessageFromConnectors" = var.moderation_settings["allowNewMessageFromConnectors"], "replyRestriction" = var.moderation_settings["replyRestriction"], "userNewMessageRestriction" = var.moderation_settings["userNewMessageRestriction"] } : key0 => value0 if value0 != null })
    "@odata.type"             = var.odata_type
    "originalCreatedDateTime" = var.original_created_date_time
    "sharedWithTeams"         = (var.shared_with_teams == null ? null : [for item0 in var.shared_with_teams : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowedMembers" = (item0["allowedMembers"] == null ? null : [for item2 in item0["allowedMembers"] : item2 if item2 != null]), "displayName" = item0["displayName"], "isHostTeam" = item0["isHostTeam"], "team" = item0["team"], "tenantId" = item0["tenantId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "summary"                 = (var.summary == null ? null : { for key0, value0 in { "@odata.type" = var.summary["odata_type"], "guestsCount" = var.summary["guestsCount"], "hasMembersFromOtherTenants" = var.summary["hasMembersFromOtherTenants"], "membersCount" = var.summary["membersCount"], "ownersCount" = var.summary["ownersCount"] } : key0 => value0 if value0 != null })
    "tabs"                    = (var.tabs == null ? null : [for item0 in var.tabs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "configuration" = (item0["configuration"] == null ? null : { for key2, value2 in { "@odata.type" = item0["configuration"]["odata_type"], "contentUrl" = item0["configuration"]["contentUrl"], "entityId" = item0["configuration"]["entityId"], "removeUrl" = item0["configuration"]["removeUrl"], "websiteUrl" = item0["configuration"]["websiteUrl"] } : key2 => value2 if value2 != null }), "displayName" = item0["displayName"], "messageId" = item0["messageId"], "sortOrderIndex" = item0["sortOrderIndex"], "teamsApp" = item0["teamsApp"], "teamsAppId" = item0["teamsAppId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "tenantId"                = var.tenant_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamTemplateDefinition/${urlencode(var.team_template_definition_id)}/teamDefinition/channels"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
