# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "address"         = var.address
    "companyName"     = var.company_name
    "deletedDateTime" = var.deleted_date_time
    "department"      = var.department
    "displayName"     = var.display_name
    "isDiscoverable"  = var.is_discoverable
    "isEnabled"       = var.is_enabled
    "jobTitle"        = var.job_title
    "@odata.type"     = var.odata_type
    "phoneNumber"     = var.phone_number
    "supervisorId"    = var.supervisor_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/pendingExternalUserProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
