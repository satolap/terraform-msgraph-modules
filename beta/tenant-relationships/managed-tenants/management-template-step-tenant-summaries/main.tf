# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignedTenantsCount"                    = var.assigned_tenants_count
    "compliantTenantsCount"                   = var.compliant_tenants_count
    "createdByUserId"                         = var.created_by_user_id
    "createdDateTime"                         = var.created_date_time
    "dismissedTenantsCount"                   = var.dismissed_tenants_count
    "ineligibleTenantsCount"                  = var.ineligible_tenants_count
    "lastActionByUserId"                      = var.last_action_by_user_id
    "lastActionDateTime"                      = var.last_action_date_time
    "managementTemplateCollectionDisplayName" = var.management_template_collection_display_name
    "managementTemplateCollectionId"          = var.management_template_collection_id
    "managementTemplateDisplayName"           = var.management_template_display_name
    "managementTemplateId"                    = var.management_template_id
    "managementTemplateStepDisplayName"       = var.management_template_step_display_name
    "managementTemplateStepId"                = var.management_template_step_id
    "notCompliantTenantsCount"                = var.not_compliant_tenants_count
    "@odata.type"                             = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managementTemplateStepTenantSummaries"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
