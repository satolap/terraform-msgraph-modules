# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deleted"                 = (var.deleted == null ? null : { for key0, value0 in { "@odata.type" = var.deleted["odata_type"], "state" = var.deleted["state"] } : key0 => value0 if value0 != null })
    "@odata.type"             = var.odata_type
    "sourceOrganizationId"    = var.source_organization_id
    "sourceUserIdentity"      = var.source_user_identity
    "targetUserIdentity"      = var.target_user_identity
    "targetUserMigrationData" = (var.target_user_migration_data == null ? null : { for key0, value0 in { "@odata.type" = var.target_user_migration_data["odata_type"], "email" = var.target_user_migration_data["email"] } : key0 => value0 if value0 != null })
    "userType"                = var.user_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/sharePoint/migrations/crossOrganizationUserMappings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
