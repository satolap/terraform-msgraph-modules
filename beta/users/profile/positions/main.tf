# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedAudiences"     = var.allowed_audiences
    "categories"           = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "colleagues"           = (var.colleagues == null ? null : [for item0 in var.colleagues : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "relationship" = item0["relationship"], "userId" = item0["userId"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "detail"               = (var.detail == null ? null : { for key0, value0 in { "@odata.type" = var.detail["odata_type"], "company" = (var.detail["company"] == null ? null : { for key1, value1 in { "@odata.type" = var.detail["company"]["odata_type"], "address" = (var.detail["company"]["address"] == null ? null : { for key2, value2 in { "@odata.type" = var.detail["company"]["address"]["odata_type"], "city" = var.detail["company"]["address"]["city"], "countryOrRegion" = var.detail["company"]["address"]["countryOrRegion"], "postOfficeBox" = var.detail["company"]["address"]["postOfficeBox"], "postalCode" = var.detail["company"]["address"]["postalCode"], "state" = var.detail["company"]["address"]["state"], "street" = var.detail["company"]["address"]["street"], "type" = var.detail["company"]["address"]["type"] } : key2 => value2 if value2 != null }), "companyCode" = var.detail["company"]["companyCode"], "costCenter" = var.detail["company"]["costCenter"], "department" = var.detail["company"]["department"], "displayName" = var.detail["company"]["displayName"], "division" = var.detail["company"]["division"], "officeLocation" = var.detail["company"]["officeLocation"], "pronunciation" = var.detail["company"]["pronunciation"], "secondaryDepartment" = var.detail["company"]["secondaryDepartment"], "webUrl" = var.detail["company"]["webUrl"] } : key1 => value1 if value1 != null }), "description" = var.detail["description"], "employeeId" = var.detail["employeeId"], "employeeType" = var.detail["employeeType"], "endMonthYear" = var.detail["endMonthYear"], "jobTitle" = var.detail["jobTitle"], "layer" = var.detail["layer"], "level" = var.detail["level"], "role" = var.detail["role"], "secondaryJobTitle" = var.detail["secondaryJobTitle"], "secondaryRole" = var.detail["secondaryRole"], "startMonthYear" = var.detail["startMonthYear"], "summary" = var.detail["summary"] } : key0 => value0 if value0 != null })
    "source"               = (var.graph_source == null ? null : { for key0, value0 in { "@odata.type" = var.graph_source["odata_type"], "type" = (var.graph_source["type"] == null ? null : [for item1 in var.graph_source["type"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "inference"            = (var.inference == null ? null : { for key0, value0 in { "@odata.type" = var.inference["odata_type"], "confidenceScore" = var.inference["confidenceScore"], "userHasVerifiedAccuracy" = var.inference["userHasVerifiedAccuracy"] } : key0 => value0 if value0 != null })
    "isCurrent"            = var.is_current
    "isSearchable"         = var.is_searchable
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "manager"              = (var.manager == null ? null : { for key0, value0 in { "@odata.type" = var.manager["odata_type"], "displayName" = var.manager["displayName"], "relationship" = var.manager["relationship"], "userId" = var.manager["userId"], "userPrincipalName" = var.manager["userPrincipalName"] } : key0 => value0 if value0 != null })
    "@odata.type"          = var.odata_type
    "sources"              = (var.sources == null ? null : [for item0 in var.sources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isDefaultSource" = item0["isDefaultSource"], "properties" = (item0["properties"] == null ? null : [for item2 in item0["properties"] : item2 if item2 != null]), "sourceId" = item0["sourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/profile/positions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
