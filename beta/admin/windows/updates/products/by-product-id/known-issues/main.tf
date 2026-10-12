# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"                     = var.description
    "knownIssueHistories"             = (var.known_issue_histories == null ? null : [for item0 in var.known_issue_histories : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "body" = (item0["body"] == null ? null : { for key2, value2 in { "@odata.type" = item0["body"]["odata_type"], "content" = item0["body"]["content"], "contentType" = item0["body"]["contentType"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                     = var.odata_type
    "originatingKnowledgeBaseArticle" = var.originating_knowledge_base_article
    "resolvedDateTime"                = var.resolved_date_time
    "resolvingKnowledgeBaseArticle"   = var.resolving_knowledge_base_article
    "safeguardHoldIds"                = (var.safeguard_hold_ids == null ? null : [for item0 in var.safeguard_hold_ids : item0 if item0 != null])
    "startDateTime"                   = var.start_date_time
    "status"                          = var.status
    "title"                           = var.title
    "webViewUrl"                      = var.web_view_url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/windows/updates/products/${urlencode(var.product_id)}/knownIssues"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
