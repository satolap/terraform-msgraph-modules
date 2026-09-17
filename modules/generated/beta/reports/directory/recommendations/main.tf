# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionSteps"                  = (var.action_steps == null ? null : [for item0 in var.action_steps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actionUrl" = item0["actionUrl"], "stepNumber" = item0["stepNumber"], "text" = item0["text"] } : key1 => value1 if value1 != null }) if item0 != null])
    "benefits"                     = var.benefits
    "category"                     = var.category
    "categoryGroup"                = var.category_group
    "completedBySystemDateTime"    = var.completed_by_system_date_time
    "completedByUserDateTime"      = var.completed_by_user_date_time
    "createdDateTime"              = var.created_date_time
    "currentScore"                 = var.current_score
    "displayName"                  = var.display_name
    "failedReviewDateTime"         = var.failed_review_date_time
    "featureAreas"                 = (var.feature_areas == null ? null : [for item0 in var.feature_areas : item0 if item0 != null])
    "impactStartDateTime"          = var.impact_start_date_time
    "impactType"                   = var.impact_type
    "impactedResources"            = (var.impacted_resources == null ? null : [for item0 in var.impacted_resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "addedDateTime" = item0["addedDateTime"], "additionalDetails" = (item0["additionalDetails"] == null ? null : [for item2 in item0["additionalDetails"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "apiUrl" = item0["apiUrl"], "displayName" = item0["displayName"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "owner" = item0["owner"], "portalUrl" = item0["portalUrl"], "postponeUntilDateTime" = item0["postponeUntilDateTime"], "rank" = item0["rank"], "recommendationId" = item0["recommendationId"], "resourceType" = item0["resourceType"], "status" = item0["status"], "subjectId" = item0["subjectId"], "tags" = (item0["tags"] == null ? null : [for item2 in item0["tags"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "insights"                     = var.insights
    "lastCheckedDateTime"          = var.last_checked_date_time
    "lastModifiedBy"               = var.last_modified_by
    "lastModifiedDateTime"         = var.last_modified_date_time
    "maxScore"                     = var.max_score
    "needsMoreActionResourceCount" = var.needs_more_action_resource_count
    "nistClassifications"          = (var.nist_classifications == null ? null : [for item0 in var.nist_classifications : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "category" = item0["category"], "description" = item0["description"], "function" = item0["function"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                  = var.odata_type
    "postponeUntilDateTime"        = var.postpone_until_date_time
    "priority"                     = var.priority
    "recommendationType"           = var.recommendation_type
    "releaseType"                  = var.release_type
    "remediatedDateTime"           = var.remediated_date_time
    "remediationImpact"            = var.remediation_impact
    "requiredLicenses"             = var.required_licenses
    "status"                       = var.status
    "statusModifiedDateTime"       = var.status_modified_date_time
    "tags"                         = (var.tags == null ? null : [for item0 in var.tags : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/recommendations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
