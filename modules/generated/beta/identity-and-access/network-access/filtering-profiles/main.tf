# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "conditionalAccessPolicies" = (var.conditional_access_policies == null ? null : [for item0 in var.conditional_access_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "modifiedDateTime" = item0["modifiedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"           = var.created_date_time
    "description"               = var.description
    "version"                   = var.graph_version
    "lastModifiedDateTime"      = var.last_modified_date_time
    "name"                      = var.name
    "@odata.type"               = var.odata_type
    "policies"                  = (var.policies == null ? null : [for item0 in var.policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "policy" = (item0["policy"] == null ? null : { for key2, value2 in { "@odata.type" = item0["policy"]["odata_type"], "description" = item0["policy"]["description"], "name" = item0["policy"]["name"], "policyRules" = (item0["policy"]["policyRules"] == null ? null : [for item3 in item0["policy"]["policyRules"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "name" = item3["name"] } : key4 => value4 if value4 != null }) if item3 != null]), "version" = item0["policy"]["version"] } : key2 => value2 if value2 != null }), "state" = item0["state"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "priority"                  = var.priority
    "state"                     = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/filteringProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
