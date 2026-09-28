# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "boolean"               = var.boolean
    "calculated"            = (var.calculated == null ? null : { for key0, value0 in { "@odata.type" = var.calculated["odata_type"], "format" = var.calculated["format"], "formula" = var.calculated["formula"], "outputType" = var.calculated["outputType"] } : key0 => value0 if value0 != null })
    "choice"                = (var.choice == null ? null : { for key0, value0 in { "@odata.type" = var.choice["odata_type"], "allowTextEntry" = var.choice["allowTextEntry"], "choices" = (var.choice["choices"] == null ? null : [for item1 in var.choice["choices"] : item1 if item1 != null]), "displayAs" = var.choice["displayAs"] } : key0 => value0 if value0 != null })
    "columnGroup"           = var.column_group
    "contentApprovalStatus" = var.content_approval_status
    "currency"              = (var.currency == null ? null : { for key0, value0 in { "@odata.type" = var.currency["odata_type"], "locale" = var.currency["locale"] } : key0 => value0 if value0 != null })
    "dateTime"              = (var.date_time == null ? null : { for key0, value0 in { "@odata.type" = var.date_time["odata_type"], "displayAs" = var.date_time["displayAs"], "format" = var.date_time["format"] } : key0 => value0 if value0 != null })
    "defaultValue"          = (var.default_value == null ? null : { for key0, value0 in { "@odata.type" = var.default_value["odata_type"], "formula" = var.default_value["formula"], "value" = var.default_value["value"] } : key0 => value0 if value0 != null })
    "description"           = var.description
    "displayName"           = var.display_name
    "enforceUniqueValues"   = var.enforce_unique_values
    "geolocation"           = var.geolocation
    "hidden"                = var.hidden
    "hyperlinkOrPicture"    = (var.hyperlink_or_picture == null ? null : { for key0, value0 in { "@odata.type" = var.hyperlink_or_picture["odata_type"], "isPicture" = var.hyperlink_or_picture["isPicture"] } : key0 => value0 if value0 != null })
    "indexed"               = var.indexed
    "isDeletable"           = var.is_deletable
    "isSealed"              = var.is_sealed
    "lookup"                = (var.lookup == null ? null : { for key0, value0 in { "@odata.type" = var.lookup["odata_type"], "allowMultipleValues" = var.lookup["allowMultipleValues"], "allowUnlimitedLength" = var.lookup["allowUnlimitedLength"], "columnName" = var.lookup["columnName"], "listId" = var.lookup["listId"], "primaryLookupColumnId" = var.lookup["primaryLookupColumnId"] } : key0 => value0 if value0 != null })
    "name"                  = var.name
    "number"                = (var.number == null ? null : { for key0, value0 in { "@odata.type" = var.number["odata_type"], "decimalPlaces" = var.number["decimalPlaces"], "displayAs" = var.number["displayAs"], "maximum" = var.number["maximum"], "minimum" = var.number["minimum"] } : key0 => value0 if value0 != null })
    "@odata.type"           = var.odata_type
    "personOrGroup"         = (var.person_or_group == null ? null : { for key0, value0 in { "@odata.type" = var.person_or_group["odata_type"], "allowMultipleSelection" = var.person_or_group["allowMultipleSelection"], "chooseFromType" = var.person_or_group["chooseFromType"], "displayAs" = var.person_or_group["displayAs"] } : key0 => value0 if value0 != null })
    "propagateChanges"      = var.propagate_changes
    "readOnly"              = var.read_only
    "required"              = var.required
    "sourceColumn"          = var.source_column
    "term"                  = (var.term == null ? null : { for key0, value0 in { "@odata.type" = var.term["odata_type"], "allowMultipleValues" = var.term["allowMultipleValues"], "parentTerm" = var.term["parentTerm"], "showFullyQualifiedName" = var.term["showFullyQualifiedName"], "termSet" = var.term["termSet"] } : key0 => value0 if value0 != null })
    "text"                  = (var.text == null ? null : { for key0, value0 in { "@odata.type" = var.text["odata_type"], "allowMultipleLines" = var.text["allowMultipleLines"], "appendChangesToExistingText" = var.text["appendChangesToExistingText"], "linesForEditing" = var.text["linesForEditing"], "maxLength" = var.text["maxLength"], "textType" = var.text["textType"] } : key0 => value0 if value0 != null })
    "thumbnail"             = var.thumbnail
    "validation"            = (var.validation == null ? null : { for key0, value0 in { "@odata.type" = var.validation["odata_type"], "defaultLanguage" = var.validation["defaultLanguage"], "descriptions" = (var.validation["descriptions"] == null ? null : [for item1 in var.validation["descriptions"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "displayName" = item1["displayName"], "languageTag" = item1["languageTag"] } : key2 => value2 if value2 != null }) if item1 != null]), "formula" = var.validation["formula"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/list/columns"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
