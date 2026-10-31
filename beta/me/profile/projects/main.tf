# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedAudiences"     = var.allowedAudiences
    "categories"           = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "client"               = (var.client == null ? null : { for key0, value0 in { "@odata.type" = var.client["odata_type"], "address" = (var.client["address"] == null ? null : { for key1, value1 in { "@odata.type" = var.client["address"]["odata_type"], "city" = var.client["address"]["city"], "countryOrRegion" = var.client["address"]["countryOrRegion"], "postOfficeBox" = var.client["address"]["postOfficeBox"], "postalCode" = var.client["address"]["postalCode"], "state" = var.client["address"]["state"], "street" = var.client["address"]["street"], "type" = var.client["address"]["type"] } : key1 => value1 if value1 != null }), "companyCode" = var.client["companyCode"], "costCenter" = var.client["costCenter"], "department" = var.client["department"], "displayName" = var.client["displayName"], "division" = var.client["division"], "officeLocation" = var.client["officeLocation"], "pronunciation" = var.client["pronunciation"], "secondaryDepartment" = var.client["secondaryDepartment"], "webUrl" = var.client["webUrl"] } : key0 => value0 if value0 != null })
    "collaborationTags"    = (var.collaborationTags == null ? null : [for item0 in var.collaborationTags : item0 if item0 != null])
    "colleagues"           = (var.colleagues == null ? null : [for item0 in var.colleagues : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "relationship" = item0["relationship"], "relationshipLabel" = item0["relationshipLabel"], "userId" = item0["userId"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdBy"            = var.createdBy
    "createdDateTime"      = var.createdDateTime
    "detail"               = (var.detail == null ? null : { for key0, value0 in { "@odata.type" = var.detail["odata_type"], "company" = (var.detail["company"] == null ? null : { for key1, value1 in { "@odata.type" = var.detail["company"]["odata_type"], "address" = (var.detail["company"]["address"] == null ? null : { for key2, value2 in { "@odata.type" = var.detail["company"]["address"]["odata_type"], "city" = var.detail["company"]["address"]["city"], "countryOrRegion" = var.detail["company"]["address"]["countryOrRegion"], "postOfficeBox" = var.detail["company"]["address"]["postOfficeBox"], "postalCode" = var.detail["company"]["address"]["postalCode"], "state" = var.detail["company"]["address"]["state"], "street" = var.detail["company"]["address"]["street"], "type" = var.detail["company"]["address"]["type"] } : key2 => value2 if value2 != null }), "companyCode" = var.detail["company"]["companyCode"], "costCenter" = var.detail["company"]["costCenter"], "department" = var.detail["company"]["department"], "displayName" = var.detail["company"]["displayName"], "division" = var.detail["company"]["division"], "officeLocation" = var.detail["company"]["officeLocation"], "pronunciation" = var.detail["company"]["pronunciation"], "secondaryDepartment" = var.detail["company"]["secondaryDepartment"], "webUrl" = var.detail["company"]["webUrl"] } : key1 => value1 if value1 != null }), "description" = var.detail["description"], "employeeId" = var.detail["employeeId"], "employeeType" = var.detail["employeeType"], "endMonthYear" = var.detail["endMonthYear"], "jobTitle" = var.detail["jobTitle"], "layer" = var.detail["layer"], "level" = var.detail["level"], "role" = var.detail["role"], "secondaryJobTitle" = var.detail["secondaryJobTitle"], "secondaryRole" = var.detail["secondaryRole"], "startMonthYear" = var.detail["startMonthYear"], "summary" = var.detail["summary"] } : key0 => value0 if value0 != null })
    "displayName"          = var.displayName
    "source"               = (var.graph_source == null ? null : { for key0, value0 in { "@odata.type" = var.graph_source["odata_type"], "type" = (var.graph_source["type"] == null ? null : [for item1 in var.graph_source["type"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "inference"            = (var.inference == null ? null : { for key0, value0 in { "@odata.type" = var.inference["odata_type"], "confidenceScore" = var.inference["confidenceScore"], "userHasVerifiedAccuracy" = var.inference["userHasVerifiedAccuracy"] } : key0 => value0 if value0 != null })
    "isSearchable"         = var.isSearchable
    "lastModifiedBy"       = var.lastModifiedBy
    "lastModifiedDateTime" = var.lastModifiedDateTime
    "@odata.type"          = var.odata_type
    "sources"              = (var.sources == null ? null : [for item0 in var.sources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isDefaultSource" = item0["isDefaultSource"], "properties" = (item0["properties"] == null ? null : [for item2 in item0["properties"] : item2 if item2 != null]), "sourceId" = item0["sourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "sponsors"             = (var.sponsors == null ? null : [for item0 in var.sponsors : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "relationship" = item0["relationship"], "relationshipLabel" = item0["relationshipLabel"], "userId" = item0["userId"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "thumbnailUrl"         = var.thumbnailUrl
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "me/profile/projects"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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
