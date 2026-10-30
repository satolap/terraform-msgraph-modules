variable "display_name" {
  description = "Display name of the connected organization. It is also the organization token of the naming convention, so by default it names the catalog, the access package, the administrative unit, the groups and their mail nicknames."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.display_name)) > 0
    error_message = "display_name must not be empty."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that display_name must match, such as the pattern of a naming convention. When it is set and display_name does not match, the plan fails. Null, the default, accepts any display_name."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}

variable "additional_description" {
  description = "Extra text for the description of the connected organization. With the default naming convention it goes on a new line after \"<display_name> connected organization\"; null leaves it out. It is the additional_description token of the naming convention."
  type        = string
  default     = null
}

variable "identity_sources" {
  description = "The tenants and domains whose users belong to the connected organization, passed to the connected-organizations module: { type = \"tenant\", tenant_id, display_name } for a Microsoft Entra tenant, { type = \"tenant_domain\", domain_name } for a tenant that the module looks up by one of its domains during the plan, and { type = \"domain\", domain_name, display_name } for a domain without a Microsoft Entra tenant, whose users sign in with a one-time passcode. That module validates the list."
  type = list(object({
    type         = string
    tenant_id    = optional(string)
    domain_name  = optional(string)
    display_name = optional(string)
  }))
  nullable = false
}

variable "connected_organization_state" {
  description = "State of the connected organization: \"configured\" (the default) or \"proposed\". Only a configured organization counts for policies that target all configured connected organizations; the policies of this module name the organization directly."
  type        = string
  default     = "configured"
  nullable    = false

  validation {
    condition     = contains(["configured", "proposed"], var.connected_organization_state)
    error_message = "connected_organization_state must be \"configured\" or \"proposed\"."
  }
}

variable "internal_sponsor_ids" {
  description = "Object IDs of the users in your tenant who sponsor the organization. They become the members of the internal sponsors group, which is the connected organization's internal sponsor, the fallback approver of the internal sponsor approval stage and the reviewer of access reviews. The group's membership is authoritative: members not in this list are removed."
  type        = list(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for id in var.internal_sponsor_ids : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", id))])
    error_message = "internal_sponsor_ids must contain only user object IDs, each a GUID."
  }
}

variable "external_sponsor_ids" {
  description = "Object IDs of the guest users from the organization who sponsor it. Together with the users that external_sponsor_invitations invites, they become the members of the external sponsors group, which is the connected organization's external sponsor, the fallback approver of the external sponsor approval stage and the population of the external sponsor policy. The group's membership is authoritative."
  type        = list(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for id in var.external_sponsor_ids : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", id))])
    error_message = "external_sponsor_ids must contain only user object IDs, each a GUID."
  }
}

variable "external_sponsor_invitations" {
  description = "Guest invitations for external sponsors who are not in the tenant yet, or null (the default) for none. Each address in email_addresses is invited once, with a POST to invitations when its entry is first created, and the invited user joins the external sponsors group. send_invitation_message (default true) lets Microsoft Graph send the invitation email; message_language and customized_message_body shape it. redirect_url is where the user lands after redeeming the invitation; null uses the My Access link of the access package (see my_access_tenant). An invitation is never sent again and never revoked by Terraform: removing an address removes the user from the group but not from the tenant."
  type = object({
    email_addresses         = list(string)
    send_invitation_message = optional(bool, true)
    redirect_url            = optional(string)
    message_language        = optional(string)
    customized_message_body = optional(string)
  })
  default = null

  validation {
    condition     = var.external_sponsor_invitations == null || try(alltrue([for address in var.external_sponsor_invitations.email_addresses : can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", address))]), false)
    error_message = "external_sponsor_invitations.email_addresses must contain only email addresses."
  }

  validation {
    condition     = var.external_sponsor_invitations == null || try(length(distinct([for address in var.external_sponsor_invitations.email_addresses : lower(address)])) == length(var.external_sponsor_invitations.email_addresses), false)
    error_message = "external_sponsor_invitations.email_addresses must name each address once, ignoring case."
  }

  validation {
    condition     = var.external_sponsor_invitations == null || try(var.external_sponsor_invitations.redirect_url == null || can(regex("^https://", var.external_sponsor_invitations.redirect_url)), false)
    error_message = "external_sponsor_invitations.redirect_url must be an https URL."
  }
}

variable "my_access_tenant" {
  description = "A verified domain or the tenant ID of your tenant, used as the tenant hint of the My Access link to the access package (https://myaccess.microsoft.com/@<tenant>#/access-packages/<id>). The tenant hint makes the portal load your tenant for a requestor from the organization. Null builds the link without it; Microsoft Learn says such a user then needs the portal's organization switcher to reach your tenant."
  type        = string
  default     = null

  # The domain grammar is the one the connected-organizations module applies to
  # identity source domains.
  validation {
    condition = var.my_access_tenant == null ? true : (
      can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", var.my_access_tenant)) ||
      (can(regex("^(?i)[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?(?:\\.[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?)+$", var.my_access_tenant)) && length(var.my_access_tenant) <= 253)
    )
    error_message = "my_access_tenant must be a domain name such as contoso.com, with at least two labels and at most 253 characters, or a tenant ID (a GUID)."
  }
}

variable "requests_policy" {
  description = <<-EOT
    The policy through which users of the connected organization request the access
    package. approval_stages lists the approval stages in order, each "external_sponsors"
    (the organization's external sponsors approve, with the external sponsors group as
    fallback) or "internal_sponsors" (its internal sponsors approve, with the internal
    sponsors group as fallback); an empty list requires no approval.
    approval_timeout_in_days is how long each stage waits before the request is denied.
    expiration_in_days is how long an assignment lasts; assignments_expire = false makes
    assignments permanent instead.
    access_review, when set, starts recurring reviews of the assignments by the internal
    sponsors group on start_date_time, a fixed RFC 3339 timestamp in UTC; the defaults
    review every three months, keep each review open for 25 days and remove access that
    reviewers do not confirm. To stop the reviews, apply access_review.enabled = false
    before removing access_review: leaving the settings out may keep them running.
  EOT
  type = object({
    approval_stages                      = optional(list(string), ["external_sponsors", "internal_sponsors"])
    approval_timeout_in_days             = optional(number, 14)
    is_approval_required_for_update      = optional(bool, true)
    is_requestor_justification_required  = optional(bool, true)
    is_approver_justification_required   = optional(bool, true)
    assignments_expire                   = optional(bool, true)
    expiration_in_days                   = optional(number, 365)
    allow_custom_assignment_schedule     = optional(bool, true)
    enable_targets_to_self_update_access = optional(bool, true)
    enable_targets_to_self_remove_access = optional(bool, true)
    access_review = optional(object({
      enabled                            = optional(bool, true)
      start_date_time                    = string
      duration_in_days                   = optional(number, 25)
      recurrence_type                    = optional(string, "absoluteMonthly")
      recurrence_interval                = optional(number, 3)
      expiration_behavior                = optional(string, "removeAccess")
      is_recommendation_enabled          = optional(bool, true)
      is_reviewer_justification_required = optional(bool, true)
    }))
  })
  default  = {}
  nullable = false

  validation {
    condition     = alltrue([for stage in var.requests_policy.approval_stages : contains(["external_sponsors", "internal_sponsors"], stage)])
    error_message = "requests_policy.approval_stages entries must be \"external_sponsors\" or \"internal_sponsors\"."
  }

  validation {
    condition     = length(distinct(var.requests_policy.approval_stages)) == length(var.requests_policy.approval_stages)
    error_message = "requests_policy.approval_stages must name each stage at most once."
  }

  validation {
    condition     = try(var.requests_policy.approval_timeout_in_days >= 1 && floor(var.requests_policy.approval_timeout_in_days) == var.requests_policy.approval_timeout_in_days, false)
    error_message = "requests_policy.approval_timeout_in_days must be a whole number of at least 1."
  }

  validation {
    condition     = try(var.requests_policy.expiration_in_days >= 1 && floor(var.requests_policy.expiration_in_days) == var.requests_policy.expiration_in_days, false)
    error_message = "requests_policy.expiration_in_days must be a whole number of at least 1."
  }
}

variable "external_sponsor_policy" {
  description = "The policy through which the members of the external sponsors group can request the access package for themselves, without approval, so that sponsors can sign in to the tenant. An assignment expires after expiration_in_days (365 by default); a sponsor who is still a member of the group can extend it, and one who was removed cannot, so their access ends when it expires. Removing a member does not end an assignment early. enabled = false leaves the policy out."
  type = object({
    enabled            = optional(bool, true)
    expiration_in_days = optional(number, 365)
  })
  default  = {}
  nullable = false

  validation {
    condition     = try(var.external_sponsor_policy.expiration_in_days >= 1 && floor(var.external_sponsor_policy.expiration_in_days) == var.external_sponsor_policy.expiration_in_days, false)
    error_message = "external_sponsor_policy.expiration_in_days must be a whole number of at least 1."
  }
}

variable "questions" {
  description = "Questions that both policies ask the requestor, in the shape of the assignment-policies module's questions input: text_input or multiple_choice questions with optional localizations and, for multiple choice, choices. That module validates them."
  type = list(object({
    text               = string
    is_required        = optional(bool, false)
    is_answer_editable = optional(bool, true)
    sequence           = optional(number)
    type               = optional(string, "text_input")
    localizations = optional(list(object({
      text          = string
      language_code = string
    })))
    is_single_line_question       = optional(bool)
    regex_pattern                 = optional(string)
    is_multiple_selection_allowed = optional(bool)
    choices = optional(list(object({
      text         = string
      actual_value = string
      localizations = optional(list(object({
        text          = string
        language_code = string
      })))
    })))
  }))
  default  = []
  nullable = false
}

variable "custom_extensions" {
  description = <<-EOT
    Logic App custom extensions created in the catalog and bound to the policies, keyed by a
    name of your choice. logic_app names an existing Consumption Logic App, as in the
    catalogs/custom-extensions module. extension_type is "request_workflow" (the default)
    or "assignment_workflow". callback = { timeout = "PT1H" } makes a request workflow
    extension launch and wait. stages lists the policy stages that call the extension, such
    as "assignmentRequestGranted" and "assignmentRequestRemoved". policies lists the
    policies that bind it: "requests" and "external_sponsor" (both by default). display_name
    defaults to the map key. Each policy stage can be bound to one extension only.
  EOT
  type = map(object({
    display_name   = optional(string)
    description    = optional(string)
    extension_type = optional(string, "request_workflow")
    logic_app = object({
      subscription_id     = string
      resource_group_name = string
      workflow_name       = string
      trigger_url         = optional(string)
    })
    callback = optional(object({
      timeout = string
    }))
    stages   = list(string)
    policies = optional(list(string), ["requests", "external_sponsor"])
  }))
  default  = {}
  nullable = false

  validation {
    condition     = alltrue([for extension in values(var.custom_extensions) : length(extension.stages) > 0])
    error_message = "Every custom extension needs at least one stage in stages."
  }

  validation {
    condition     = alltrue(flatten([for extension in values(var.custom_extensions) : [for policy in extension.policies : contains(["requests", "external_sponsor"], policy)]]))
    error_message = "custom_extensions policies entries must be \"requests\" or \"external_sponsor\"."
  }

  validation {
    condition = alltrue([
      for policy in ["requests", "external_sponsor"] : length(flatten([
        for extension in values(var.custom_extensions) : extension.stages if contains(extension.policies, policy)
        ])) == length(distinct(flatten([
          for extension in values(var.custom_extensions) : extension.stages if contains(extension.policies, policy)
      ])))
    ])
    error_message = "custom_extensions bind a policy stage twice: each stage of a policy can call one extension only."
  }
}

variable "administrative_unit" {
  description = "The administrative unit that holds the three groups of the organization, so that a role scoped to the unit can manage them. enabled = false leaves the unit out. visibility is null or \"HiddenMembership\". The unit is never a restricted management unit: Microsoft Learn says that entitlement management cannot manage groups in such a unit."
  type = object({
    enabled    = optional(bool, true)
    visibility = optional(string)
  })
  default  = {}
  nullable = false
}

variable "is_access_package_hidden" {
  description = "Whether the access package is hidden in the My Access portal. A hidden package is requested through its My Access link; see the my_access_url output."
  type        = bool
  default     = false
  nullable    = false
}

variable "naming" {
  description = "Changes to the naming convention: templates are merged over the defaults per key, constraints adds rules of your own to the limits of each object's kind, tokens adds tokens to organization and additional_description, and transliterations changes the table of the ascii filter. See the naming module for the template syntax and the README for the keys and their kinds."
  type = object({
    templates = optional(map(string), {})
    tokens    = optional(map(string), {})
    constraints = optional(map(object({
      max_length = optional(number)
      pattern    = optional(string)
    })), {})
    transliterations = optional(map(string), {})
  })
  default  = {}
  nullable = false

  validation {
    condition     = length(setintersection(keys(var.naming.tokens), ["organization", "additional_description"])) == 0
    error_message = "naming.tokens cannot set organization or additional_description; set display_name and additional_description instead."
  }
}

variable "enable_destroy_cleanup" {
  description = "Passed to the catalogs/resources and access-packages/resource-role-scopes modules, which remove the guests group from the catalog and its role from the access package on destroy with the Azure CLI. Keep true for real deployments; set false only before the first apply when another owner handles removal, or in offline tests."
  type        = bool
  default     = true
  nullable    = false
}
