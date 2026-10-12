# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "businessFlowTemplateId" = var.business_flow_template_id
    "createdBy"              = var.created_by
    "decisions"              = (var.decisions == null ? null : [for item0 in var.decisions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessRecommendation" = item0["accessRecommendation"], "accessReviewId" = item0["accessReviewId"], "appliedBy" = item0["appliedBy"], "appliedDateTime" = item0["appliedDateTime"], "applyResult" = item0["applyResult"], "justification" = item0["justification"], "reviewResult" = item0["reviewResult"], "reviewedBy" = item0["reviewedBy"], "reviewedDateTime" = item0["reviewedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"            = var.description
    "displayName"            = var.display_name
    "endDateTime"            = var.end_date_time
    "instances"              = (var.instances == null ? null : [for item0 in var.instances : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "businessFlowTemplateId" = item0["businessFlowTemplateId"], "createdBy" = item0["createdBy"], "decisions" = (item0["decisions"] == null ? null : [for item2 in item0["decisions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "accessRecommendation" = item2["accessRecommendation"], "accessReviewId" = item2["accessReviewId"], "appliedBy" = item2["appliedBy"], "appliedDateTime" = item2["appliedDateTime"], "applyResult" = item2["applyResult"], "justification" = item2["justification"], "reviewResult" = item2["reviewResult"], "reviewedBy" = item2["reviewedBy"], "reviewedDateTime" = item2["reviewedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"], "endDateTime" = item0["endDateTime"], "instances" = (item0["instances"] == null ? null : [for item2 in item0["instances"] : item2 if item2 != null]), "myDecisions" = (item0["myDecisions"] == null ? null : [for item2 in item0["myDecisions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "accessRecommendation" = item2["accessRecommendation"], "accessReviewId" = item2["accessReviewId"], "appliedBy" = item2["appliedBy"], "appliedDateTime" = item2["appliedDateTime"], "applyResult" = item2["applyResult"], "justification" = item2["justification"], "reviewResult" = item2["reviewResult"], "reviewedBy" = item2["reviewedBy"], "reviewedDateTime" = item2["reviewedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "reviewedEntity" = item0["reviewedEntity"], "reviewerType" = item0["reviewerType"], "reviewers" = (item0["reviewers"] == null ? null : [for item2 in item0["reviewers"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "createdDateTime" = item2["createdDateTime"], "displayName" = item2["displayName"], "userPrincipalName" = item2["userPrincipalName"] } : key3 => value3 if value3 != null }) if item2 != null]), "settings" = item0["settings"], "startDateTime" = item0["startDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "myDecisions"            = (var.my_decisions == null ? null : [for item0 in var.my_decisions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessRecommendation" = item0["accessRecommendation"], "accessReviewId" = item0["accessReviewId"], "appliedBy" = item0["appliedBy"], "appliedDateTime" = item0["appliedDateTime"], "applyResult" = item0["applyResult"], "justification" = item0["justification"], "reviewResult" = item0["reviewResult"], "reviewedBy" = item0["reviewedBy"], "reviewedDateTime" = item0["reviewedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"            = var.odata_type
    "reviewedEntity"         = var.reviewed_entity
    "reviewerType"           = var.reviewer_type
    "reviewers"              = (var.reviewers == null ? null : [for item0 in var.reviewers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "settings"               = var.settings
    "startDateTime"          = var.start_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "accessReviews"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
