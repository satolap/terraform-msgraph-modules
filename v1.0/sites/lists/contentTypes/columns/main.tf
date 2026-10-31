# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "boolean"               = var.boolean
    "calculated"            = (var.calculated == null ? null : { for key0, value0 in { "@odata.type" = var.calculated["odata_type"], "format" = var.calculated["format"], "formula" = var.calculated["formula"], "outputType" = var.calculated["outputType"] } : key0 => value0 if value0 != null })
    "choice"                = (var.choice == null ? null : { for key0, value0 in { "@odata.type" = var.choice["odata_type"], "allowTextEntry" = var.choice["allowTextEntry"], "choices" = (var.choice["choices"] == null ? null : [for item1 in var.choice["choices"] : item1 if item1 != null]), "displayAs" = var.choice["displayAs"] } : key0 => value0 if value0 != null })
    "columnGroup"           = var.columnGroup
    "contentApprovalStatus" = var.contentApprovalStatus
    "currency"              = (var.currency == null ? null : { for key0, value0 in { "@odata.type" = var.currency["odata_type"], "locale" = var.currency["locale"] } : key0 => value0 if value0 != null })
    "dateTime"              = (var.dateTime == null ? null : { for key0, value0 in { "@odata.type" = var.dateTime["odata_type"], "displayAs" = var.dateTime["displayAs"], "format" = var.dateTime["format"] } : key0 => value0 if value0 != null })
    "defaultValue"          = (var.defaultValue == null ? null : { for key0, value0 in { "@odata.type" = var.defaultValue["odata_type"], "formula" = var.defaultValue["formula"], "value" = var.defaultValue["value"] } : key0 => value0 if value0 != null })
    "description"           = var.description
    "displayName"           = var.displayName
    "enforceUniqueValues"   = var.enforceUniqueValues
    "geolocation"           = var.geolocation
    "hidden"                = var.hidden
    "hyperlinkOrPicture"    = (var.hyperlinkOrPicture == null ? null : { for key0, value0 in { "@odata.type" = var.hyperlinkOrPicture["odata_type"], "isPicture" = var.hyperlinkOrPicture["isPicture"] } : key0 => value0 if value0 != null })
    "indexed"               = var.indexed
    "isDeletable"           = var.isDeletable
    "isSealed"              = var.isSealed
    "lookup"                = (var.lookup == null ? null : { for key0, value0 in { "@odata.type" = var.lookup["odata_type"], "allowMultipleValues" = var.lookup["allowMultipleValues"], "allowUnlimitedLength" = var.lookup["allowUnlimitedLength"], "columnName" = var.lookup["columnName"], "listId" = var.lookup["listId"], "primaryLookupColumnId" = var.lookup["primaryLookupColumnId"] } : key0 => value0 if value0 != null })
    "name"                  = var.name
    "number"                = (var.number == null ? null : { for key0, value0 in { "@odata.type" = var.number["odata_type"], "decimalPlaces" = var.number["decimalPlaces"], "displayAs" = var.number["displayAs"], "maximum" = var.number["maximum"], "minimum" = var.number["minimum"] } : key0 => value0 if value0 != null })
    "@odata.type"           = var.odata_type
    "personOrGroup"         = (var.personOrGroup == null ? null : { for key0, value0 in { "@odata.type" = var.personOrGroup["odata_type"], "allowMultipleSelection" = var.personOrGroup["allowMultipleSelection"], "chooseFromType" = var.personOrGroup["chooseFromType"], "displayAs" = var.personOrGroup["displayAs"] } : key0 => value0 if value0 != null })
    "propagateChanges"      = var.propagateChanges
    "readOnly"              = var.readOnly
    "required"              = var.required
    "sourceColumn"          = var.sourceColumn
    "term"                  = (var.term == null ? null : { for key0, value0 in { "@odata.type" = var.term["odata_type"], "allowMultipleValues" = var.term["allowMultipleValues"], "parentTerm" = var.term["parentTerm"], "showFullyQualifiedName" = var.term["showFullyQualifiedName"], "termSet" = var.term["termSet"] } : key0 => value0 if value0 != null })
    "text"                  = (var.text == null ? null : { for key0, value0 in { "@odata.type" = var.text["odata_type"], "allowMultipleLines" = var.text["allowMultipleLines"], "appendChangesToExistingText" = var.text["appendChangesToExistingText"], "linesForEditing" = var.text["linesForEditing"], "maxLength" = var.text["maxLength"], "textType" = var.text["textType"] } : key0 => value0 if value0 != null })
    "thumbnail"             = var.thumbnail
    "validation"            = (var.validation == null ? null : { for key0, value0 in { "@odata.type" = var.validation["odata_type"], "defaultLanguage" = var.validation["defaultLanguage"], "descriptions" = (var.validation["descriptions"] == null ? null : [for item1 in var.validation["descriptions"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "displayName" = item1["displayName"], "languageTag" = item1["languageTag"] } : key2 => value2 if value2 != null }) if item1 != null]), "formula" = var.validation["formula"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site-id)}/lists/${urlencode(var.list-id)}/contentTypes/${urlencode(var.contentType-id)}/columns"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["sourceColumn"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
