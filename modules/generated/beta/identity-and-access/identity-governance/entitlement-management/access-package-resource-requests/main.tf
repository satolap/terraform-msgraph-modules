# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessPackageResource" = var.access_package_resource
    "catalogId"             = var.catalog_id
    "executeImmediately"    = var.execute_immediately
    "expirationDateTime"    = var.expiration_date_time
    "isValidationOnly"      = var.is_validation_only
    "justification"         = var.justification
    "@odata.type"           = var.odata_type
    "requestStatus"         = var.request_status
    "requestType"           = var.request_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/accessPackageResourceRequests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
