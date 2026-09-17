# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "decisions"         = (var.decisions == null ? null : [for item0 in var.decisions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "decision" = item0["decision"], "insights" = (item0["insights"] == null ? null : [for item2 in item0["insights"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "insightCreatedDateTime" = item2["insightCreatedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "justification" = item0["justification"], "permission" = item0["permission"] } : key1 => value1 if value1 != null }) if item0 != null])
    "fallbackReviewers" = (var.fallback_reviewers == null ? null : [for item0 in var.fallback_reviewers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "query" = item0["query"], "queryRoot" = item0["queryRoot"], "queryType" = item0["queryType"], "reviewerId" = item0["reviewerId"], "scopeType" = item0["scopeType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"       = var.odata_type
    "reviewers"         = (var.reviewers == null ? null : [for item0 in var.reviewers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "query" = item0["query"], "queryRoot" = item0["queryRoot"], "queryType" = item0["queryType"], "reviewerId" = item0["reviewerId"], "scopeType" = item0["scopeType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "stages"            = (var.stages == null ? null : [for item0 in var.stages : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "decisions" = (item0["decisions"] == null ? null : [for item2 in item0["decisions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "decision" = item2["decision"], "insights" = (item2["insights"] == null ? null : [for item4 in item2["insights"] : item4 if item4 != null]), "justification" = item2["justification"], "permission" = item2["permission"] } : key3 => value3 if value3 != null }) if item2 != null]), "fallbackReviewers" = (item0["fallbackReviewers"] == null ? null : [for item2 in item0["fallbackReviewers"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "query" = item2["query"], "queryRoot" = item2["queryRoot"], "queryType" = item2["queryType"], "reviewerId" = item2["reviewerId"], "scopeType" = item2["scopeType"] } : key3 => value3 if value3 != null }) if item2 != null]), "reviewers" = (item0["reviewers"] == null ? null : [for item2 in item0["reviewers"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "query" = item2["query"], "queryRoot" = item2["queryRoot"], "queryType" = item2["queryType"], "reviewerId" = item2["reviewerId"], "scopeType" = item2["scopeType"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/accessReviews/unified/definitions/${urlencode(var.access_review_schedule_definition_id)}/instances"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
