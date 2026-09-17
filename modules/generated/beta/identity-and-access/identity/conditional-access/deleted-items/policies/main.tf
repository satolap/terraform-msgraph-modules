# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "conditions"      = (var.conditions == null ? null : { for key0, value0 in { "@odata.type" = var.conditions["odata_type"], "agentContext" = var.conditions["agentContext"], "agentIdRiskLevels" = var.conditions["agentIdRiskLevels"], "agents" = var.conditions["agents"], "applications" = var.conditions["applications"], "authenticationFlows" = var.conditions["authenticationFlows"], "clientAppTypes" = (var.conditions["clientAppTypes"] == null ? null : [for item1 in var.conditions["clientAppTypes"] : item1 if item1 != null]), "clientApplications" = var.conditions["clientApplications"], "deviceStates" = var.conditions["deviceStates"], "devices" = var.conditions["devices"], "insiderRiskLevels" = var.conditions["insiderRiskLevels"], "locations" = var.conditions["locations"], "platforms" = var.conditions["platforms"], "servicePrincipalRiskLevels" = (var.conditions["servicePrincipalRiskLevels"] == null ? null : [for item1 in var.conditions["servicePrincipalRiskLevels"] : item1 if item1 != null]), "signInRiskLevels" = (var.conditions["signInRiskLevels"] == null ? null : [for item1 in var.conditions["signInRiskLevels"] : item1 if item1 != null]), "userRiskLevels" = (var.conditions["userRiskLevels"] == null ? null : [for item1 in var.conditions["userRiskLevels"] : item1 if item1 != null]), "users" = var.conditions["users"] } : key0 => value0 if value0 != null })
    "deletedDateTime" = var.deleted_date_time
    "description"     = var.description
    "displayName"     = var.display_name
    "grantControls"   = var.grant_controls
    "@odata.type"     = var.odata_type
    "sessionControls" = var.session_controls
    "state"           = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identity/conditionalAccess/deletedItems/policies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
