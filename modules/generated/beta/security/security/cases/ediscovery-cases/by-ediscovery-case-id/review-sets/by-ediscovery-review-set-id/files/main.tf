# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "content"              = var.content
    "custodian"            = var.custodian
    "dateTime"             = var.date_time
    "extension"            = var.extension
    "extractedTextContent" = var.extracted_text_content
    "mediaType"            = var.media_type
    "name"                 = var.name
    "@odata.type"          = var.odata_type
    "otherProperties"      = var.other_properties
    "processingStatus"     = var.processing_status
    "senderOrAuthors"      = (var.sender_or_authors == null ? null : [for item0 in var.sender_or_authors : item0 if item0 != null])
    "size"                 = var.size
    "sourceType"           = var.source_type
    "subjectTitle"         = var.subject_title
    "tags"                 = (var.tags == null ? null : [for item0 in var.tags : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "childSelectability" = item0["childSelectability"], "childTags" = (item0["childTags"] == null ? null : [for item2 in item0["childTags"] : item2 if item2 != null]), "createdBy" = item0["createdBy"], "description" = item0["description"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "parent" = item0["parent"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/cases/ediscoveryCases/${urlencode(var.ediscovery_case_id)}/reviewSets/${urlencode(var.ediscovery_review_set_id)}/files"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
