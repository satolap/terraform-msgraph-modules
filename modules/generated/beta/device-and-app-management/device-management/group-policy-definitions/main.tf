# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "category"                  = var.category
    "categoryPath"              = var.category_path
    "classType"                 = var.class_type
    "definitionFile"            = var.definition_file
    "displayName"               = var.display_name
    "explainText"               = var.explain_text
    "version"                   = var.graph_version
    "groupPolicyCategoryId"     = var.group_policy_category_id
    "hasRelatedDefinitions"     = var.has_related_definitions
    "lastModifiedDateTime"      = var.last_modified_date_time
    "minDeviceCspVersion"       = var.min_device_csp_version
    "minUserCspVersion"         = var.min_user_csp_version
    "nextVersionDefinition"     = var.next_version_definition
    "@odata.type"               = var.odata_type
    "policyType"                = var.policy_type
    "presentations"             = (var.presentations == null ? null : [for item0 in var.presentations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "definition" = item0["definition"], "label" = item0["label"], "lastModifiedDateTime" = item0["lastModifiedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "previousVersionDefinition" = var.previous_version_definition
    "supportedOn"               = var.supported_on
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/groupPolicyDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
