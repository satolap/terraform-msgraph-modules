locals {
  is_dynamic = var.membership_type == "Dynamic"

  # Every managed key except the dynamic ones is in the body, on create and on
  # update. The provider's PATCH carries only the keys whose values changed, and
  # Microsoft Graph keeps the properties that a PATCH omits, so a description or
  # visibility that is no longer configured is sent as null rather than left out.
  # membershipType is always sent, so that a change from "Dynamic" to "Assigned"
  # reaches Graph. The rule and its processing state are sent only for a dynamic
  # unit: Microsoft Learn's example of that change sends membershipType alone,
  # and Learn says the rule is then no longer processed.
  body = merge(
    {
      displayName                  = var.display_name
      description                  = var.description
      visibility                   = var.visibility
      isMemberManagementRestricted = var.is_member_management_restricted
      membershipType               = var.membership_type
    },
    local.is_dynamic ? {
      membershipRule                = var.membership_rule
      membershipRuleProcessingState = var.membership_rule_processing_state == null ? "On" : var.membership_rule_processing_state
    } : {},
  )

  # A GUID has no case, and Learn's response examples show member ids in lower
  # case. The provider compares the configured ids with the ones it read as
  # exact strings, so an id in another case than the read one would plan the
  # removal and the addition of the same member. Null leaves the members
  # unmanaged.
  member_ids = var.member_ids == null ? null : [for id in var.member_ids : lower(id)]

  # A unit or a member object created moments before can be missing from the
  # replica that serves the next request, and Microsoft Learn says to retry such
  # a request after a delay. The provider retries a 404 or a 400 only when the
  # error message matches one of these expressions: the "does not exist" message
  # of a missing directory object, and the replication message that Learn
  # documents for adding a group member. An expression stops before an
  # apostrophe, which a JSON body may carry escaped.
  replication_delay_errors = [
    "does not exist or one of its queried reference-property objects are not present",
    "The source resource object or one of the objects being referenced",
  ]
}

# Microsoft Learn documents isMemberManagementRestricted as immutable: the
# update operation does not list it. A change replaces the unit, and the new
# unit is created before the old one is deleted, so the members, and any role
# assignment that references the id in the same state, move to the new unit
# before the old one goes away. Learn does not say that display names must be
# unique, which the overlap needs.
resource "terraform_data" "immutable" {
  input = {
    is_member_management_restricted = var.is_member_management_restricted
  }
}

resource "msgraph_resource" "this" {
  url         = "directory/administrativeUnits"
  api_version = "v1.0"
  body        = local.body

  # Learn documents that membershipType, visibility and isMemberManagementRestricted
  # are null when they were never set, and does not say what Graph returns
  # after a value is sent. A null in the response is therefore not drift; a
  # different non-null value is.
  ignore_missing_property = true

  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [terraform_data.immutable]

    precondition {
      condition     = !local.is_dynamic || var.membership_rule != null
      error_message = "membership_type is \"Dynamic\", so membership_rule is required: the rule selects the members of a dynamic unit."
    }

    precondition {
      condition     = local.is_dynamic || (var.membership_rule == null && var.membership_rule_processing_state == null)
      error_message = "membership_rule and membership_rule_processing_state apply only to a dynamic unit. Set membership_type to \"Dynamic\", or leave both null."
    }

    precondition {
      condition     = !local.is_dynamic || var.member_ids == null
      error_message = "membership_type is \"Dynamic\", so member_ids must be null: Microsoft Learn says that adding and removing members is disabled for a dynamic unit, whose rule selects them."
    }
    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.display_name))
      error_message = "display_name \"${var.display_name}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set display_name to a value that matches, or change name_pattern."
    }
  }
}

# The members as one authoritative $ref collection. The provider adds each
# missing id with {"@odata.id": "https://graph.microsoft.com/v1.0/directoryObjects/<id>"}
# and removes every other member with a DELETE of .../members/<id>/$ref. The url
# holds the unit's id, so the collection is created after the unit and after
# every resource whose id member_ids holds, without a depends_on. A replacement
# of the unit changes the url, which replaces the collection: the old one is
# destroyed first, which removes the members from the old unit, and the new one
# adds them to the new unit. The collection does not set create_before_destroy,
# because Terraform would then force it on every resource whose id member_ids
# holds, such as the member groups.
resource "msgraph_resource_collection" "members" {
  count = var.member_ids == null ? 0 : 1

  url           = "directory/administrativeUnits/${msgraph_resource.this.id}/members/$ref"
  api_version   = "v1.0"
  reference_ids = local.member_ids

  retry = {
    error_message_regex = local.replication_delay_errors
  }
}

# Learn documents create, list, get and delete for a scoped role membership and
# no update, so a change of an entry's role or member must replace the
# assignment instead of sending a PATCH. This stand-in holds the pair of each
# entry and triggers that replacement.
resource "terraform_data" "scoped_role_member" {
  for_each = var.scoped_role_members

  input = {
    role_id   = lower(each.value.role_id)
    member_id = lower(each.value.member_id)
  }
}

# Microsoft Entra role assignments scoped to this unit, one scopedRoleMembership
# per entry. The entries are keyed by names that the caller chooses, so the
# keys are known at plan time while a role_id or member_id can be the id of an
# object that the same apply creates, and the request retries the replication
# delays that a new object causes. The url holds the unit's id, so a replacement
# of the unit replaces every assignment: the new unit gets them again.
resource "msgraph_resource" "scoped_role_member" {
  for_each = var.scoped_role_members

  url         = "directory/administrativeUnits/${msgraph_resource.this.id}/scopedRoleMembers"
  api_version = "v1.0"
  body = {
    roleId = lower(each.value.role_id)
    roleMemberInfo = {
      id = lower(each.value.member_id)
    }
  }

  # The response adds the member's displayName and userPrincipalName and the
  # unit's id next to the sent values.
  ignore_missing_property = true

  retry = {
    error_message_regex = local.replication_delay_errors
  }

  lifecycle {
    replace_triggered_by = [terraform_data.scoped_role_member[each.key]]
  }
}
