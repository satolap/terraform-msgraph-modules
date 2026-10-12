# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "lastDirectorySyncDateTime" = var.last_directory_sync_date_time
    "lastModifiedDateTime"      = var.last_modified_date_time
    "@odata.type"               = var.odata_type
    "onboardingStatus"          = var.onboarding_status
    "ownerUserPrincipalName"    = var.owner_user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/chromeOSOnboardingSettings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
