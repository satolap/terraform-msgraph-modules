# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"                  = var.display_name
    "email"                        = var.email
    "objectId"                     = var.object_id
    "@odata.type"                  = var.odata_type
    "onPremisesSecurityIdentifier" = var.on_premises_security_identifier
    "principalName"                = var.principal_name
    "subjectLifecycle"             = var.subject_lifecycle
    "subjectType"                  = var.subject_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/subjects"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
