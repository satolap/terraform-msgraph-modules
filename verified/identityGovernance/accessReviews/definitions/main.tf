locals {
  group_id = lower(var.group_id)

  reviewer_ids          = [for id in var.reviewer_user_ids : lower(id)]
  fallback_reviewer_ids = [for id in var.fallback_reviewer_user_ids : lower(id)]

  # The documented query scope of a group's members. transitiveMembers flattens
  # nested groups; members is direct only.
  scope_query = var.membership_scope == "transitive" ? "/groups/${local.group_id}/transitiveMembers" : "/groups/${local.group_id}/members"

  # Safety switches are fixed, not inputs. Decisions are never applied and no
  # default decision is taken, so an unanswered review changes no access. Mail
  # and reminder automation stay off. applyActions is deliberately not sent:
  # omission does not prove removal is disabled (removeAccessApplyAction is the
  # documented default), so the module relies on autoApplyDecisionsEnabled =
  # false and exposes no destructive action.
  safety_settings = {
    autoApplyDecisionsEnabled            = false
    defaultDecisionEnabled               = false
    mailNotificationsEnabled             = false
    reminderNotificationsEnabled         = false
    decisionHistoriesForReviewersEnabled = false
  }

  # Built with merge so numberOfOccurrences stays a number: a conditional between
  # two object shapes would unify them to a map of strings.
  recurrence_range = merge(
    {
      type      = var.recurrence.number_of_occurrences == null ? "noEnd" : "numbered"
      startDate = var.start_date
    },
    var.recurrence.number_of_occurrences == null ? {} : { numberOfOccurrences = var.recurrence.number_of_occurrences },
  )

  # PUT expects every writable property, not only the changed ones, so every
  # property the module manages is in the body on create and on update.
  # Properties it does not manage (stageSettings, additionalNotificationRecipients,
  # instanceEnumerationScope, applyActions and others) are not sent and a PUT
  # may clear them; the README lists this limit.
  body = {
    displayName             = var.display_name
    descriptionForAdmins    = var.description_for_admins
    descriptionForReviewers = var.description_for_reviewers
    scope = {
      "@odata.type" = "#microsoft.graph.accessReviewQueryScope"
      query         = local.scope_query
      queryType     = "MicrosoftGraph"
    }
    reviewers = [
      for id in local.reviewer_ids : { query = "/users/${id}", queryType = "MicrosoftGraph" }
    ]
    fallbackReviewers = [
      for id in local.fallback_reviewer_ids : { query = "/users/${id}", queryType = "MicrosoftGraph" }
    ]
    settings = merge(local.safety_settings, {
      instanceDurationInDays          = var.instance_duration_in_days
      recommendationsEnabled          = var.recommendations_enabled
      justificationRequiredOnApproval = var.justification_required_on_approval
      recurrence = {
        pattern = merge(
          {
            type     = var.recurrence.type
            interval = var.recurrence.interval
          },
          var.recurrence.type == "absoluteMonthly" ? { dayOfMonth = var.recurrence.day_of_month } : {},
        )
        range = local.recurrence_range
      }
    })
  }
}

# Microsoft Learn's update table does not list scope, so a change of the reviewed
# group or of the membership scope is not an established in-place edit. Terraform
# updates this trigger before it replaces the definition, so such a change creates a
# new definition after deleting the old series instead of sending a PUT that Graph
# may ignore or refuse. Whether Graph accepts a scope edit is not verified; this
# conservative replacement is the module's policy, not a documented rule.
resource "terraform_data" "scope" {
  input = local.scope_query
}

# One access review definition. Microsoft Learn documents the update as a PUT of
# the full writable object (204, no body), so the provider's native PUT is used.
# Destroying the module sends DELETE on the definition. That removes the series;
# Learn does not establish what happens to instances, decisions and history, and
# the module never claims deletion revokes access.
resource "msgraph_resource" "this" {
  url           = "identityGovernance/accessReviews/definitions"
  api_version   = "v1.0"
  body          = local.body
  update_method = "PUT"

  # Graph returns normalized and service-added properties; a key the read does
  # not return keeps its configured value instead of showing as a permanent change.
  ignore_missing_property = true

  response_export_values = {
    status = "status"
  }

  timeouts {
    create = var.timeouts.create
    read   = var.timeouts.read
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

  lifecycle {
    replace_triggered_by = [terraform_data.scope]

    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.display_name))
      error_message = "display_name \"${var.display_name}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set display_name to a value that matches, or change name_pattern."
    }
    precondition {
      condition     = length(setintersection(toset(local.reviewer_ids), toset(local.fallback_reviewer_ids))) == 0
      error_message = "A user is in both reviewer_user_ids and fallback_reviewer_user_ids. Fallback reviewers must differ from the primary reviewers."
    }
  }
}
