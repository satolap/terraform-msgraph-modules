# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "completeStepsCount"                      = var.complete_steps_count
    "completeUsersCount"                      = var.complete_users_count
    "createdByUserId"                         = var.created_by_user_id
    "createdDateTime"                         = var.created_date_time
    "dismissedStepsCount"                     = var.dismissed_steps_count
    "excludedUsersCount"                      = var.excluded_users_count
    "excludedUsersDistinctCount"              = var.excluded_users_distinct_count
    "incompleteStepsCount"                    = var.incomplete_steps_count
    "incompleteUsersCount"                    = var.incomplete_users_count
    "ineligibleStepsCount"                    = var.ineligible_steps_count
    "isComplete"                              = var.is_complete
    "lastActionByUserId"                      = var.last_action_by_user_id
    "lastActionDateTime"                      = var.last_action_date_time
    "managementTemplateCollectionDisplayName" = var.management_template_collection_display_name
    "managementTemplateCollectionId"          = var.management_template_collection_id
    "@odata.type"                             = var.odata_type
    "regressedStepsCount"                     = var.regressed_steps_count
    "regressedUsersCount"                     = var.regressed_users_count
    "tenantId"                                = var.tenant_id
    "unlicensedUsersCount"                    = var.unlicensed_users_count
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managementTemplateCollectionTenantSummaries"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
