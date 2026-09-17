# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedMembers" = (var.allowed_members == null ? null : [for item0 in var.allowed_members : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "roles" = (item0["roles"] == null ? null : [for item2 in item0["roles"] : item2 if item2 != null]), "visibleHistoryStartDateTime" = item0["visibleHistoryStartDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"    = var.display_name
    "isHostTeam"     = var.is_host_team
    "@odata.type"    = var.odata_type
    "team"           = var.team
    "tenantId"       = var.tenant_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teams/${urlencode(var.team_id)}/primaryChannel/sharedWithTeams"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
