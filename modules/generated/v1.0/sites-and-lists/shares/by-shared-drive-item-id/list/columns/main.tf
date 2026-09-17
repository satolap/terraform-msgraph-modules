# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "boolean"               = var.boolean
    "calculated"            = var.calculated
    "choice"                = var.choice
    "columnGroup"           = var.column_group
    "contentApprovalStatus" = var.content_approval_status
    "currency"              = var.currency
    "dateTime"              = var.date_time
    "defaultValue"          = var.default_value
    "description"           = var.description
    "displayName"           = var.display_name
    "enforceUniqueValues"   = var.enforce_unique_values
    "geolocation"           = var.geolocation
    "hidden"                = var.hidden
    "hyperlinkOrPicture"    = var.hyperlink_or_picture
    "indexed"               = var.indexed
    "isDeletable"           = var.is_deletable
    "isSealed"              = var.is_sealed
    "lookup"                = var.lookup
    "name"                  = var.name
    "number"                = var.number
    "@odata.type"           = var.odata_type
    "personOrGroup"         = var.person_or_group
    "propagateChanges"      = var.propagate_changes
    "readOnly"              = var.read_only
    "required"              = var.required
    "sourceColumn"          = var.source_column
    "term"                  = var.term
    "text"                  = var.text
    "thumbnail"             = var.thumbnail
    "validation"            = var.validation
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "shares/${urlencode(var.shared_drive_item_id)}/list/columns"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
