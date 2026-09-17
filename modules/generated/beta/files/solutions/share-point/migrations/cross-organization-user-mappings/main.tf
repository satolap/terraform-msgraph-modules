# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deleted"                 = var.deleted
    "@odata.type"             = var.odata_type
    "sourceOrganizationId"    = var.source_organization_id
    "sourceUserIdentity"      = var.source_user_identity
    "targetUserIdentity"      = var.target_user_identity
    "targetUserMigrationData" = var.target_user_migration_data
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
