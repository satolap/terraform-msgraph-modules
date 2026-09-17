# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description" = var.description
    "displayName" = var.display_name
    "memberCount" = var.member_count
    "members"     = (var.members == null ? null : [for item0 in var.members : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "tenantId" = item0["tenantId"], "userId" = item0["userId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type" = var.odata_type
    "tagType"     = var.tag_type
    "teamId"      = var.team_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/team/tags"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
