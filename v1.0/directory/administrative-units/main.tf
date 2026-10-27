# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deletedDateTime"               = var.deleted_date_time
    "description"                   = var.description
    "displayName"                   = var.display_name
    "extensions"                    = (var.extensions == null ? null : [for item0 in var.extensions : item0 if item0 != null])
    "isMemberManagementRestricted"  = var.is_member_management_restricted
    "members"                       = (var.members == null ? null : [for item0 in var.members : item0 if item0 != null])
    "membershipRule"                = var.membership_rule
    "membershipRuleProcessingState" = var.membership_rule_processing_state
    "membershipType"                = var.membership_type
    "@odata.type"                   = var.odata_type
    "scopedRoleMembers"             = (var.scoped_role_members == null ? null : [for item0 in var.scoped_role_members : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "administrativeUnitId" = item0["administrativeUnitId"], "roleId" = item0["roleId"], "roleMemberInfo" = item0["roleMemberInfo"] } : key1 => value1 if value1 != null }) if item0 != null])
    "visibility"                    = var.visibility
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "directory/administrativeUnits"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["extensions", "members", "scopedRoleMembers"], name)])]))))] } : null

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
