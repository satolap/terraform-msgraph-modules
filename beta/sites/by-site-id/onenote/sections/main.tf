# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "displayName"          = var.display_name
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "links"                = (var.links == null ? null : { for key0, value0 in { "@odata.type" = var.links["odata_type"], "oneNoteClientUrl" = (var.links["oneNoteClientUrl"] == null ? null : { for key1, value1 in { "@odata.type" = var.links["oneNoteClientUrl"]["odata_type"], "href" = var.links["oneNoteClientUrl"]["href"] } : key1 => value1 if value1 != null }), "oneNoteWebUrl" = (var.links["oneNoteWebUrl"] == null ? null : { for key1, value1 in { "@odata.type" = var.links["oneNoteWebUrl"]["odata_type"], "href" = var.links["oneNoteWebUrl"]["href"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "@odata.type"          = var.odata_type
    "self"                 = var.self
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site_id)}/onenote/sections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
