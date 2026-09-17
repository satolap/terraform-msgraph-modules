# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignedRoleCount"                   = var.assigned_role_count
    "calculatedDateTime"                  = var.calculated_date_time
    "createdDateTime"                     = var.created_date_time
    "directGroupMemberCount"              = var.direct_group_member_count
    "displayName"                         = var.display_name
    "dynamicMembershipType"               = var.dynamic_membership_type
    "groupExpirationDateTime"             = var.group_expiration_date_time
    "groupType"                           = var.group_type
    "guestOwnerCount"                     = var.guest_owner_count
    "guestTransitiveUserCount"            = var.guest_transitive_user_count
    "isCloudDistributionListGroup"        = var.is_cloud_distribution_list_group
    "isCloudM365Group"                    = var.is_cloud_m365_group
    "isCloudMailEnabledSecurityGroup"     = var.is_cloud_mail_enabled_security_group
    "isCloudSecurityGroup"                = var.is_cloud_security_group
    "isDynamicGroup"                      = var.is_dynamic_group
    "isOnPremiseDistributionListGroup"    = var.is_on_premise_distribution_list_group
    "isOnPremiseMailEnabledSecurityGroup" = var.is_on_premise_mail_enabled_security_group
    "isOnPremiseSecurityGroup"            = var.is_on_premise_security_group
    "isValidGroup"                        = var.is_valid_group
    "lastRestorationDateTime"             = var.last_restoration_date_time
    "memberOwnerCount"                    = var.member_owner_count
    "memberTransitiveUserCount"           = var.member_transitive_user_count
    "membershipRuleContainsCount"         = var.membership_rule_contains_count
    "membershipRuleExpressionCount"       = var.membership_rule_expression_count
    "membershipRuleMatchCount"            = var.membership_rule_match_count
    "membershipRuleMemberOfCount"         = var.membership_rule_member_of_count
    "membershipRuleProcessingState"       = var.membership_rule_processing_state
    "@odata.type"                         = var.odata_type
    "preferredDataLocation"               = var.preferred_data_location
    "sensitivityLabelCount"               = var.sensitivity_label_count
    "servicePrincipalOwnerCount"          = var.service_principal_owner_count
    "softDeletionDateTime"                = var.soft_deletion_date_time
    "tenantId"                            = var.tenant_id
    "transitiveServicePrincipalCount"     = var.transitive_service_principal_count
    "transitiveUserCount"                 = var.transitive_user_count
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "reports/identityAnalytics/groups"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
