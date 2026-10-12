# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "fromTerm"     = var.from_term
    "@odata.type"  = var.odata_type
    "relationship" = var.relationship
    "set"          = var.set
    "toTerm"       = var.to_term
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site_id)}/termStores/${urlencode(var.store_id)}/sets/${urlencode(var.set_id)}/parentGroup/sets/${urlencode(var.set_id1)}/terms/${urlencode(var.term_id)}/children/${urlencode(var.term_id1)}/relations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
