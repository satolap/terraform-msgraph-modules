# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdByUserId"     = var.created_by_user_id
    "createdDateTime"     = var.created_date_time
    "error"               = var.error
    "lastActionByUserId"  = var.last_action_by_user_id
    "lastActionDateTime"  = var.last_action_date_time
    "@odata.type"         = var.odata_type
    "status"              = var.status
    "templateStepVersion" = (var.template_step_version == null ? null : { for key0, value0 in { "@odata.type" = var.template_step_version["odata_type"], "acceptedFor" = var.template_step_version["acceptedFor"], "contentMarkdown" = var.template_step_version["contentMarkdown"], "createdByUserId" = var.template_step_version["createdByUserId"], "createdDateTime" = var.template_step_version["createdDateTime"], "deployments" = (var.template_step_version["deployments"] == null ? null : [for item1 in var.template_step_version["deployments"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "createdByUserId" = item1["createdByUserId"], "createdDateTime" = item1["createdDateTime"], "error" = item1["error"], "lastActionByUserId" = item1["lastActionByUserId"], "lastActionDateTime" = item1["lastActionDateTime"], "status" = item1["status"], "templateStepVersion" = item1["templateStepVersion"], "tenantId" = item1["tenantId"] } : key2 => value2 if value2 != null }) if item1 != null]), "lastActionByUserId" = var.template_step_version["lastActionByUserId"], "lastActionDateTime" = var.template_step_version["lastActionDateTime"], "name" = var.template_step_version["name"], "templateStep" = var.template_step_version["templateStep"], "version" = var.template_step_version["version"], "versionInformation" = var.template_step_version["versionInformation"] } : key0 => value0 if value0 != null })
    "tenantId"            = var.tenant_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managementTemplateStepVersions/${urlencode(var.management_template_step_version_id)}/deployments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
