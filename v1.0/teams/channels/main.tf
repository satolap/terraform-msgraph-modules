# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allMembers"              = (var.allMembers == null ? null : [for item0 in var.allMembers : item0 if item0 != null])
    "description"             = var.description
    "displayName"             = var.displayName
    "enabledApps"             = (var.enabledApps == null ? null : [for item0 in var.enabledApps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appDefinitions" = (item0["appDefinitions"] == null ? null : [for item2 in item0["appDefinitions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "authorization" = (item2["authorization"] == null ? null : { for key4, value4 in { "@odata.type" = item2["authorization"]["odata_type"], "clientAppId" = item2["authorization"]["clientAppId"], "requiredPermissionSet" = item2["authorization"]["requiredPermissionSet"] } : key4 => value4 if value4 != null }), "bot" = item2["bot"], "createdBy" = item2["createdBy"], "description" = item2["description"], "displayName" = item2["displayName"], "lastModifiedDateTime" = item2["lastModifiedDateTime"], "publishingState" = item2["publishingState"], "shortDescription" = item2["shortDescription"], "teamsAppId" = item2["teamsAppId"], "version" = item2["version"] } : key3 => value3 if value3 != null }) if item2 != null]), "displayName" = item0["displayName"], "externalId" = item0["externalId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "filesFolder"             = var.filesFolder
    "isFavoriteByDefault"     = var.isFavoriteByDefault
    "layoutType"              = var.layoutType
    "members"                 = (var.members == null ? null : [for item0 in var.members : item0 if item0 != null])
    "membershipType"          = var.membershipType
    "messages"                = (var.messages == null ? null : [for item0 in var.messages : item0 if item0 != null])
    "migrationMode"           = var.migrationMode
    "@odata.type"             = var.odata_type
    "originalCreatedDateTime" = var.originalCreatedDateTime
    "sharedWithTeams"         = (var.sharedWithTeams == null ? null : [for item0 in var.sharedWithTeams : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowedMembers" = (item0["allowedMembers"] == null ? null : [for item2 in item0["allowedMembers"] : item2 if item2 != null]), "displayName" = item0["displayName"], "isHostTeam" = item0["isHostTeam"], "team" = item0["team"], "tenantId" = item0["tenantId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "summary"                 = (var.summary == null ? null : { for key0, value0 in { "@odata.type" = var.summary["odata_type"], "guestsCount" = var.summary["guestsCount"], "hasMembersFromOtherTenants" = var.summary["hasMembersFromOtherTenants"], "membersCount" = var.summary["membersCount"], "ownersCount" = var.summary["ownersCount"] } : key0 => value0 if value0 != null })
    "tabs"                    = (var.tabs == null ? null : [for item0 in var.tabs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "configuration" = (item0["configuration"] == null ? null : { for key2, value2 in { "@odata.type" = item0["configuration"]["odata_type"], "contentUrl" = item0["configuration"]["contentUrl"], "entityId" = item0["configuration"]["entityId"], "removeUrl" = item0["configuration"]["removeUrl"], "websiteUrl" = item0["configuration"]["websiteUrl"] } : key2 => value2 if value2 != null }), "displayName" = item0["displayName"], "teamsApp" = item0["teamsApp"] } : key1 => value1 if value1 != null }) if item0 != null])
    "tenantId"                = var.tenantId
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "teams/${urlencode(var.team-id)}/channels"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["allMembers", "enabledApps", "filesFolder", "members", "messages", "sharedWithTeams", "tabs"], name)])]))))] } : null

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
