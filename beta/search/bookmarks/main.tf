# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "availabilityEndDateTime"   = var.availabilityEndDateTime
    "availabilityStartDateTime" = var.availabilityStartDateTime
    "categories"                = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "description"               = var.description
    "displayName"               = var.displayName
    "groupIds"                  = (var.groupIds == null ? null : [for item0 in var.groupIds : item0 if item0 != null])
    "keywords"                  = (var.keywords == null ? null : { for key0, value0 in { "@odata.type" = var.keywords["odata_type"], "keywords" = (var.keywords["keywords"] == null ? null : [for item1 in var.keywords["keywords"] : item1 if item1 != null]), "matchSimilarKeywords" = var.keywords["matchSimilarKeywords"], "reservedKeywords" = (var.keywords["reservedKeywords"] == null ? null : [for item1 in var.keywords["reservedKeywords"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "languageTags"              = (var.languageTags == null ? null : [for item0 in var.languageTags : item0 if item0 != null])
    "@odata.type"               = var.odata_type
    "platforms"                 = (var.platforms == null ? null : [for item0 in var.platforms : item0 if item0 != null])
    "powerAppIds"               = (var.powerAppIds == null ? null : [for item0 in var.powerAppIds : item0 if item0 != null])
    "state"                     = var.state
    "targetedVariations"        = (var.targetedVariations == null ? null : [for item0 in var.targetedVariations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "displayName" = item0["displayName"], "languageTag" = item0["languageTag"], "platform" = item0["platform"], "webUrl" = item0["webUrl"] } : key1 => value1 if value1 != null }) if item0 != null])
    "webUrl"                    = var.webUrl
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "search/bookmarks"
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
