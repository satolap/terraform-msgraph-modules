# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description" = var.description
    "displayName" = var.display_name
    "files"       = (var.files == null ? null : [for item0 in var.files : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "custodian" = item0["custodian"], "dateTime" = item0["dateTime"], "extension" = item0["extension"], "extractedTextContent" = item0["extractedTextContent"], "mediaType" = item0["mediaType"], "name" = item0["name"], "otherProperties" = item0["otherProperties"], "processingStatus" = item0["processingStatus"], "senderOrAuthors" = (item0["senderOrAuthors"] == null ? null : [for item2 in item0["senderOrAuthors"] : item2 if item2 != null]), "size" = item0["size"], "sourceType" = item0["sourceType"], "subjectTitle" = item0["subjectTitle"], "tags" = (item0["tags"] == null ? null : [for item2 in item0["tags"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "childSelectability" = item2["childSelectability"], "childTags" = (item2["childTags"] == null ? null : [for item4 in item2["childTags"] : item4 if item4 != null]), "createdBy" = item2["createdBy"], "description" = item2["description"], "displayName" = item2["displayName"], "lastModifiedDateTime" = item2["lastModifiedDateTime"], "parent" = item2["parent"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type" = var.odata_type
    "queries"     = (var.queries == null ? null : [for item0 in var.queries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "contentQuery" = item0["contentQuery"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/cases/ediscoveryCases/${urlencode(var.ediscovery_case_id)}/reviewSets"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
