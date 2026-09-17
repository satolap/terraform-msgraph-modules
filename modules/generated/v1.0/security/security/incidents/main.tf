# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alerts"             = (var.alerts == null ? null : [for item0 in var.alerts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actorDisplayName" = item0["actorDisplayName"], "additionalData" = item0["additionalData"], "alertPolicyId" = item0["alertPolicyId"], "alertWebUrl" = item0["alertWebUrl"], "assignedTo" = item0["assignedTo"], "categories" = (item0["categories"] == null ? null : [for item2 in item0["categories"] : item2 if item2 != null]), "category" = item0["category"], "classification" = item0["classification"], "comments" = (item0["comments"] == null ? null : [for item2 in item0["comments"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "comment" = item2["comment"], "createdByDisplayName" = item2["createdByDisplayName"], "createdDateTime" = item2["createdDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "createdDateTime" = item0["createdDateTime"], "customDetails" = item0["customDetails"], "description" = item0["description"], "detectionSource" = item0["detectionSource"], "detectorId" = item0["detectorId"], "determination" = item0["determination"], "evidence" = (item0["evidence"] == null ? null : [for item2 in item0["evidence"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "createdDateTime" = item2["createdDateTime"], "detailedRoles" = (item2["detailedRoles"] == null ? null : [for item4 in item2["detailedRoles"] : item4 if item4 != null]), "remediationStatus" = item2["remediationStatus"], "remediationStatusDetails" = item2["remediationStatusDetails"], "roles" = (item2["roles"] == null ? null : [for item4 in item2["roles"] : item4 if item4 != null]), "tags" = (item2["tags"] == null ? null : [for item4 in item2["tags"] : item4 if item4 != null]), "verdict" = item2["verdict"] } : key3 => value3 if value3 != null }) if item2 != null]), "firstActivityDateTime" = item0["firstActivityDateTime"], "incidentId" = item0["incidentId"], "incidentWebUrl" = item0["incidentWebUrl"], "investigationState" = item0["investigationState"], "lastActivityDateTime" = item0["lastActivityDateTime"], "lastUpdateDateTime" = item0["lastUpdateDateTime"], "mitreTechniques" = (item0["mitreTechniques"] == null ? null : [for item2 in item0["mitreTechniques"] : item2 if item2 != null]), "productName" = item0["productName"], "providerAlertId" = item0["providerAlertId"], "recommendedActions" = item0["recommendedActions"], "resolvedDateTime" = item0["resolvedDateTime"], "serviceSource" = item0["serviceSource"], "severity" = item0["severity"], "status" = item0["status"], "systemTags" = (item0["systemTags"] == null ? null : [for item2 in item0["systemTags"] : item2 if item2 != null]), "tenantId" = item0["tenantId"], "threatDisplayName" = item0["threatDisplayName"], "threatFamilyName" = item0["threatFamilyName"], "title" = item0["title"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignedTo"         = var.assigned_to
    "classification"     = var.classification
    "comments"           = (var.comments == null ? null : [for item0 in var.comments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "comment" = item0["comment"], "createdByDisplayName" = item0["createdByDisplayName"], "createdDateTime" = item0["createdDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"    = var.created_date_time
    "customTags"         = (var.custom_tags == null ? null : [for item0 in var.custom_tags : item0 if item0 != null])
    "description"        = var.description
    "determination"      = var.determination
    "displayName"        = var.display_name
    "incidentWebUrl"     = var.incident_web_url
    "lastModifiedBy"     = var.last_modified_by
    "lastUpdateDateTime" = var.last_update_date_time
    "@odata.type"        = var.odata_type
    "priorityScore"      = var.priority_score
    "redirectIncidentId" = var.redirect_incident_id
    "resolvingComment"   = var.resolving_comment
    "severity"           = var.severity
    "status"             = var.status
    "summary"            = var.summary
    "systemTags"         = (var.system_tags == null ? null : [for item0 in var.system_tags : item0 if item0 != null])
    "tenantId"           = var.tenant_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/incidents"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
