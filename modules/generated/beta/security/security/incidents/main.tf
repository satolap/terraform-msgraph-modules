# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alerts"                    = (var.alerts == null ? null : [for item0 in var.alerts : item0 if item0 != null])
    "assignedTo"                = var.assigned_to
    "classification"            = var.classification
    "comments"                  = (var.comments == null ? null : [for item0 in var.comments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "comment" = item0["comment"], "createdByDisplayName" = item0["createdByDisplayName"], "createdDateTime" = item0["createdDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"           = var.created_date_time
    "customTags"                = (var.custom_tags == null ? null : [for item0 in var.custom_tags : item0 if item0 != null])
    "description"               = var.description
    "determination"             = var.determination
    "displayName"               = var.display_name
    "incidentWebUrl"            = var.incident_web_url
    "lastModifiedBy"            = var.last_modified_by
    "lastUpdateDateTime"        = var.last_update_date_time
    "@odata.type"               = var.odata_type
    "priorityScore"             = var.priority_score
    "recommendedActions"        = var.recommended_actions
    "recommendedHuntingQueries" = (var.recommended_hunting_queries == null ? null : [for item0 in var.recommended_hunting_queries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "kqlText" = item0["kqlText"] } : key1 => value1 if value1 != null }) if item0 != null])
    "redirectIncidentId"        = var.redirect_incident_id
    "resolvingComment"          = var.resolving_comment
    "severity"                  = var.severity
    "status"                    = var.status
    "summary"                   = var.summary
    "systemTags"                = (var.system_tags == null ? null : [for item0 in var.system_tags : item0 if item0 != null])
    "tenantId"                  = var.tenant_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/incidents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
