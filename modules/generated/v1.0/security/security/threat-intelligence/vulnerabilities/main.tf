# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activeExploitsObserved"       = var.active_exploits_observed
    "articles"                     = (var.articles == null ? null : [for item0 in var.articles : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "body" = (item0["body"] == null ? null : { for key2, value2 in { "@odata.type" = item0["body"]["odata_type"], "content" = item0["body"]["content"], "format" = item0["body"]["format"] } : key2 => value2 if value2 != null }), "createdDateTime" = item0["createdDateTime"], "imageUrl" = item0["imageUrl"], "indicators" = (item0["indicators"] == null ? null : [for item2 in item0["indicators"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "artifact" = (item2["artifact"] == null ? null : { for key4, value4 in { "@odata.type" = item2["artifact"]["odata_type"] } : key4 => value4 if value4 != null }), "source" = item2["source"] } : key3 => value3 if value3 != null }) if item2 != null]), "isFeatured" = item0["isFeatured"], "lastUpdatedDateTime" = item0["lastUpdatedDateTime"], "summary" = (item0["summary"] == null ? null : { for key2, value2 in { "@odata.type" = item0["summary"]["odata_type"], "content" = item0["summary"]["content"], "format" = item0["summary"]["format"] } : key2 => value2 if value2 != null }), "tags" = (item0["tags"] == null ? null : [for item2 in item0["tags"] : item2 if item2 != null]), "title" = item0["title"] } : key1 => value1 if value1 != null }) if item0 != null])
    "commonWeaknessEnumerationIds" = (var.common_weakness_enumeration_ids == null ? null : [for item0 in var.common_weakness_enumeration_ids : item0 if item0 != null])
    "components"                   = (var.components == null ? null : [for item0 in var.components : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"              = var.created_date_time
    "cvss2Summary"                 = (var.cvss2_summary == null ? null : { for key0, value0 in { "@odata.type" = var.cvss2_summary["odata_type"], "score" = var.cvss2_summary["score"], "severity" = var.cvss2_summary["severity"], "vectorString" = var.cvss2_summary["vectorString"] } : key0 => value0 if value0 != null })
    "cvss3Summary"                 = (var.cvss3_summary == null ? null : { for key0, value0 in { "@odata.type" = var.cvss3_summary["odata_type"], "score" = var.cvss3_summary["score"], "severity" = var.cvss3_summary["severity"], "vectorString" = var.cvss3_summary["vectorString"] } : key0 => value0 if value0 != null })
    "description"                  = (var.description == null ? null : { for key0, value0 in { "@odata.type" = var.description["odata_type"], "content" = var.description["content"], "format" = var.description["format"] } : key0 => value0 if value0 != null })
    "exploits"                     = (var.exploits == null ? null : [for item0 in var.exploits : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "url" = item0["url"] } : key1 => value1 if value1 != null }) if item0 != null])
    "exploitsAvailable"            = var.exploits_available
    "hasChatter"                   = var.has_chatter
    "lastModifiedDateTime"         = var.last_modified_date_time
    "@odata.type"                  = var.odata_type
    "priorityScore"                = var.priority_score
    "publishedDateTime"            = var.published_date_time
    "references"                   = (var.references == null ? null : [for item0 in var.references : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "url" = item0["url"] } : key1 => value1 if value1 != null }) if item0 != null])
    "remediation"                  = var.remediation
    "severity"                     = var.severity
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/threatIntelligence/vulnerabilities"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
