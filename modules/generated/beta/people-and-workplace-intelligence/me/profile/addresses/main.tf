# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedAudiences"     = var.allowed_audiences
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "detail"               = (var.detail == null ? null : { for key0, value0 in { "@odata.type" = var.detail["odata_type"], "city" = var.detail["city"], "countryOrRegion" = var.detail["countryOrRegion"], "postOfficeBox" = var.detail["postOfficeBox"], "postalCode" = var.detail["postalCode"], "state" = var.detail["state"], "street" = var.detail["street"], "type" = var.detail["type"] } : key0 => value0 if value0 != null })
    "displayName"          = var.display_name
    "geoCoordinates"       = (var.geo_coordinates == null ? null : { for key0, value0 in { "@odata.type" = var.geo_coordinates["odata_type"], "latitude" = var.geo_coordinates["latitude"], "longitude" = var.geo_coordinates["longitude"] } : key0 => value0 if value0 != null })
    "source"               = (var.graph_source == null ? null : { for key0, value0 in { "@odata.type" = var.graph_source["odata_type"], "type" = (var.graph_source["type"] == null ? null : [for item1 in var.graph_source["type"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "inference"            = (var.inference == null ? null : { for key0, value0 in { "@odata.type" = var.inference["odata_type"], "confidenceScore" = var.inference["confidenceScore"], "userHasVerifiedAccuracy" = var.inference["userHasVerifiedAccuracy"] } : key0 => value0 if value0 != null })
    "isSearchable"         = var.is_searchable
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "sources"              = (var.sources == null ? null : [for item0 in var.sources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isDefaultSource" = item0["isDefaultSource"], "properties" = (item0["properties"] == null ? null : [for item2 in item0["properties"] : item2 if item2 != null]), "sourceId" = item0["sourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/profile/addresses"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
