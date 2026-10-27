# Manages the tenant singleton entitlementManagementSettings: what entitlement management
# does to an external user (guest) when their last access package assignment is removed.
# The singleton always exists, so the module never creates or deletes it: it PATCHes only the
# properties the caller owns, as the Update reference allows ("change one or more of its
# properties"):
# https://learn.microsoft.com/graph/api/entitlementmanagementsettings-update?view=graph-rest-1.0
# Metadata lists a delete on this path; Microsoft documents none, so the module has no
# resource that can issue one and destroying it sends no request.
#
# Ownership: an input that is null is not owned. It is left out of every request and of every
# restore, so a setting changed by someone else, or by another tool, is not overwritten.

locals {
  # The owned properties, spelled as Graph spells them. Null inputs are omitted.
  owned_input = merge(
    var.external_user_lifecycle_action == null ? {} : { externalUserLifecycleAction = var.external_user_lifecycle_action },
    var.duration_until_external_user_deleted_after_blocked == null ? {} : { durationUntilExternalUserDeletedAfterBlocked = var.duration_until_external_user_deleted_after_blocked },
  )

  # Both settings as read before the module first wrote them. The id and OData annotations
  # are never sent back. A null duration stays null here and is left out of a restore.
  current = try(data.msgraph_resource.settings.output.settings, null)
  snapshot_input = local.current == null ? null : {
    externalUserLifecycleAction                  = local.current.externalUserLifecycleAction
    durationUntilExternalUserDeletedAfterBlocked = try(local.current.durationUntilExternalUserDeletedAfterBlocked, null)
  }

  snapshot = terraform_data.previous_state.output

  # The properties that were owned when the snapshot was taken. A property that became owned
  # later has no pre-module value in the snapshot, only a stale read, so it is never restored.
  captured_owned = terraform_data.owned_at_capture.output

  # A restore sends the snapshot value of each property that is owned now, was owned at the
  # first apply, and that the snapshot holds.
  restore_body = local.snapshot == null ? null : {
    for key, value in local.snapshot : key => value
    if contains(keys(local.owned_input), key) && contains(local.captured_owned, key) && value != null
  }

  # A restore may overwrite only a property that still holds what the inputs would apply, or
  # already holds the snapshot value. Anything else was changed by someone else since. The
  # comparison is exact, as the provider's is. The inputs are those of this run, so keep them
  # unchanged while restoring.
  restore_over_changes = local.restore_body == null || local.current == null ? [] : sort([
    for key in keys(local.restore_body) : key
    if try(tostring(local.current[key]), null) != local.owned_input[key] && try(tostring(local.current[key]), null) != tostring(local.snapshot[key])
  ])

  # Terraform before 1.12 evaluates both sides of && and || (the supported floor is 1.11), so
  # no operand below may error when an earlier one decides the result.
  # Both branches are JSON text, so the restore body and the inputs need no common type.
  body = jsondecode(var.restore_previous_state ? jsonencode(local.restore_body) : jsonencode(local.owned_input))

  # Owned properties whose current value differs from the input. The comparison is exact, as
  # the provider's is: Microsoft's examples spell the enum both "None" and "none", so a service
  # that returns another spelling than the input shows drift on every plan (see the README).
  drifted_properties = sort([
    for key, value in local.owned_input : key
    if local.current == null || try(tostring(local.current[key]), null) != value
  ])
}

# One read per plan. Only the first one is kept (see terraform_data.previous_state).
data "msgraph_resource" "settings" {
  url         = "identityGovernance/entitlementManagement/settings"
  api_version = "v1.0"

  response_export_values = {
    settings = "@"
  }

  lifecycle {
    postcondition {
      # Terraform before 1.12 evaluates both sides of && and ||, so nested conditionals,
      # which evaluate only the chosen branch, guard each later operand.
      condition = try(
        self.output.settings == null ? false : (
          contains(["none", "blocksignin", "blocksigninanddelete"], lower(self.output.settings.externalUserLifecycleAction)) ? (
            try(self.output.settings.durationUntilExternalUserDeletedAfterBlocked, null) == null ? true : (
              self.output.settings.durationUntilExternalUserDeletedAfterBlocked == tostring(self.output.settings.durationUntilExternalUserDeletedAfterBlocked)
            )
          ) : false
        ),
        false
      )
      error_message = "The entitlementManagementSettings response is malformed or holds an externalUserLifecycleAction other than none, blockSignIn or blockSignInAndDelete; the settings cannot be snapshotted."
    }
  }
}

# The snapshot is taken once and never overwritten: ignore_changes keeps later reads out.
# Restoring takes two steps, restore_previous_state = true and apply, then destroy. The
# snapshot is built from a response that the data source postcondition validated. On the
# very first apply a restore sends the owned settings as just read, which changes nothing.
resource "terraform_data" "previous_state" {
  input = local.snapshot_input

  lifecycle {
    ignore_changes = [input]
  }
}

# The properties owned at the first apply, kept like the snapshot.
resource "terraform_data" "owned_at_capture" {
  input = sort(keys(local.owned_input))

  lifecycle {
    ignore_changes = [input]
  }
}

# Destroying this resource sends no request, so the settings stay as last set.
resource "msgraph_update_resource" "this" {
  url                    = "identityGovernance/entitlementManagement/settings"
  api_version            = "v1.0"
  update_method          = "PATCH"
  body                   = local.body
  response_export_values = { settings = "@" }

  # The snapshot must exist before the first write.
  depends_on = [terraform_data.previous_state, terraform_data.owned_at_capture]

  lifecycle {
    precondition {
      condition     = length(local.owned_input) > 0
      error_message = "Set at least one of external_user_lifecycle_action and duration_until_external_user_deleted_after_blocked. A setting whose input is null is not owned, so there would be nothing to write or restore."
    }

    precondition {
      condition     = var.restore_previous_state || var.external_user_lifecycle_action != "blockSignInAndDelete" || var.allow_external_user_deletion
      error_message = "external_user_lifecycle_action = \"blockSignInAndDelete\" makes entitlement management delete guest accounts tenant-wide. Set allow_external_user_deletion = true to confirm."
    }

    precondition {
      condition     = var.restore_previous_state || var.external_user_lifecycle_action != "blockSignInAndDelete" || var.duration_until_external_user_deleted_after_blocked != null
      error_message = "external_user_lifecycle_action = \"blockSignInAndDelete\" needs duration_until_external_user_deleted_after_blocked. Without it the request would turn deletion on with whatever duration the tenant already holds, or fail at Graph when none exists."
    }

    precondition {
      condition     = !var.restore_previous_state || try(local.restore_body.externalUserLifecycleAction, null) != "blockSignInAndDelete" || var.allow_external_user_deletion
      error_message = "The snapshot holds externalUserLifecycleAction = \"blockSignInAndDelete\", so the restore would turn guest deletion back on. Set allow_external_user_deletion = true to confirm."
    }

    precondition {
      condition     = !var.restore_previous_state || try(length(local.restore_body) > 0, true)
      error_message = "None of the properties owned now were owned when the snapshot was taken, so there is nothing to restore."
    }

    precondition {
      condition     = !var.restore_previous_state || var.restore_over_changes || length(local.restore_over_changes) == 0
      error_message = "A restore would overwrite a property that someone changed since the module last wrote it. Set restore_over_changes = true to restore the snapshot over those changes."
    }

    precondition {
      condition     = !var.restore_previous_state || local.snapshot != null
      error_message = "restore_previous_state = true needs the snapshot captured by the first apply, and none is available."
    }
  }
}
