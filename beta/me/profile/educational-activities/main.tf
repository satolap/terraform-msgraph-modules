# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedAudiences"     = var.allowed_audiences
    "completionMonthYear"  = var.completion_month_year
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "endMonthYear"         = var.end_month_year
    "source"               = (var.graph_source == null ? null : { for key0, value0 in { "@odata.type" = var.graph_source["odata_type"], "type" = (var.graph_source["type"] == null ? null : [for item1 in var.graph_source["type"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "inference"            = (var.inference == null ? null : { for key0, value0 in { "@odata.type" = var.inference["odata_type"], "confidenceScore" = var.inference["confidenceScore"], "userHasVerifiedAccuracy" = var.inference["userHasVerifiedAccuracy"] } : key0 => value0 if value0 != null })
    "institution"          = (var.institution == null ? null : { for key0, value0 in { "@odata.type" = var.institution["odata_type"], "description" = var.institution["description"], "displayName" = var.institution["displayName"], "location" = (var.institution["location"] == null ? null : { for key1, value1 in { "@odata.type" = var.institution["location"]["odata_type"], "city" = var.institution["location"]["city"], "countryOrRegion" = var.institution["location"]["countryOrRegion"], "postOfficeBox" = var.institution["location"]["postOfficeBox"], "postalCode" = var.institution["location"]["postalCode"], "state" = var.institution["location"]["state"], "street" = var.institution["location"]["street"], "type" = var.institution["location"]["type"] } : key1 => value1 if value1 != null }), "webUrl" = var.institution["webUrl"] } : key0 => value0 if value0 != null })
    "isSearchable"         = var.is_searchable
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "program"              = (var.program == null ? null : { for key0, value0 in { "@odata.type" = var.program["odata_type"], "abbreviation" = var.program["abbreviation"], "activities" = (var.program["activities"] == null ? null : [for item1 in var.program["activities"] : item1 if item1 != null]), "awards" = (var.program["awards"] == null ? null : [for item1 in var.program["awards"] : item1 if item1 != null]), "description" = var.program["description"], "displayName" = var.program["displayName"], "fieldsOfStudy" = (var.program["fieldsOfStudy"] == null ? null : [for item1 in var.program["fieldsOfStudy"] : item1 if item1 != null]), "grade" = var.program["grade"], "notes" = var.program["notes"], "webUrl" = var.program["webUrl"] } : key0 => value0 if value0 != null })
    "sources"              = (var.sources == null ? null : [for item0 in var.sources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isDefaultSource" = item0["isDefaultSource"], "properties" = (item0["properties"] == null ? null : [for item2 in item0["properties"] : item2 if item2 != null]), "sourceId" = item0["sourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "startMonthYear"       = var.start_month_year
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/profile/educationalActivities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
