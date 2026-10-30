# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "administrativeUnitId" = var.administrative_unit_id_2
    "@odata.type"          = var.odata_type
    "roleId"               = var.role_id
    "roleMemberInfo"       = var.role_member_info
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
  # Reviewed replication errors (GB-consistency-and-errors-502): a fixed message, never caller input, and only
  # when the request references another object. The provider already retries 408, 429, 500, 502, 503 and 504.
  replication_retry_errors = concat(
    try(local.body["roleMemberInfo"] != null, false) ? ["^\\s*\\{\\s*\"error\"\\s*:\\s*\\{\\s*\"code\"\\s*:\\s*\"(?:Request_)?BadRequest\"\\s*,\\s*\"message\"\\s*:\\s*\"The source resource object or one of the objects being referenced don(?:'|\\\\u0027)t exist\\.\"\\s*[,}]"] : [],
  )
}

resource "msgraph_resource" "this" {
  url                     = "directory/administrativeUnits/${urlencode(var.administrative_unit_id)}/scopedRoleMembers"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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

  retry = length(local.replication_retry_errors) == 0 ? null : {
    error_message_regex = local.replication_retry_errors
  }

  lifecycle {
    precondition {
      condition     = !can(regex("The source resource object or one of the objects being referenced don't exist", jsonencode(local.body)))
      error_message = "No request value may contain the text of the reviewed replication error (scoped-role-member-source-not-replicated): the provider would retry a successful response that echoes it."
    }
  }
}
