# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "isAnswerEditable" = var.is_answer_editable
    "isRequired"       = var.is_required
    "localizations"    = (var.localizations == null ? null : [for item0 in var.localizations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "languageCode" = item0["languageCode"], "text" = item0["text"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"      = var.odata_type
    "sequence"         = var.sequence
    "text"             = var.text
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/assignmentPolicies/${urlencode(var.access_package_assignment_policy_id)}/questions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
