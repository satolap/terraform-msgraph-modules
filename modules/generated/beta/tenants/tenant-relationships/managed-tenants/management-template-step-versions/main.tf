# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "acceptedFor"        = var.accepted_for
    "contentMarkdown"    = var.content_markdown
    "createdByUserId"    = var.created_by_user_id
    "createdDateTime"    = var.created_date_time
    "deployments"        = (var.deployments == null ? null : [for item0 in var.deployments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdByUserId" = item0["createdByUserId"], "createdDateTime" = item0["createdDateTime"], "error" = item0["error"], "lastActionByUserId" = item0["lastActionByUserId"], "lastActionDateTime" = item0["lastActionDateTime"], "status" = item0["status"], "templateStepVersion" = (item0["templateStepVersion"] == null ? null : { for key2, value2 in { "@odata.type" = item0["templateStepVersion"]["odata_type"], "acceptedFor" = item0["templateStepVersion"]["acceptedFor"], "contentMarkdown" = item0["templateStepVersion"]["contentMarkdown"], "createdByUserId" = item0["templateStepVersion"]["createdByUserId"], "createdDateTime" = item0["templateStepVersion"]["createdDateTime"], "deployments" = (item0["templateStepVersion"]["deployments"] == null ? null : [for item3 in item0["templateStepVersion"]["deployments"] : item3 if item3 != null]), "lastActionByUserId" = item0["templateStepVersion"]["lastActionByUserId"], "lastActionDateTime" = item0["templateStepVersion"]["lastActionDateTime"], "name" = item0["templateStepVersion"]["name"], "templateStep" = item0["templateStepVersion"]["templateStep"], "version" = item0["templateStepVersion"]["version"], "versionInformation" = item0["templateStepVersion"]["versionInformation"] } : key2 => value2 if value2 != null }), "tenantId" = item0["tenantId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "version"            = var.graph_version
    "lastActionByUserId" = var.last_action_by_user_id
    "lastActionDateTime" = var.last_action_date_time
    "name"               = var.name
    "@odata.type"        = var.odata_type
    "templateStep"       = var.template_step
    "versionInformation" = var.version_information
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managementTemplateStepVersions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
