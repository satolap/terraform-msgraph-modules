# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "editions"    = (var.editions == null ? null : [for item0 in var.editions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceFamily" = item0["deviceFamily"], "isInService" = item0["isInService"], "servicingPeriods" = (item0["servicingPeriods"] == null ? null : [for item2 in item0["servicingPeriods"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "name" = item2["name"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "knownIssues" = (var.known_issues == null ? null : [for item0 in var.known_issues : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "knownIssueHistories" = (item0["knownIssueHistories"] == null ? null : [for item2 in item0["knownIssueHistories"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "body" = (item2["body"] == null ? null : { for key4, value4 in { "@odata.type" = item2["body"]["odata_type"], "content" = item2["body"]["content"], "contentType" = item2["body"]["contentType"] } : key4 => value4 if value4 != null }) } : key3 => value3 if value3 != null }) if item2 != null]), "originatingKnowledgeBaseArticle" = item0["originatingKnowledgeBaseArticle"], "resolvedDateTime" = item0["resolvedDateTime"], "resolvingKnowledgeBaseArticle" = item0["resolvingKnowledgeBaseArticle"], "safeguardHoldIds" = (item0["safeguardHoldIds"] == null ? null : [for item2 in item0["safeguardHoldIds"] : item2 if item2 != null]), "startDateTime" = item0["startDateTime"], "status" = item0["status"], "title" = item0["title"], "webViewUrl" = item0["webViewUrl"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type" = var.odata_type
    "revisions"   = (var.revisions == null ? null : [for item0 in var.revisions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "catalogEntry" = item0["catalogEntry"], "knowledgeBaseArticle" = item0["knowledgeBaseArticle"], "osBuild" = (item0["osBuild"] == null ? null : { for key2, value2 in { "@odata.type" = item0["osBuild"]["odata_type"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/windows/updates/products"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
