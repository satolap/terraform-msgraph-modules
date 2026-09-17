# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deletedDateTime"               = var.deleted_date_time
    "deletedMembers"                = (var.deleted_members == null ? null : [for item0 in var.deleted_members : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deletedDateTime" = item0["deletedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                   = var.description
    "displayName"                   = var.display_name
    "extensions"                    = (var.extensions == null ? null : [for item0 in var.extensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isMemberManagementRestricted"  = var.is_member_management_restricted
    "members"                       = (var.members == null ? null : [for item0 in var.members : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deletedDateTime" = item0["deletedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "membershipRule"                = var.membership_rule
    "membershipRuleProcessingState" = var.membership_rule_processing_state
    "membershipType"                = var.membership_type
    "@odata.type"                   = var.odata_type
    "scopedRoleMembers"             = (var.scoped_role_members == null ? null : [for item0 in var.scoped_role_members : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "administrativeUnitId" = item0["administrativeUnitId"], "roleId" = item0["roleId"], "roleMemberInfo" = (item0["roleMemberInfo"] == null ? null : { for key2, value2 in { "@odata.type" = item0["roleMemberInfo"]["odata_type"], "displayName" = item0["roleMemberInfo"]["displayName"], "id" = item0["roleMemberInfo"]["id"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "visibility"                    = var.visibility
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "administrativeUnits"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
