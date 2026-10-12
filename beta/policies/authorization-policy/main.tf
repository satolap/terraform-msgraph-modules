# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowEmailVerifiedUsersToJoinOrganization"         = var.allow_email_verified_users_to_join_organization
    "allowInvitesFrom"                                  = var.allow_invites_from
    "allowUserConsentForRiskyApps"                      = var.allow_user_consent_for_risky_apps
    "allowedToSignUpEmailBasedSubscriptions"            = var.allowed_to_sign_up_email_based_subscriptions
    "allowedToUseSSPR"                                  = var.allowed_to_use_sspr
    "blockMsolPowerShell"                               = var.block_msol_power_shell
    "defaultUserRoleOverrides"                          = (var.default_user_role_overrides == null ? null : [for item0 in var.default_user_role_overrides : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isDefault" = item0["isDefault"], "rolePermissions" = (item0["rolePermissions"] == null ? null : [for item2 in item0["rolePermissions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "allowedResourceActions" = (item2["allowedResourceActions"] == null ? null : [for item4 in item2["allowedResourceActions"] : item4 if item4 != null]), "condition" = item2["condition"], "excludedResourceActions" = (item2["excludedResourceActions"] == null ? null : [for item4 in item2["excludedResourceActions"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "defaultUserRolePermissions"                        = (var.default_user_role_permissions == null ? null : { for key0, value0 in { "@odata.type" = var.default_user_role_permissions["odata_type"], "allowedToCreateApps" = var.default_user_role_permissions["allowedToCreateApps"], "allowedToCreateSecurityGroups" = var.default_user_role_permissions["allowedToCreateSecurityGroups"], "allowedToCreateTenants" = var.default_user_role_permissions["allowedToCreateTenants"], "allowedToReadBitlockerKeysForOwnedDevice" = var.default_user_role_permissions["allowedToReadBitlockerKeysForOwnedDevice"], "allowedToReadOtherUsers" = var.default_user_role_permissions["allowedToReadOtherUsers"] } : key0 => value0 if value0 != null })
    "deletedDateTime"                                   = var.deleted_date_time
    "description"                                       = var.description
    "displayName"                                       = var.display_name
    "enabledPreviewFeatures"                            = (var.enabled_preview_features == null ? null : [for item0 in var.enabled_preview_features : item0 if item0 != null])
    "guestUserRoleId"                                   = var.guest_user_role_id
    "@odata.type"                                       = var.odata_type
    "permissionGrantPolicyIdsAssignedToDefaultUserRole" = (var.permission_grant_policy_ids_assigned_to_default_user_role == null ? null : [for item0 in var.permission_grant_policy_ids_assigned_to_default_user_role : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "policies/authorizationPolicy"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
