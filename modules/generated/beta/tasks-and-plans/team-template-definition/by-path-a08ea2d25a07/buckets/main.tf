# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "creationSource" = var.creation_source
    "name"           = var.name
    "@odata.type"    = var.odata_type
    "orderHint"      = var.order_hint
    "planId"         = var.plan_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamTemplateDefinition/${urlencode(var.team_template_definition_id)}/teamDefinition/channels/${urlencode(var.channel_id)}/planner/plans/${urlencode(var.planner_plan_id)}/buckets"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
