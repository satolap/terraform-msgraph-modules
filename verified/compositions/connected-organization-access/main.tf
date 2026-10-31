locals {
  # The default naming convention. naming.templates replaces these per key. The
  # organization token is display_name and additional_description
  # is the input of that name; the optional segment leaves the line out when it is
  # null.
  default_templates = {
    connected_organization_description    = "{organization} connected organization[\n{additional_description}]"
    catalog                               = "{organization}"
    catalog_description                   = "Resources and access packages for the {organization} connected organization"
    access_package                        = "{organization} guest access"
    access_package_description            = "Guest access for users of the {organization} connected organization"
    administrative_unit                   = "{organization} connected organization"
    administrative_unit_description       = "Groups of the {organization} connected organization"
    guests_group                          = "{organization|ascii|alnum}-guests"
    guests_group_mail_nickname            = "{organization|ascii|slug}-guests"
    guests_group_description              = "Guests of the {organization} connected organization, assigned through its access package"
    external_sponsors_group               = "{organization|ascii|alnum}-external-sponsors"
    external_sponsors_group_mail_nickname = "{organization|ascii|slug}-external-sponsors"
    external_sponsors_group_description   = "External sponsors of the {organization} connected organization"
    internal_sponsors_group               = "{organization|ascii|alnum}-internal-sponsors"
    internal_sponsors_group_mail_nickname = "{organization|ascii|slug}-internal-sponsors"
    internal_sponsors_group_description   = "Internal sponsors of the {organization} connected organization"
    requests_policy                       = "Connected organization requests"
    requests_policy_description           = "Requests from users of the {organization} connected organization"
    external_sponsor_policy               = "External sponsor access"
    external_sponsor_policy_description   = "Access for the external sponsors of the {organization} connected organization"
  }

  # The kind of each name that a child module takes, so that the naming module checks
  # it against that module's limits whatever the template. Descriptions have no kind.
  name_kinds = {
    catalog                               = "catalog"
    access_package                        = "access_package"
    administrative_unit                   = "administrative_unit"
    guests_group                          = "group"
    guests_group_mail_nickname            = "group_mail_nickname"
    external_sponsors_group               = "group"
    external_sponsors_group_mail_nickname = "group_mail_nickname"
    internal_sponsors_group               = "group"
    internal_sponsors_group_mail_nickname = "group_mail_nickname"
    requests_policy                       = "assignment_policy"
    external_sponsor_policy               = "assignment_policy"
  }

  # The names, and the patterns that the convention derives for them. Each child
  # module gets the pattern of its name as name_pattern, so it rejects a name that
  # does not follow the convention, even one set here by mistake.
  names    = module.names.names
  patterns = module.names.patterns

  # User and group IDs have no case. The members modules compare them as text, so
  # every ID is passed on in lower case.
  invitation_addresses = var.external_sponsor_invitations == null ? [] : [for address in var.external_sponsor_invitations.email_addresses : lower(address)]
  invited_user_ids     = { for address, invitation in msgraph_resource_action.external_sponsor_invitation : address => lower(invitation.output.user_id) }
  external_sponsor_member_ids = distinct(concat(
    [for id in var.external_sponsor_ids : lower(id)],
    values(local.invited_user_ids),
  ))
  internal_sponsor_member_ids = distinct([for id in var.internal_sponsor_ids : lower(id)])

  # The My Access link to the access package. Microsoft Learn shows the tenant hint
  # as @<domain> between the host and the fragment.
  my_access_url = var.my_access_tenant == null ? "https://myaccess.microsoft.com/#/access-packages/${module.access_package.id}" : "https://myaccess.microsoft.com/@${var.my_access_tenant}#/access-packages/${module.access_package.id}"

  sponsor_groups = {
    external_sponsors = module.external_sponsors_group.id
    internal_sponsors = module.internal_sponsors_group.id
  }

  # One approval stage per entry of approval_stages: the organization's sponsors of
  # that kind approve, and the members of the matching group approve when the
  # organization has no such sponsor.
  approval_stages = [
    for stage in var.requests_policy.approval_stages : {
      approval_timeout_in_days        = var.requests_policy.approval_timeout_in_days
      isApproverJustificationRequired = var.requests_policy.is_approver_justification_required
      primaryApprovers                = [{ type = stage == "external_sponsors" ? "externalSponsors" : "internalSponsors" }]
      fallbackPrimaryApprovers        = [{ type = "groupMembers", id = local.sponsor_groups[stage] }]
    }
  ]

  requests_policy_approval_settings = {
    isApprovalRequiredForAdd         = length(local.approval_stages) > 0
    isApprovalRequiredForUpdate      = length(local.approval_stages) > 0 && var.requests_policy.is_approval_required_for_update
    isRequestorJustificationRequired = var.requests_policy.is_requestor_justification_required
    stages                           = local.approval_stages
  }

  requests_policy_expiration = {
    type          = var.requests_policy.assignments_expire ? "afterDuration" : "noExpiration"
    duration_days = var.requests_policy.assignments_expire ? var.requests_policy.expiration_in_days : null
  }

  # External sponsors request for themselves, extend while they are members of the
  # external sponsors group, and can give up their access.
  external_sponsor_policy_expiration = {
    type          = "afterDuration"
    duration_days = var.external_sponsor_policy.expiration_in_days
  }
  external_sponsor_policy_requestor_settings = {
    allowCustomAssignmentSchedule   = false
    enableTargetsToSelfAddAccess    = true
    enableTargetsToSelfUpdateAccess = true
    enableTargetsToSelfRemoveAccess = true
  }

  # Users of the organization request for themselves; nobody requests on their behalf.
  requests_policy_requestor_settings = {
    allowCustomAssignmentSchedule   = var.requests_policy.allow_custom_assignment_schedule
    enableTargetsToSelfAddAccess    = true
    enableTargetsToSelfUpdateAccess = var.requests_policy.enable_targets_to_self_update_access
    enableTargetsToSelfRemoveAccess = var.requests_policy.enable_targets_to_self_remove_access
  }

  # Recurring reviews of the assignments by the internal sponsors group. Turning
  # reviews off sends isEnabled = false: leaving reviewSettings out may keep them
  # enabled (GB-entitlement-management-507).
  access_review = var.requests_policy.access_review
  review_settings = local.access_review == null ? null : {
    isEnabled                       = local.access_review.enabled
    expirationBehavior              = local.access_review.expiration_behavior
    isRecommendationEnabled         = local.access_review.is_recommendation_enabled
    isReviewerJustificationRequired = local.access_review.is_reviewer_justification_required
    isSelfReview                    = false
    primaryReviewers                = [{ type = "groupMembers", id = module.internal_sponsors_group.id }]
    fallbackReviewers               = []
    schedule = {
      startDateTime    = local.access_review.start_date_time
      duration_in_days = local.access_review.duration_in_days
      recurrence = {
        type     = local.access_review.recurrence_type
        interval = local.access_review.recurrence_interval
      }
    }
  }

  # The questions in the shape of the assignment-policies module, which names their
  # attributes as Graph does; this composition keeps its own snake_case names.
  questions = [
    for q in var.questions : {
      text                       = q.text
      isRequired                 = q.is_required
      isAnswerEditable           = q.is_answer_editable
      sequence                   = q.sequence
      type                       = q.type
      isSingleLineQuestion       = q.is_single_line_question
      regexPattern               = q.regex_pattern
      isMultipleSelectionAllowed = q.is_multiple_selection_allowed
      localizations              = q.localizations == null ? null : [for l in q.localizations : { text = l.text, languageCode = l.language_code }]
      choices = q.choices == null ? null : [
        for c in q.choices : {
          text          = c.text
          actualValue   = c.actual_value
          localizations = c.localizations == null ? null : [for l in c.localizations : { text = l.text, languageCode = l.language_code }]
        }
      ]
    }
  ]

  # The stage settings of each policy: every stage of every extension that names the
  # policy, in the shape of the assignment-policies input.
  extension_bindings = {
    for policy in ["requests", "external_sponsor"] : policy => flatten([
      for key, extension in var.custom_extensions : [
        for stage in extension.stages : merge(module.custom_extensions[key].binding, { stage = stage })
      ] if contains(extension.policies, policy)
    ])
  }
}

module "names" {
  source = "../../naming"

  templates = merge(local.default_templates, var.naming.templates)
  tokens = merge(var.naming.tokens, {
    organization           = var.display_name
    additional_description = var.additional_description
  })
  kinds            = local.name_kinds
  constraints      = var.naming.constraints
  transliterations = var.naming.transliterations
}

# --- Groups and the administrative unit ---

# Entitlement management adds the users who are assigned the access package to the
# guests group, through its Member role in the access package.
module "guests_group" {
  source = "../../groups"

  displayName           = local.names.guests_group
  mailNickname          = local.names.guests_group_mail_nickname
  description           = local.names.guests_group_description
  name_pattern          = local.patterns.guests_group
  mail_nickname_pattern = local.patterns.guests_group_mail_nickname
}

# The sponsor groups are created empty; the members modules below own their
# membership, because the groups module binds members only on creation.
module "external_sponsors_group" {
  source = "../../groups"

  displayName           = local.names.external_sponsors_group
  mailNickname          = local.names.external_sponsors_group_mail_nickname
  description           = local.names.external_sponsors_group_description
  name_pattern          = local.patterns.external_sponsors_group
  mail_nickname_pattern = local.patterns.external_sponsors_group_mail_nickname
}

module "internal_sponsors_group" {
  source = "../../groups"

  displayName           = local.names.internal_sponsors_group
  mailNickname          = local.names.internal_sponsors_group_mail_nickname
  description           = local.names.internal_sponsors_group_description
  name_pattern          = local.patterns.internal_sponsors_group
  mail_nickname_pattern = local.patterns.internal_sponsors_group_mail_nickname
}

module "external_sponsors_members" {
  source = "../../groups/members"

  group-id   = module.external_sponsors_group.id
  member_ids = local.external_sponsor_member_ids
}

module "internal_sponsors_members" {
  source = "../../groups/members"

  group-id   = module.internal_sponsors_group.id
  member_ids = local.internal_sponsor_member_ids
}

module "administrative_unit" {
  source = "../../directory/administrativeUnits"
  count  = var.administrative_unit.enabled ? 1 : 0

  displayName  = local.names.administrative_unit
  description  = local.names.administrative_unit_description
  name_pattern = local.patterns.administrative_unit
  visibility   = var.administrative_unit.visibility
  member_ids = [
    module.guests_group.id,
    module.external_sponsors_group.id,
    module.internal_sponsors_group.id,
  ]
}

# --- Connected organization ---

# The sponsor groups are the organization's only sponsors: the module manages each
# relationship authoritatively, so users added as sponsors elsewhere are removed.
module "connected_organization" {
  source = "../../identityGovernance/entitlementManagement/connectedOrganizations"

  displayName  = var.display_name
  name_pattern = var.name_pattern
  description  = local.names.connected_organization_description
  state        = var.connected_organization_state
  identity_sources = [
    for source in var.identity_sources : {
      type        = source.type
      tenantId    = source.tenant_id
      domainName  = source.domain_name
      displayName = source.display_name
    }
  ]
  internal_sponsor_ids = [module.internal_sponsors_group.id]
  external_sponsor_ids = [module.external_sponsors_group.id]
}

# --- Catalog and access package ---

# A catalog must be published and enabled for external users before users of a
# connected organization can request its access packages.
module "catalog" {
  source = "../../identityGovernance/entitlementManagement/catalogs"

  displayName         = local.names.catalog
  description         = local.names.catalog_description
  name_pattern        = local.patterns.catalog
  state               = "published"
  isExternallyVisible = true
}

# The role scope references the guests group's catalog resource but does not order
# the package against it: the package must be deleted before the resource is
# removed from the catalog, which Graph refuses while a package still uses it
# (GB-live-cleanup-502).
module "access_package" {
  source = "../../identityGovernance/entitlementManagement/accessPackages"

  catalog_id   = module.catalog.id
  displayName  = local.names.access_package
  description  = local.names.access_package_description
  name_pattern = local.patterns.access_package
  isHidden     = var.is_access_package_hidden

  depends_on = [module.guests_group_resource]
}

module "guests_group_resource" {
  source = "../../identityGovernance/entitlementManagement/catalogs/resources"

  accessPackageCatalog-id = module.catalog.id
  resource_origin_system  = "AadGroup"
  resource_origin_id      = module.guests_group.id
  resource_display_name   = local.names.guests_group
  enable_destroy_cleanup  = var.enable_destroy_cleanup
}

module "guests_role_scope" {
  source = "../../identityGovernance/entitlementManagement/accessPackages/resourceRoleScopes"

  accessPackage-id       = module.access_package.id
  catalog_id             = module.catalog.id
  catalog_resource_id    = module.guests_group_resource.resource_id
  resource_origin_system = "AadGroup"
  role_display_name      = "Member"
  enable_destroy_cleanup = var.enable_destroy_cleanup
}

module "custom_extensions" {
  source   = "../../identityGovernance/entitlementManagement/catalogs/customWorkflowExtensions"
  for_each = var.custom_extensions

  accessPackageCatalog-id = module.catalog.id
  extension_type          = each.value.extension_type
  logic_app = {
    subscriptionId       = each.value.logic_app.subscription_id
    resourceGroupName    = each.value.logic_app.resource_group_name
    logicAppWorkflowName = each.value.logic_app.workflow_name
    url                  = each.value.logic_app.trigger_url
  }
  displayName = coalesce(each.value.display_name, each.key)
  description = each.value.description
  callback    = each.value.callback == null ? null : { timeoutDuration = each.value.callback.timeout }
}

# --- Policies ---

module "requests_policy" {
  source = "../../identityGovernance/entitlementManagement/assignmentPolicies"

  access_package_id        = module.access_package.id
  displayName              = local.names.requests_policy
  description              = local.names.requests_policy_description
  name_pattern             = local.patterns.requests_policy
  allowedTargetScope       = "specificConnectedOrganizationUsers"
  specific_allowed_targets = [module.connected_organization.specific_allowed_target]

  expiration                = local.requests_policy_expiration
  requestor_settings        = local.requests_policy_requestor_settings
  request_approval_settings = local.requests_policy_approval_settings

  questions                       = local.questions
  review_settings                 = local.review_settings
  custom_extension_stage_settings = local.extension_bindings["requests"]
}

module "external_sponsor_policy" {
  source = "../../identityGovernance/entitlementManagement/assignmentPolicies"
  count  = var.external_sponsor_policy.enabled ? 1 : 0

  access_package_id  = module.access_package.id
  displayName        = local.names.external_sponsor_policy
  description        = local.names.external_sponsor_policy_description
  name_pattern       = local.patterns.external_sponsor_policy
  allowedTargetScope = "specificDirectoryUsers"

  specific_allowed_targets = [
    { type = "groupMembers", id = module.external_sponsors_group.id },
  ]

  # A sponsor's assignment expires, so removing the sponsor from the group ends the
  # access at the latest when the assignment expires: only current members can
  # extend it. Removing a member does not end the assignment itself.
  expiration = local.external_sponsor_policy_expiration

  requestor_settings = local.external_sponsor_policy_requestor_settings

  questions                       = local.questions
  custom_extension_stage_settings = local.extension_bindings["external_sponsor"]
}

# --- Optional guest invitations for external sponsors ---

# One POST to invitations per address, when its entry is created. The action runs
# again whenever its arguments change, which would send the invitation again, so a
# later change of the redirect or the message is ignored. Destroying the entry sends
# nothing: the guest user stays in the tenant.
resource "msgraph_resource_action" "external_sponsor_invitation" {
  for_each = toset(local.invitation_addresses)

  resource_url = "invitations"
  method       = "POST"
  api_version  = "v1.0"

  body = merge(
    {
      invitedUserEmailAddress = each.key
      inviteRedirectUrl       = coalesce(var.external_sponsor_invitations.redirect_url, local.my_access_url)
      sendInvitationMessage   = var.external_sponsor_invitations.send_invitation_message
    },
    var.external_sponsor_invitations.message_language == null && var.external_sponsor_invitations.customized_message_body == null ? {} : {
      invitedUserMessageInfo = merge(
        var.external_sponsor_invitations.message_language == null ? {} : { messageLanguage = var.external_sponsor_invitations.message_language },
        var.external_sponsor_invitations.customized_message_body == null ? {} : { customizedMessageBody = var.external_sponsor_invitations.customized_message_body },
      )
    },
  )

  response_export_values = {
    user_id = "invitedUser.id"
  }

  lifecycle {
    ignore_changes = [body]
  }
}

# Warns, without failing the plan or apply, when an approval stage or the access
# reviews rely on a sponsor group that has no member. Graph then has no approver
# or reviewer for the stage, and Microsoft Learn does not say what happens to the
# request. Members can be added later, so this is a warning.
check "sponsors_for_approvals" {
  assert {
    condition = alltrue([
      contains(var.requests_policy.approval_stages, "external_sponsors") ? length(var.external_sponsor_ids) + length(local.invitation_addresses) > 0 : true,
      contains(var.requests_policy.approval_stages, "internal_sponsors") || try(var.requests_policy.access_review.enabled, false) ? length(var.internal_sponsor_ids) > 0 : true,
    ])
    error_message = "An approval stage or the access reviews of ${var.display_name} have nobody to ask: external_sponsors stages need external_sponsor_ids or external_sponsor_invitations, and internal_sponsors stages and access reviews need internal_sponsor_ids. Add sponsors, or remove the stage from requests_policy.approval_stages."
  }
}
