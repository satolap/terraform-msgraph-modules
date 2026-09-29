# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "canvasLayout"       = var.canvas_layout
    "createdByUser"      = var.created_by_user
    "description"        = var.description
    "lastModifiedByUser" = var.last_modified_by_user
    "name"               = var.name
    "@odata.type"        = var.odata_type
    "pageLayout"         = var.page_layout
    "parentReference"    = (var.parent_reference == null ? null : { for key0, value0 in { "@odata.type" = var.parent_reference["odata_type"], "driveType" = var.parent_reference["driveType"], "shareId" = var.parent_reference["shareId"], "siteId" = var.parent_reference["siteId"] } : key0 => value0 if value0 != null })
    "publishingState"    = (var.publishing_state == null ? null : { for key0, value0 in { "@odata.type" = var.publishing_state["odata_type"], "checkedOutBy" = var.publishing_state["checkedOutBy"] } : key0 => value0 if value0 != null })
    "title"              = var.title
    "titleArea"          = (var.title_area == null ? null : { for key0, value0 in { "@odata.type" = var.title_area["odata_type"], "alternativeText" = var.title_area["alternativeText"], "enableGradientEffect" = var.title_area["enableGradientEffect"], "imageWebUrl" = var.title_area["imageWebUrl"], "layout" = var.title_area["layout"], "serverProcessedContent" = (var.title_area["serverProcessedContent"] == null ? null : { for key1, value1 in { "@odata.type" = var.title_area["serverProcessedContent"]["odata_type"], "componentDependencies" = (var.title_area["serverProcessedContent"]["componentDependencies"] == null ? null : [for item2 in var.title_area["serverProcessedContent"]["componentDependencies"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "customMetadata" = (var.title_area["serverProcessedContent"]["customMetadata"] == null ? null : [for item2 in var.title_area["serverProcessedContent"]["customMetadata"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "htmlStrings" = (var.title_area["serverProcessedContent"]["htmlStrings"] == null ? null : [for item2 in var.title_area["serverProcessedContent"]["htmlStrings"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "imageSources" = (var.title_area["serverProcessedContent"]["imageSources"] == null ? null : [for item2 in var.title_area["serverProcessedContent"]["imageSources"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "links" = (var.title_area["serverProcessedContent"]["links"] == null ? null : [for item2 in var.title_area["serverProcessedContent"]["links"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "searchablePlainTexts" = (var.title_area["serverProcessedContent"]["searchablePlainTexts"] == null ? null : [for item2 in var.title_area["serverProcessedContent"]["searchablePlainTexts"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }), "showAuthor" = var.title_area["showAuthor"], "showPublishedDate" = var.title_area["showPublishedDate"], "showTextBlockAboveTitle" = var.title_area["showTextBlockAboveTitle"], "textAboveTitle" = var.title_area["textAboveTitle"], "textAlignment" = var.title_area["textAlignment"] } : key0 => value0 if value0 != null })
    "webParts"           = (var.web_parts == null ? null : [for item0 in var.web_parts : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/sites/${urlencode(var.site_id)}/pageTemplates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
