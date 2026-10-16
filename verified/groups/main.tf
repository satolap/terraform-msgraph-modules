locals {
  graph_base = "https://graph.microsoft.com/${var.api_version}"

  is_dynamic = contains(var.group_types, "DynamicMembership")

  body = merge(
    {
      displayName     = var.display_name
      mailNickname    = var.mail_nickname
      mailEnabled     = var.mail_enabled
      securityEnabled = var.security_enabled
      groupTypes      = var.group_types
    },
    var.description != null ? { description = var.description } : {},
    var.visibility != null ? { visibility = var.visibility } : {},
    # Graph sets isAssignableToRole only at creation, and false is its default.
    # Sending only true keeps a change between null and false, which keeps the
    # group, out of the body: the provider's PATCH carries only the keys that
    # changed or appeared, so it never sends a key that left the body.
    var.is_assignable_to_role == true ? { isAssignableToRole = true } : {},
    local.is_dynamic && var.membership_rule != null ? {
      membershipRule                = var.membership_rule
      membershipRuleProcessingState = "On"
    } : {},
    length(var.owner_ids) > 0 ? {
      "owners@odata.bind" = [for id in var.owner_ids : "${local.graph_base}/directoryObjects/${id}"]
    } : {},
    length(var.member_ids) > 0 ? {
      "members@odata.bind" = [for id in var.member_ids : "${local.graph_base}/directoryObjects/${id}"]
    } : {},
  )
}

# Microsoft Learn says isAssignableToRole can be set only while creating the
# group, and that HiddenMembership visibility can be set only at creation and
# not updated later. A change of either replaces the group instead of sending a
# PATCH that Graph does not apply. Null and false both create a group that is
# not role-assignable, so a change between them keeps the group. The old group
# is deleted before the new one is created, because the mail nickname of a
# Microsoft 365 group must be unique.
resource "terraform_data" "immutable" {
  input = {
    is_assignable_to_role = var.is_assignable_to_role == true
    hidden_membership     = var.visibility == "HiddenMembership"
  }
}

resource "msgraph_resource" "group" {
  url         = "groups"
  api_version = var.api_version
  body        = local.body

  response_export_values = {
    display_name = "displayName"
    mail         = "mail"
  }

  lifecycle {
    replace_triggered_by = [terraform_data.immutable]

    precondition {
      condition     = !local.is_dynamic || try(length(trimspace(var.membership_rule)) > 0, false)
      error_message = "membership_rule is required when group_types includes \"DynamicMembership\"."
    }
    precondition {
      condition     = contains(var.group_types, "Unified") ? var.mail_enabled : (!var.mail_enabled && var.security_enabled)
      error_message = "Microsoft Graph can create mail-enabled Unified groups or non-mail-enabled security groups; distribution and mail-enabled security groups are read-only."
    }
    precondition {
      condition     = !local.is_dynamic || length(var.member_ids) == 0
      error_message = "Dynamic groups derive members from membership_rule; member_ids must be empty."
    }
    precondition {
      condition     = var.is_assignable_to_role != true || (var.security_enabled && !local.is_dynamic)
      error_message = "Role-assignable groups must have security_enabled=true and cannot have dynamic membership."
    }
    # A change of either create-only input deletes the group before Graph sees
    # the new one, so a combination that Graph refuses must stop the plan.
    precondition {
      condition     = var.is_assignable_to_role != true || var.visibility == null || var.visibility == "Private"
      error_message = "Role-assignable groups are always Private: leave visibility null or set it to \"Private\"."
    }
    precondition {
      condition     = var.visibility != "HiddenMembership" || contains(var.group_types, "Unified")
      error_message = "visibility \"HiddenMembership\" applies only to Microsoft 365 groups: add \"Unified\" to group_types or choose another visibility."
    }
  }
}
