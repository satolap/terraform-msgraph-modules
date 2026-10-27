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

# Microsoft Learn's update group page does not list mailEnabled or groupTypes
# "Unified" as updatable, and Graph documents no conversion between a security
# group and a Microsoft 365 group. Only the "DynamicMembership" value of
# groupTypes is documented as changeable on an existing group (static to dynamic
# and back). This resource keeps the two creation-time values, because
# ignore_changes keeps the stored input, and the preconditions below refuse a
# change before any PATCH is sent. It is replaced together with the group when
# terraform_data.immutable replaces it, so a replacement may also carry a new
# mail setting. Read the snapshot through `input`, which is known in the plan;
# the output is not. For a group that exists from before this resource, or that
# was imported, the snapshot is taken from the first plan, so upgrade with
# unchanged mail_enabled and group_types first; the postconditions on the group
# catch a conversion that Graph ignored in that window.
resource "terraform_data" "created" {
  input = {
    mail_enabled = var.mail_enabled
    unified      = contains(var.group_types, "Unified")
  }
  triggers_replace = terraform_data.immutable.input

  lifecycle {
    ignore_changes = [input]
  }
}

resource "msgraph_resource" "group" {
  url         = "groups"
  api_version = var.api_version
  body        = local.body

  response_export_values = {
    display_name = "displayName"
    mail         = "mail"
    # Read back so that a mail setting or group type that Graph ignored fails
    # the postconditions below.
    mail_enabled = "mailEnabled"
    group_types  = "groupTypes"
  }

  lifecycle {
    # terraform_data.created is replaced only together with terraform_data.immutable,
    # so naming it adds no replacement. It lets the declaration say that mail_enabled
    # and group_types are kept from creation: a change is refused.
    replace_triggered_by = [terraform_data.immutable, terraform_data.created]

    precondition {
      condition     = !local.is_dynamic || try(length(trimspace(var.membership_rule)) > 0, false)
      error_message = "membership_rule is required when group_types includes \"DynamicMembership\"."
    }
    precondition {
      condition     = contains(var.group_types, "Unified") ? var.mail_enabled : (!var.mail_enabled && var.security_enabled)
      error_message = "Microsoft Graph can create mail-enabled Unified groups or non-mail-enabled security groups; distribution and mail-enabled security groups are read-only."
    }
    precondition {
      # Defence in depth: today the mail/security precondition above already refuses
      # a mail_enabled change that is not paired with Unified.
      condition     = var.mail_enabled == terraform_data.created.input.mail_enabled
      error_message = "mail_enabled cannot be changed on an existing group: Microsoft Learn's update group page does not list mailEnabled as updatable. Create a new group with the other setting and migrate its members and references."
    }
    precondition {
      condition     = contains(var.group_types, "Unified") == terraform_data.created.input.unified
      error_message = "\"Unified\" cannot be added to or removed from group_types of an existing group: Microsoft Graph documents no conversion between a security group and a Microsoft 365 group. Create a new group and migrate its members and references. Adding or removing \"DynamicMembership\" is allowed."
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
    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.display_name))
      error_message = "display_name \"${var.display_name}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set display_name to a value that matches, or change name_pattern."
    }
    precondition {
      condition     = var.mail_nickname_pattern == null || can(regex(var.mail_nickname_pattern, var.mail_nickname))
      error_message = "mail_nickname \"${var.mail_nickname}\" does not match mail_nickname_pattern \"${var.mail_nickname_pattern == null ? "" : var.mail_nickname_pattern}\". Set mail_nickname to a value that matches, or change mail_nickname_pattern."
    }

    # terraform_data.created is seeded from the configuration, so the first plan
    # after an upgrade, or after an import, cannot refuse a conversion made in that
    # same plan. These postconditions compare what Graph returned with the
    # configuration, so a conversion that Graph ignored fails at apply. The
    # provider plans output as unknown in an update (GB-msgraph-provider-614), so
    # they are decided after apply; a missing or null read-back fails closed.
    postcondition {
      condition     = try(self.output.mail_enabled == var.mail_enabled, false)
      error_message = "Microsoft Graph returned a mailEnabled value that differs from mail_enabled, or none. mailEnabled is not updatable on an existing group; the group was not changed to the configured setting."
    }
    postcondition {
      condition     = try(contains(self.output.group_types, "Unified") == contains(var.group_types, "Unified"), false)
      error_message = "Microsoft Graph returned a groupTypes value whose Unified entry differs from group_types, or none. Unified is not updatable on an existing group; the group was not converted."
    }
  }
}
