# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "applyDescription" = var.apply_description
    "decision"         = var.decision
    "insights"         = (var.insights == null ? null : [for item0 in var.insights : item0 if item0 != null])
    "instance"         = var.instance
    "justification"    = var.justification
    "@odata.type"      = var.odata_type
    "permission"       = (var.permission == null ? null : { for key0, value0 in { "@odata.type" = var.permission["odata_type"], "description" = var.permission["description"], "displayName" = var.permission["displayName"], "id" = var.permission["id"], "type" = var.permission["type"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/accessReviews/instances/${urlencode(var.access_review_instance_id)}/decisions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
