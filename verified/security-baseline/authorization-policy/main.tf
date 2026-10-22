# Manages the tenant authorizationPolicy singleton: it always exists, so the module creates
# and deletes nothing. It PATCHes only the managed properties and can PATCH the values it
# captured before the first apply back. Removing msgraph_update_resource sends no request in
# the pinned provider line, so removal is two steps (restore, then destroy). See:
# https://learn.microsoft.com/graph/api/authorizationpolicy-update?view=graph-rest-1.0

# For p1 and p2 the shared licence guard fails the plan unless a usable subscription lists
# the tier's service plan. The free tier reads no licences.
module "licence_guard" {
  source = "../licence-guard"

  tier = var.tier
}

locals {
  drp = "defaultUserRolePermissions."

  # Guest role template IDs, https://learn.microsoft.com/graph/api/authorizationpolicy-update?view=graph-rest-1.0
  guest_role_ids = {
    restricted = "2af84b1e-32c8-42b7-82bc-daa82404023b" # Restricted Guest User
    limited    = "10dae51f-b6af-4016-8d66-8c2a99b929b3" # Guest User
  }

  consent_key  = "${local.drp}permissionGrantPoliciesAssigned"
  apps_key     = "${local.drp}allowedToCreateApps"
  tenants_key  = "${local.drp}allowedToCreateTenants"
  self_prefix  = "managepermissiongrantsforself."
  self_entries = var.user_consent_policy_id == null ? [] : ["managePermissionGrantsForSelf.${var.user_consent_policy_id}"]
  self_target  = lower(join("", local.self_entries))

  policy = data.msgraph_resource.policy.output

  # Current tenant values. Every value is a JSON string so that all property maps share one
  # type and compare as text. The postcondition on the read guarantees the consent list is
  # present, so a missing list never reads as an empty one.
  current_grants = try(tolist(local.policy.permission_grant_policies), [])
  current_json = {
    "allowInvitesFrom"             = jsonencode(try(local.policy.allow_invites_from, null))
    "guestUserRoleId"              = jsonencode(try(local.policy.guest_user_role_id, null))
    "allowUserConsentForRiskyApps" = jsonencode(try(local.policy.allow_user_consent_for_risky_apps, null))
    (local.consent_key)            = jsonencode(try(local.policy.permission_grant_policies, null))
    (local.apps_key)               = jsonencode(try(local.policy.allowed_to_create_apps, null))
    (local.tenants_key)            = jsonencode(try(local.policy.allowed_to_create_tenants, null))
  }

  # Scalar properties the module always or optionally manages.
  target_scalars = merge(
    {
      "allowInvitesFrom"             = jsonencode(var.allow_invites_from)
      "guestUserRoleId"              = jsonencode(local.guest_role_ids[var.guest_access])
      "allowUserConsentForRiskyApps" = jsonencode(false)
    },
    var.allow_users_to_create_apps == null ? {} : { (local.apps_key) = jsonencode(var.allow_users_to_create_apps) },
    var.allow_users_to_create_tenants == null ? {} : { (local.tenants_key) = jsonencode(var.allow_users_to_create_tenants) },
  )

  # Only managePermissionGrantsForSelf.* entries are replaced; every other entry, such as
  # ManagePermissionGrantsForOwnedResource.*, is kept. The prefix match ignores case. An
  # existing entry for the chosen policy keeps its spelling and position, so a tenant that
  # already holds the target plans no change; otherwise the entry is appended.
  kept_grants  = distinct([for entry in local.current_grants : entry if !startswith(lower(entry), local.self_prefix) || lower(entry) == local.self_target])
  self_present = anytrue([for entry in local.current_grants : lower(entry) == local.self_target])
  apply_grants = local.self_present ? local.kept_grants : concat(local.kept_grants, local.self_entries)
  apply_json   = merge(local.target_scalars, { (local.consent_key) = jsonencode(local.apply_grants) })

  # The snapshot is the first plan's read of the managed properties; ignore_changes keeps it.
  prior_json   = terraform_data.snapshot.output
  prior_grants = try(tolist(jsondecode(local.prior_json[local.consent_key])), [])
  prior_self   = [for entry in local.prior_grants : entry if startswith(lower(entry), local.self_prefix)]

  # A restore touches only what the module manages: the consent list becomes the current
  # non-self entries plus the snapshot's self entries, and an optional property is restored
  # only when its input is set. A null snapshot value is not restored.
  restore_keys = [
    for key, value in local.prior_json : key
    if value != "null" && key != local.consent_key && contains(keys(local.target_scalars), key)
  ]
  restore_json = merge(
    { for key in local.restore_keys : key => local.prior_json[key] },
    { (local.consent_key) = jsonencode(concat([for entry in local.current_grants : entry if !startswith(lower(entry), local.self_prefix)], local.prior_self)) },
  )
  effective = var.restore_prior_values ? local.restore_json : local.apply_json

  body_nested = { for key, value in local.effective : trimprefix(key, local.drp) => jsondecode(value) if startswith(key, local.drp) }
  body = merge(
    { for key, value in local.effective : key => jsondecode(value) if !startswith(key, local.drp) },
    { for key, value in { defaultUserRolePermissions = local.body_nested } : key => value if length(value) > 0 },
  )

  # Values compare as lowercase text, and the self-consent entries as a sorted lowercase set.
  norm_current        = { for key, value in local.current_json : key => lower(value) }
  norm_prior          = { for key, value in local.prior_json : key => lower(value) }
  norm_effective      = { for key, value in local.effective : key => key == local.consent_key ? jsonencode(sort([for entry in jsondecode(value) : lower(entry)])) : lower(value) }
  norm_current_grants = jsonencode(sort([for entry in local.current_grants : lower(entry)]))

  current_self_set = jsonencode(sort([for entry in local.current_grants : lower(entry) if startswith(lower(entry), local.self_prefix)]))
  target_self_set  = jsonencode(sort([for entry in local.self_entries : lower(entry)]))
  prior_self_set   = jsonencode(sort([for entry in local.prior_self : lower(entry)]))

  # A restore may overwrite only a property that still holds the value the current inputs
  # would apply, or already holds the snapshot value. The inputs are those of this run, so
  # keep them unchanged while restoring.
  drifted_keys = concat(
    local.current_self_set != local.target_self_set && local.current_self_set != local.prior_self_set ? [local.consent_key] : [],
    [
      for key in sort(local.restore_keys) : key
      if local.norm_current[key] != local.norm_prior[key] && local.norm_current[key] != lower(local.target_scalars[key])
    ],
  )

  consent_policy_ids = try([for policy in data.msgraph_resource.consent_policies[0].output.policies : policy.id], [])

  planned_changes = [
    for key in sort(keys(local.effective)) : {
      property = key
      current  = local.current_json[key]
      target   = local.effective[key]
    } if var.restore_prior_values ? local.current_json[key] != local.effective[key] : (key == local.consent_key ? local.norm_current_grants : local.norm_current[key]) != local.norm_effective[key]
  ]
}

# Plan-time read of the current values: the snapshot source and the base of the consent list.
data "msgraph_resource" "policy" {
  url         = "policies/authorizationPolicy"
  api_version = "v1.0"

  response_export_values = {
    allow_invites_from                = "allowInvitesFrom"
    guest_user_role_id                = "guestUserRoleId"
    allow_user_consent_for_risky_apps = "allowUserConsentForRiskyApps"
    permission_grant_policies         = "defaultUserRolePermissions.permissionGrantPoliciesAssigned"
    allowed_to_create_apps            = "defaultUserRolePermissions.allowedToCreateApps"
    allowed_to_create_tenants         = "defaultUserRolePermissions.allowedToCreateTenants"
  }

  lifecycle {
    postcondition {
      condition = try(
        self.output.allow_invites_from != null && self.output.allow_invites_from == tostring(self.output.allow_invites_from) &&
        self.output.guest_user_role_id != null && self.output.guest_user_role_id == tostring(self.output.guest_user_role_id) &&
        self.output.permission_grant_policies != null && can(concat(self.output.permission_grant_policies, [])) && alltrue([for entry in self.output.permission_grant_policies : entry == tostring(entry)]) &&
        (self.output.allow_user_consent_for_risky_apps == null || self.output.allow_user_consent_for_risky_apps == tobool(self.output.allow_user_consent_for_risky_apps)) &&
        (self.output.allowed_to_create_apps == null || self.output.allowed_to_create_apps == tobool(self.output.allowed_to_create_apps)) &&
        (self.output.allowed_to_create_tenants == null || self.output.allowed_to_create_tenants == tobool(self.output.allowed_to_create_tenants)),
        false
      )
      error_message = "The authorizationPolicy response is malformed or incomplete: allowInvitesFrom and guestUserRoleId must be strings, and the consent list must be present (an empty list is accepted, a missing one fails the plan so that no entry is deleted by mistake), and the boolean properties must have their documented types."
    }
  }
}

# The chosen consent policy must exist. The policies are listed and matched, so a missing one
# fails a precondition that names its ID instead of a 404.
data "msgraph_resource" "consent_policies" {
  count = var.user_consent_policy_id == null || var.restore_prior_values ? 0 : 1

  url         = "policies/permissionGrantPolicies"
  api_version = "v1.0"

  query_parameters = {
    "$select" = ["id"]
  }

  response_export_values = {
    policies  = "value"
    next_link = "\"@odata.nextLink\""
  }

  lifecycle {
    postcondition {
      condition = try(
        self.output.policies != null && can(concat(self.output.policies, [])) &&
        contains(keys(self.output), "next_link") && self.output.next_link == null &&
        alltrue([for policy in self.output.policies : policy.id != null && policy.id == tostring(policy.id)]),
        false
      )
      error_message = "The permission grant policy response is malformed, incomplete or still paginated."
    }
  }
}

# Captured on first apply and never updated: later plans keep the original values. If the
# tenant already carries baseline values then (for example after lost state), those are
# captured instead.
resource "terraform_data" "snapshot" {
  input = local.current_json

  lifecycle {
    ignore_changes = [input]
  }
}

resource "terraform_data" "gate" {
  input = module.licence_guard.tier

  lifecycle {
    precondition {
      condition     = var.restore_prior_values || (var.user_consent_policy_id == null ? true : contains(local.consent_policy_ids, var.user_consent_policy_id))
      error_message = "The app consent policy \"${var.user_consent_policy_id == null ? "" : var.user_consent_policy_id}\" was not found in the tenant's permission grant policies."
    }

    precondition {
      condition     = !var.restore_prior_values || var.restore_over_changes || length(local.drifted_keys) == 0
      error_message = "Restore refused: ${join(", ", local.drifted_keys)} hold neither the value the current inputs would apply nor the snapshot value, so they were changed after the apply, or the inputs changed since the apply. Keep the inputs unchanged while restoring, review the tenant, or set restore_over_changes = true to restore the snapshot over those changes."
    }
  }
}

resource "msgraph_update_resource" "policy" {
  url                     = "policies/authorizationPolicy"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  read_query_parameters = {
    "$select" = ["allowInvitesFrom,guestUserRoleId,allowUserConsentForRiskyApps,defaultUserRolePermissions"]
  }

  depends_on = [terraform_data.gate, terraform_data.snapshot]
}
