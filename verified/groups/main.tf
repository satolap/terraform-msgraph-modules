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
    var.is_assignable_to_role != null ? { isAssignableToRole = var.is_assignable_to_role } : {},
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

resource "msgraph_resource" "group" {
  url         = "groups"
  api_version = var.api_version
  body        = local.body

  response_export_values = {
    display_name = "displayName"
    mail         = "mail"
  }

  lifecycle {
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
  }
}
