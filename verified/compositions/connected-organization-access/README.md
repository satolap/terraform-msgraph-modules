# compositions/connected-organization-access

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Potential personal-data inputs: `external_sponsor_invitations`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **optional**. Local module `../../groups`: Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Local module `../../groups`: Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Local module `../../groups`: Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Local module `../../groups/members`: v1.0 omits service principal members; select beta before the first apply when any may exist (GB-relationships-ref-504). Local module `../../groups/members`: v1.0 omits service principal members; select beta before the first apply when any may exist (GB-relationships-ref-504). Local module `../../identityGovernance/entitlementManagement/catalogs`: Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Local module `../../identityGovernance/entitlementManagement/accessPackages`: Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Local module `../../identityGovernance/entitlementManagement/catalogs/resources`: Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Local module `../../identityGovernance/entitlementManagement/accessPackages/resourceRoleScopes`: Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Local module `../../identityGovernance/entitlementManagement/assignmentPolicies`: Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Local module `../../identityGovernance/entitlementManagement/assignmentPolicies`: Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Sets up governed guest access for one **connected organization**: the organization itself,
a catalog and an access package through which its users request access, the groups that
hold its guests and sponsors, an administrative unit for those groups, two assignment
policies, and optionally custom extensions and guest invitations for its sponsors. It is a
composite: it calls the verified modules listed below with relative sources and adds only the
wiring between them, the default naming convention and the guest invitations.

Use one module instance per connected organization. For many organizations, call it with
`for_each` over a map, for example one decoded from a CSV file.

```text
connected organization ── identity sources (tenants, domains)
   ├─ internal sponsors = internal sponsors group ◄── internal_sponsor_ids
   └─ external sponsors = external sponsors group ◄── external_sponsor_ids + invitations

catalog (published, enabled for external users)
   ├─ resource: guests group
   ├─ custom extensions (optional)
   └─ access package
        ├─ role: Member of the guests group
        ├─ requests policy: users of the organization; sponsor approval stages,
        │    expiration, questions, optional access reviews by the internal sponsors group
        └─ external sponsor policy: members of the external sponsors group, no approval

administrative unit (optional) ── guests group, external and internal sponsors groups
```

## What the module manages, and what it does not

| Object | Module | Default name |
| --- | --- | --- |
| Connected organization | [connected-organizations](../../identityGovernance/entitlementManagement/connectedOrganizations/README.md) | `display_name` |
| Catalog, published and enabled for external users | [catalogs](../../identityGovernance/entitlementManagement/catalogs/README.md) | `{organization}` |
| Access package | [access-packages](../../identityGovernance/entitlementManagement/accessPackages/README.md) | `{organization} guest access` |
| Guests group in the catalog, with its Member role in the access package | [groups](../../groups/README.md), [catalogs/resources](../../identityGovernance/entitlementManagement/catalogs/resources/README.md), [resource-role-scopes](../../identityGovernance/entitlementManagement/accessPackages/resourceRoleScopes/README.md) | `{organization\|ascii\|alnum}-guests` |
| External and internal sponsors groups and their members | [groups](../../groups/README.md), [groups/members](../../groups/members/README.md) | `{organization\|ascii\|alnum}-external-sponsors`, `-internal-sponsors` |
| Administrative unit holding the three groups (optional) | [administrative-units](../../directory/administrativeUnits/README.md) | `{organization} connected organization` |
| Requests policy and external sponsor policy | [assignment-policies](../../identityGovernance/entitlementManagement/assignmentPolicies/README.md) | `Connected organization requests`, `External sponsor access` |
| Custom extensions (optional) | [catalogs/customWorkflowExtensions](../../identityGovernance/entitlementManagement/catalogs/customWorkflowExtensions/README.md) | the map key |
| Names and descriptions | [naming](../../naming/README.md) | see [Naming convention](#naming-convention) |
| Guest invitations for external sponsors (optional) | this module, `POST /invitations` | n/a |

- **Every rule of the child modules applies.** Their validations, preconditions, checks,
  permissions, licensing and lifecycle limits are documented in their READMEs, which this one
  does not repeat. Read them before the first apply.
- **The groups and memberships are authoritative.** The sponsor groups hold exactly
  `internal_sponsor_ids`, and `external_sponsor_ids` plus the invited users; the connected
  organization's sponsors are exactly the two groups; the administrative unit holds exactly
  the three groups. Members or sponsors added elsewhere are removed on the next apply.
- **Entitlement management fills the guests group.** The module adds no member to it: users
  join it when they are assigned the access package, and leave it when the assignment ends.
- **The Logic Apps are inputs.** Custom extensions name existing Logic Apps; the module
  creates no Azure resource and grants the Logic Apps no role.
- **Guests are invited once, never revoked.** See [External sponsors and invitations](#external-sponsors-and-invitations).
- **The module does not adopt existing objects.** It creates new ones. To bring objects that
  another tool created under management, import them into the child modules' resources; see
  [Limits and lifecycle](#limits-and-lifecycle).

## Usage

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "fabrikam" {
  source  = "satolap/modules/msgraph//verified/compositions/connected-organization-access"
  version = "<version>"

  display_name           = "Fabrikam"
  additional_description = "Logistics partner since 2024"
  identity_sources = [
    { type = "tenant_domain", domain_name = "fabrikam.com" },
  ]

  internal_sponsor_ids = [var.partner_manager_id]
  external_sponsor_invitations = {
    email_addresses = ["partner.lead@fabrikam.com"]
  }
  my_access_tenant = "contoso.com"

  requests_policy = {
    access_review = { start_date_time = "2026-11-01T00:00:00Z" }
  }
}

output "fabrikam_request_link" {
  value = module.fabrikam.my_access_url
}
```

### Many organizations from a CSV file

```hcl
locals {
  # organization,domains,internal_sponsors,external_sponsors
  # Fabrikam,fabrikam.com;fabrikam.net,<user id>,partner.lead@fabrikam.com
  partners = { for row in csvdecode(file("${path.module}/partners.csv")) : row.organization => row }
}

module "partner" {
  source   = "satolap/modules/msgraph//verified/compositions/connected-organization-access"
  version  = "<version>"
  for_each = local.partners

  display_name         = each.key
  identity_sources     = [for domain in split(";", each.value.domains) : { type = "tenant_domain", domain_name = domain }]
  internal_sponsor_ids = compact(split(";", each.value.internal_sponsors))
  external_sponsor_invitations = {
    email_addresses = compact(split(";", each.value.external_sponsors))
  }
  my_access_tenant = "contoso.com"
}
```

A `tenant_domain` source fails the plan when the domain belongs to no Microsoft Entra
tenant; use `type = "domain"` for such a domain. Internal sponsors are object IDs: look them
up with a `msgraph_resource` data source on `users` if the file holds addresses.

## Naming convention

Every name and description comes from a template of the [naming](../../naming/README.md)
module. `naming.templates` replaces a default per key, `naming.tokens` adds tokens, and
`naming.constraints` adds rules of your own per key. The tokens `organization`
(`display_name`) and `additional_description` are always set.

| Key | Default template | Kind |
| --- | --- | --- |
| `connected_organization_description` | `{organization} connected organization[\n{additional_description}]` | |
| `catalog` | `{organization}` | `catalog` |
| `catalog_description` | `Resources and access packages for the {organization} connected organization` | |
| `access_package` | `{organization} guest access` | `access_package` |
| `access_package_description` | `Guest access for users of the {organization} connected organization` | |
| `administrative_unit` | `{organization} connected organization` | `administrative_unit` |
| `administrative_unit_description` | `Groups of the {organization} connected organization` | |
| `guests_group` | `{organization\|ascii\|alnum}-guests` | `group` |
| `guests_group_mail_nickname` | `{organization\|ascii\|slug}-guests` | `group_mail_nickname` |
| `guests_group_description` | `Guests of the {organization} connected organization, assigned through its access package` | |
| `external_sponsors_group` | `{organization\|ascii\|alnum}-external-sponsors` | `group` |
| `external_sponsors_group_mail_nickname` | `{organization\|ascii\|slug}-external-sponsors` | `group_mail_nickname` |
| `external_sponsors_group_description` | `External sponsors of the {organization} connected organization` | |
| `internal_sponsors_group` | `{organization\|ascii\|alnum}-internal-sponsors` | `group` |
| `internal_sponsors_group_mail_nickname` | `{organization\|ascii\|slug}-internal-sponsors` | `group_mail_nickname` |
| `internal_sponsors_group_description` | `Internal sponsors of the {organization} connected organization` | |
| `requests_policy` | `Connected organization requests` | `assignment_policy` |
| `requests_policy_description` | `Requests from users of the {organization} connected organization` | |
| `external_sponsor_policy` | `External sponsor access` | `assignment_policy` |
| `external_sponsor_policy_description` | `Access for the external sponsors of the {organization} connected organization` | |

The kind of a name sets its limits, those of the verified module that takes the name: 90
characters for catalogs, access packages and policies, 256 for groups and administrative
units, and 64 ASCII characters without `@ ( ) \ [ ] " ; : < > ,` or a space for a mail
nickname. The kind applies to a replaced template too, and `naming.constraints` can only add
rules to it. The naming module's README lists the kinds and their sources.

The composite also passes the pattern that the convention derives for each name, which the
`name_patterns` output returns, to the `name_pattern` and `mail_nickname_pattern` inputs of
the module that takes it, so that module rejects a name that does not follow the convention.
With the default templates, the guests group must match `^[A-Za-z0-9]+-guests$` and its mail
nickname `^[a-z0-9]+(?:-[a-z0-9]+)*-guests$`. `name_pattern` holds `display_name`, the organization
token, to a pattern of your own; the connected-organizations module checks it. For example, a
hierarchical convention:

```hcl
naming = {
  templates = {
    catalog             = "Partners/{organization}"
    access_package      = "Partners/{organization}/Guests"
    administrative_unit = "Partners/{organization}/Groups"
    guests_group        = "{organization|ascii|alnum}-G-Guests"
  }
}
```

A changed template renames the objects in place, as the child modules update names; a renamed
access package keeps its ID and so its My Access link.

## Sponsors and approvals

The connected organization's **internal sponsors** and **external sponsors** are the two
sponsor groups, so a change of sponsors is a change of group members, not of the
organization. Microsoft Learn describes internal sponsors as users of your tenant and
external sponsors as users of the connected organization who are guests in your tenant
([Manage connected organizations](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-organization)).

`requests_policy.approval_stages` lists the approval stages in order:

| Stage | Primary approvers | Fallback approvers |
| --- | --- | --- |
| `external_sponsors` | the external sponsors of the requestor's connected organization | the members of the external sponsors group |
| `internal_sponsors` | the internal sponsors of the requestor's connected organization | the members of the internal sponsors group |

The default is both, external first, each with a 14-day timeout and approver justification.
An empty list requires no approval. Assignments expire after `expiration_in_days` (365 by
default), or never with `assignments_expire = false`. Users of the organization can request,
extend and remove their own access; nobody requests on their behalf.

`requests_policy.access_review` adds recurring access reviews of the assignments by the
members of the internal sponsors group. `start_date_time` is required and must be a fixed
RFC 3339 timestamp in UTC; by default a review runs every three months, stays open for 25
days and removes access that reviewers do not confirm. To stop the reviews, set
`access_review.enabled = false` and apply before you remove `access_review`: a policy
update without review settings may leave them enabled (GB-entitlement-management-507).

The **external sponsor policy** lets the members of the external sponsors group request the
access package without approval, so that sponsors become guests that can sign in and approve.
An assignment expires after `external_sponsor_policy.expiration_in_days`, 365 by default. A
sponsor who is still a member of the group can extend it, and can remove it. A sponsor who was
removed from `external_sponsor_ids` or `external_sponsor_invitations` cannot extend it, so the
access ends when it expires; to end it at once, remove the assignment in My Access or the
admin center. Set `external_sponsor_policy = { enabled = false }` to leave the policy out.

The `sponsors_for_approvals` check warns when an approval stage or the access reviews have
an empty sponsor group: the stage then has nobody to ask.

`questions` applies to both policies; see the assignment-policies module for the question
types and localizations.

## External sponsors and invitations

`external_sponsor_ids` takes guests who are already in the tenant. `external_sponsor_invitations`
invites addresses that are not, with one `POST /invitations` per address when its entry is
created ([Create invitation](https://learn.microsoft.com/en-us/graph/api/invitation-post?view=graph-rest-1.0)),
and adds the invited user to the external sponsors group.

- **Sent once.** The action ignores later changes of the redirect URL or the message, so
  that a change does not send the invitation again. Remove an address and add it again to
  send a new one.
- **Never revoked.** Removing an address removes the user from the external sponsors group,
  but not from the tenant. Delete the guest user separately when needed.
- **Redirect.** By default the user lands on the access package's My Access link, so that
  the sponsor can request access through the external sponsor policy.
- **Existing guests.** Microsoft Learn does not say what Graph returns for an address that
  already belongs to a guest of the tenant; whether it returns the existing user and sends
  the email again is not verified. Prefer `external_sponsor_ids` for known guests.
- **Propagation.** A new guest may not be visible at once; the group-members module retries
  the replication delay that Learn documents for adding a member.

The invitation needs `User.Invite.All`, or the Guest Inviter role for a delegated caller, and
the tenant's external collaboration settings must allow it; Learn says application
permissions do not work when B2B invitations are disabled.

## My Access link

`my_access_url` is `https://myaccess.microsoft.com/@<my_access_tenant>#/access-packages/<id>`,
the form that Learn shows for sharing an access package
([Share link to request an access package](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-access-package-settings)).
The tenant hint makes the portal load your tenant for a user from the organization; without
it the user has to switch organizations in the portal. The module builds the link for the
global service only; US Government uses `myaccess.microsoft.us`.

## Custom extensions

Each entry of `custom_extensions` creates one extension in the catalog and binds it to the
stages it lists in each policy it names (`requests`, `external_sponsor`, both by default).
`callback = { timeout = "PT1H" }` makes it launch and wait. Each stage of a policy can call
one extension.

Both policies can include guests, so the assignment-policies module's
`guest_custom_extension_prerequisite` check warns whenever an extension is bound: such a
policy needs the tenant linked to an Azure subscription for Microsoft Entra ID Governance for
guests, and each successful request is billed to it. The Logic App that resumes a launch and
wait request needs a role in the catalog, which this module does not assign; see the
custom-extensions README.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.6.0, < 0.7.0 |

The child modules also use `hashicorp/null` and `hashicorp/time`, and the destroy hooks of
catalogs/resources and resource-role-scopes need Bash, the Azure CLI and `ARM_TENANT_ID`.
The msgraph provider window matches the child modules and includes the tested 0.6.0 pin.
Terraform 1.11 is the floor of the verified modules that the composite calls, and its offline
test suite needs it too.

Least privileged application permissions for the whole module, from the child modules'
READMEs:

| Permission | For |
| --- | --- |
| `EntitlementManagement.ReadWrite.All` | Connected organization and its sponsors, catalog, resources, access package, role scope, custom extensions, policies |
| `Group.ReadWrite.All` | Creating and updating the three groups |
| `GroupMember.ReadWrite.All` | The sponsor groups' members |
| `AdministrativeUnit.ReadWrite.All` | The administrative unit and its members |
| `CrossTenantInformation.ReadBasic.All` | The tenant lookup of `tenant_domain` sources |
| `User.Invite.All` | Guest invitations |

- Adding and removing connected organization sponsors needs Identity Governance
  Administrator for a delegated caller; see the connected-organizations README.
- Custom extensions also need an Azure role on each Logic App for a delegated caller.
- Run Terraform as a dedicated automation identity; Learn names catalog roles that are
  narrower than `EntitlementManagement.ReadWrite.All` for most entitlement management calls.

## Prerequisites outside this module

- External collaboration settings that let users of the organization's domains be invited:
  an allow list must name them, and a block list must not
  ([Govern access for external users](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-external-users#settings-for-external-users)).
- Email one-time passcode for `domain` sources whose users have no Microsoft Entra tenant.
- For custom extensions: the Logic Apps, their HTTP triggers and authorization policies, and
  the Azure subscription link for Microsoft Entra ID Governance for guests.

## Limits and lifecycle

- **One state per organization's objects.** Keep a module instance in one Terraform state, so
  that Terraform orders the policies before the extensions and the connected organization
  they reference, and the members before the groups.
- **Destroy** deletes the policies, the role scope, the catalog resource, the access package,
  the catalog, the extensions, the connected organization, the administrative unit and the
  groups, in dependency order. Microsoft Graph does not delete an access package that still
  has assignments ([Delete accessPackage](https://learn.microsoft.com/en-us/graph/api/accesspackage-delete?view=graph-rest-1.0)),
  so remove the assignments first, for example with `adminRemove` assignment requests;
  whether the policies can be deleted while assignments exist is not verified. Invited
  guests stay in the tenant. The catalog resource and the role scope are removed with the
  Azure CLI hooks; set `enable_destroy_cleanup = false` only when another owner removes them.
- **Warnings that are expected.** `sponsors_for_approvals` (empty sponsor group),
  `guest_custom_extension_prerequisite` (an extension bound to a guest policy), and the
  connected-organizations module's `identity_source_conflicts` (another organization already
  names a tenant or domain) warn without failing the plan.
- **Adopting existing objects.** To take over objects that a script or the admin center
  created, import each into the child module resource that manages it, for example
  `module.<name>.module.catalog.msgraph_resource.catalog`, and check the first plan for
  replacements before applying. Import is not verified for every child module; their READMEs
  give the ID formats.
- **The administrative unit is never restricted.** Learn says that groups in a restricted
  management administrative unit cannot be managed by entitlement management or access
  reviews.

## Live test status

Live test status: not verified in a licensed tenant. The module is tested with mock providers
only, and every child module lists its own pending live checks. Specific to the composite:

1. An end-to-end request by a user of a `domain` and of a `tenant_domain` organization
   through the My Access link, with both approval stages and their fallbacks.
2. The external sponsor policy: an invited sponsor redeems the invitation, requests the
   access package and can then approve.
3. Invitations of an address that already belongs to a guest, and the propagation delay
   before the guest can join the external sponsors group.
4. Access reviews by the internal sponsors group.
5. Destroy of a populated setup, and import of objects that another tool created.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |
| `custom_extensions` is set | EM-ADVANCED | Automatic assignment through attribute rules, custom extensions and some advanced approval options require Microsoft Entra ID Governance or Microsoft Entra Suite. Microsoft Entra ID P2 alone is not sufficient. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user eligible under the policy that enables the advanced feature | group_based / per_user | documented |
| `requests_policy.access_review` is set | EM-ACCESS-REVIEWS | Recurring access reviews of the assignments made through an access package assignment policy require Microsoft Entra ID Governance or Microsoft Entra Suite. Access reviews licensing covers the member users who review access and the member users whose access is reviewed, self-reviewers included. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every member user who reviews the policy's assignments and every member user whose assignment is reviewed | group_based / per_user | documented |

Notes:

- The composite calls the verified groups, groups/members, administrative-units, connected-organizations, catalogs, catalogs/resources, catalogs/customWorkflowExtensions, access-packages, access-packages/resource-role-scopes, assignment-policies and naming modules, and every rule and note of those modules applies to it; this entry repeats their baselines and the conditions that its own inputs control.
- Creating the administrative unit and managing its members needs only Microsoft Entra ID Free. The composite assigns no role scoped to the unit; the ADMIN-UNITS rule, Microsoft Entra ID P1 for each administrator assigned such a role, applies to the configuration that assigns one.
- The users of the connected organization become guests when their requests are approved. Microsoft Entra ID Governance features that guests use are billed per monthly active user to a linked Azure subscription, and guests who sign in count as monthly active users of Microsoft Entra External ID; see the connected-organizations module for the details and for what is not verified.
- The composite rules were reviewed against Microsoft Learn on 2026-10-07, which is later than the review date stated above.
- When `custom_extensions` is set: Both policies of the composite can include guests, so a bound custom extension also needs the tenant linked to an Azure subscription for Microsoft Entra ID Governance for guests, and each successful request is billed to that subscription (https://learn.microsoft.com/en-us/entra/id-governance/microsoft-entra-id-governance-licensing-for-guest-users). Azure Logic Apps billing is separate and not modelled.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0), [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license), [Create an access review of an access package in entitlement management](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-access-reviews-create#prerequisites), [Microsoft Entra ID Governance licensing fundamentals: access reviews](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#access-reviews).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| display_name | Display name of the connected organization and the `organization` token | `string` | n/a | yes | changes `module.names`; see the module notes; changes `module.connected_organization`; see the module notes |
| name_pattern | RE2 expression that `display_name` must match, checked by the connected-organizations module | `string` | `null` | no | changes `module.connected_organization`; see the module notes |
| identity_sources | The organization's tenants and domains, as in the connected-organizations module | `list(object)` | n/a | yes | changes `module.connected_organization`; see the module notes |
| additional_description | Extra line for the connected organization's description | `string` | `null` | no | changes `module.names`; see the module notes |
| connected_organization_state | `configured` or `proposed` | `string` | `"configured"` | no | changes `module.connected_organization`; see the module notes |
| internal_sponsor_ids | User object IDs of the internal sponsors group | `list(string)` | `[]` | no | changes `module.internal_sponsors_members`; see the module notes |
| external_sponsor_ids | Guest user object IDs of the external sponsors group | `list(string)` | `[]` | no | changes `module.external_sponsors_members`; see the module notes |
| external_sponsor_invitations | `email_addresses` to invite once as external sponsors, with `send_invitation_message`, `redirect_url`, `message_language`, `customized_message_body` | `object` | `null` | no | creates or deletes `msgraph_resource_action.external_sponsor_invitation` instances; submits `msgraph_resource_action.external_sponsor_invitation` again |
| my_access_tenant | Domain or tenant ID for the My Access link's tenant hint | `string` | `null` | no | submits `msgraph_resource_action.external_sponsor_invitation` again |
| requests_policy | `approval_stages`, `approval_timeout_in_days`, approval and justification flags, `assignments_expire`, `expiration_in_days`, self-service flags, `access_review` | `object` | `{}` | no | changes `module.requests_policy`; see the module notes |
| external_sponsor_policy | `enabled`, and `expiration_in_days` of a sponsor's assignment | `object` | `{ enabled = true, expiration_in_days = 365 }` | no | changes `module.external_sponsor_policy`; see the module notes |
| questions | Questions both policies ask, as in the assignment-policies module | `list(object)` | `[]` | no | changes `module.requests_policy`; see the module notes; changes `module.external_sponsor_policy`; see the module notes |
| custom_extensions | Extensions by key: `logic_app`, `stages`, `policies`, `extension_type`, `callback`, `display_name`, `description` | `map(object)` | `{}` | no | changes `module.custom_extensions`; see the module notes; changes `module.requests_policy`; see the module notes; changes `module.external_sponsor_policy`; see the module notes |
| administrative_unit | `enabled`, `visibility` | `object` | `{ enabled = true }` | no | changes `module.administrative_unit`; see the module notes |
| is_access_package_hidden | Hide the access package in My Access | `bool` | `false` | no | changes `module.access_package`; see the module notes |
| naming | `templates`, `tokens`, `constraints`, `transliterations` merged over the convention | `object` | `{}` | no | changes `module.names`; see the module notes |
| enable_destroy_cleanup | Create the Azure CLI destroy hooks of the catalog resource and role scope | `bool` | `true` | no | changes `module.guests_group_resource`; see the module notes; changes `module.guests_role_scope`; see the module notes |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| names | Every rendered name and description, keyed like the templates | no |
| name_patterns | The pattern that the convention derives for every name, keyed like names; the object names' patterns go to the child modules' name_pattern inputs | no |
| connected_organization_id | The ID of the connected organization | no |
| identity_sources | The identity sources as sent, with looked-up tenants | no |
| catalog_id | The ID of the catalog | no |
| access_package_id | The ID of the access package | no |
| my_access_url | The My Access link to the access package | no |
| group_ids | `{ guests, external_sponsors, internal_sponsors }` | no |
| administrative_unit_id | The ID of the administrative unit, or `null` | no |
| requests_policy_id | The ID of the requests policy | no |
| external_sponsor_policy_id | The ID of the external sponsor policy, or `null` | no |
| custom_extension_ids | The IDs of the custom extensions by key | no |
| invited_user_ids | The invited users' object IDs by lower-case address | no |

## Tests

`tests/connected_organization_access.tftest.hcl` runs offline against mock providers and needs
Terraform 1.11 or later: `terraform init` and `terraform test` in this folder. It runs every
child module with fixed object IDs and covers the default names and their patterns, naming
overrides and transliteration, the approval stages, expiration, self-service settings and access reviews
passed to the requests policy, the authoritative memberships and sponsors, the catalog's
external visibility, the My Access link, the custom extension bindings, invitations (body,
lower-casing, not resent on change, removal from the group), the optional parts, the
tenant lookup, the sponsor check and every validation. The run with custom extensions
replaces the policy modules, whose guest billing check warns for any bound extension.
`tests/test_connected_organization_access.py` checks the validation messages, that the
default names are neutral and documented with their kinds, that every child module receives
the pattern of the name it takes, that every child source exists, and that the README covers
every input and output.

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `display_name`: changes `module.names`; see the module notes; changes `module.connected_organization`; see the module notes.
- `name_pattern`: changes `module.connected_organization`; see the module notes.
- `additional_description`: changes `module.names`; see the module notes.
- `identity_sources`: changes `module.connected_organization`; see the module notes.
- `connected_organization_state`: changes `module.connected_organization`; see the module notes.
- `internal_sponsor_ids`: changes `module.internal_sponsors_members`; see the module notes.
- `external_sponsor_ids`: changes `module.external_sponsors_members`; see the module notes.
- `external_sponsor_invitations`: creates or deletes `msgraph_resource_action.external_sponsor_invitation` instances; submits `msgraph_resource_action.external_sponsor_invitation` again.
- `my_access_tenant`: submits `msgraph_resource_action.external_sponsor_invitation` again.
- `requests_policy`: changes `module.requests_policy`; see the module notes.
- `external_sponsor_policy`: changes `module.external_sponsor_policy`; see the module notes.
- `questions`: changes `module.requests_policy`; see the module notes; changes `module.external_sponsor_policy`; see the module notes.
- `custom_extensions`: changes `module.custom_extensions`; see the module notes; changes `module.requests_policy`; see the module notes; changes `module.external_sponsor_policy`; see the module notes.
- `administrative_unit`: changes `module.administrative_unit`; see the module notes.
- `is_access_package_hidden`: changes `module.access_package`; see the module notes.
- `naming`: changes `module.names`; see the module notes.
- `enable_destroy_cleanup`: changes `module.guests_group_resource`; see the module notes; changes `module.guests_role_scope`; see the module notes.
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `POST /invitations` | DelegatedWork | `User.Invite.All` | - | - |
| `POST /invitations` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /invitations` | Application | `User.Invite.All` | - | - |
| `POST /groups` | DelegatedWork | `Group.ReadWrite.All` | - | - |
| `POST /groups` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /groups` | Application | `Group.Create` | - | - |
| `GET /groups/{id}` | DelegatedWork | `Group-NestingSupport.ReadWrite.All` | - | - |
| `GET /groups/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /groups/{id}` | Application | `Group-NestingSupport.ReadWrite.All` | - | - |
| `DELETE /groups/{id}` | DelegatedWork | `Group.ReadWrite.All` | - | - |
| `DELETE /groups/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /groups/{id}` | Application | `Group.ReadWrite.All` | - | - |
| `PATCH /groups/{id}` | DelegatedWork | `Group-NestingSupport.ReadWrite.All` | - | - |
| `PATCH /groups/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /groups/{id}` | Application | `Group-NestingSupport.ReadWrite.All` | - | - |
| `GET /groups/{id}/members` | DelegatedWork | `GroupMember.ReadBasic.All` | - | - |
| `GET /groups/{id}/members` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /groups/{id}/members` | Application | `GroupMember.ReadBasic.All` | - | - |
| `POST /groups/{id}/members/$ref` | DelegatedWork | Unknown / not annotated | - | The pin has GET and DELETE membership entries but no POST under either members or members/$ref. Do not treat the group's property-specific nesting annotation as a general membership grant. |
| `POST /groups/{id}/members/$ref` | DelegatedPersonal | Unknown / not annotated | - | The pin has GET and DELETE membership entries but no POST under either members or members/$ref. Do not treat the group's property-specific nesting annotation as a general membership grant. |
| `POST /groups/{id}/members/$ref` | Application | Unknown / not annotated | - | The pin has GET and DELETE membership entries but no POST under either members or members/$ref. Do not treat the group's property-specific nesting annotation as a general membership grant. |
| `DELETE /groups/{id}/members/{id}/$ref` | DelegatedWork | `GroupMember.ReadWrite.All` | - | - |
| `DELETE /groups/{id}/members/{id}/$ref` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /groups/{id}/members/{id}/$ref` | Application | `GroupMember.ReadWrite.All` | - | - |
| `POST /directory/administrativeUnits` | DelegatedWork | `AdministrativeUnit.ReadWrite.All` | - | - |
| `POST /directory/administrativeUnits` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /directory/administrativeUnits` | Application | Unknown / not annotated | - | The pinned DevX entry lists permissions but marks none least privileged for this scheme. |
| `GET /directory/administrativeUnits/{id}` | DelegatedWork | `AdministrativeUnit.Read.All` | - | - |
| `GET /directory/administrativeUnits/{id}` | DelegatedWork | `AdministrativeUnit.ReadWrite.All` | - | - |
| `GET /directory/administrativeUnits/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /directory/administrativeUnits/{id}` | Application | Unknown / not annotated | - | The pinned DevX entry lists permissions but marks none least privileged for this scheme. |
| `DELETE /directory/administrativeUnits/{id}` | DelegatedWork | `AdministrativeUnit.ReadWrite.All` | - | - |
| `DELETE /directory/administrativeUnits/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /directory/administrativeUnits/{id}` | Application | `AdministrativeUnit.ReadWrite.All` | - | - |
| `PATCH /directory/administrativeUnits/{id}` | DelegatedWork | `AdministrativeUnit.ReadWrite.All` | - | - |
| `PATCH /directory/administrativeUnits/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /directory/administrativeUnits/{id}` | Application | Unknown / not annotated | - | The pinned DevX entry lists permissions but marks none least privileged for this scheme. |
| `GET /directory/administrativeUnits/{id}/members` | DelegatedWork | `AdministrativeUnit.Read.All` | - | - |
| `GET /directory/administrativeUnits/{id}/members` | DelegatedWork | `AdministrativeUnit.ReadWrite.All` | - | - |
| `GET /directory/administrativeUnits/{id}/members` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /directory/administrativeUnits/{id}/members` | Application | `AdministrativeUnit.Read.All` | - | - |
| `POST /directory/administrativeUnits/{id}/members/$ref` | DelegatedWork | `AdministrativeUnit.ReadWrite.All` | - | - |
| `POST /directory/administrativeUnits/{id}/members/$ref` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /directory/administrativeUnits/{id}/members/$ref` | Application | Unknown / not annotated | - | The pinned DevX entry lists permissions but marks none least privileged for this scheme. |
| `DELETE /directory/administrativeUnits/{id}/members/{id}/$ref` | DelegatedWork | `AdministrativeUnit.ReadWrite.All` | - | - |
| `DELETE /directory/administrativeUnits/{id}/members/{id}/$ref` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /directory/administrativeUnits/{id}/members/{id}/$ref` | Application | Unknown / not annotated | - | The pinned DevX entry lists permissions but marks none least privileged for this scheme. |
| `POST /directory/administrativeUnits/{id}/scopedRoleMembers` | DelegatedWork | `RoleManagement.ReadWrite.Directory` | - | - |
| `POST /directory/administrativeUnits/{id}/scopedRoleMembers` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /directory/administrativeUnits/{id}/scopedRoleMembers` | Application | `RoleManagement.ReadWrite.Directory` | - | - |
| `GET /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | DelegatedWork | `RoleManagement.Read.Directory` | - | - |
| `GET /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | DelegatedWork | `RoleManagement.ReadWrite.Directory` | - | - |
| `GET /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | Application | `RoleManagement.Read.Directory` | - | - |
| `GET /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | Application | `RoleManagement.ReadWrite.Directory` | - | - |
| `DELETE /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | DelegatedWork | `RoleManagement.ReadWrite.Directory` | - | - |
| `DELETE /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | Application | `RoleManagement.ReadWrite.Directory` | - | - |
| `PATCH /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | DelegatedWork | Unknown / not annotated | - | The provider's generic CRUD primitive can attempt PATCH, but the pin has only create/read/delete for scopedRoleMembers. An inventoried provider capability does not establish Graph support. |
| `PATCH /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | DelegatedPersonal | Unknown / not annotated | - | The provider's generic CRUD primitive can attempt PATCH, but the pin has only create/read/delete for scopedRoleMembers. An inventoried provider capability does not establish Graph support. |
| `PATCH /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | Application | Unknown / not annotated | - | The provider's generic CRUD primitive can attempt PATCH, but the pin has only create/read/delete for scopedRoleMembers. An inventoried provider capability does not establish Graph support. |
| `POST /identityGovernance/entitlementManagement/connectedOrganizations` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/connectedOrganizations` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/connectedOrganizations` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors/$ref` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors/$ref` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors/$ref` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors/{id}/$ref` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors/{id}/$ref` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors/{id}/$ref` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors/$ref` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors/$ref` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors/$ref` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors/{id}/$ref` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors/{id}/$ref` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors/{id}/$ref` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /tenantRelationships/findTenantInformationByDomainName(domainName='{id}')` | DelegatedWork | `CrossTenantInformation.ReadBasic.All` | - | - |
| `GET /tenantRelationships/findTenantInformationByDomainName(domainName='{id}')` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /tenantRelationships/findTenantInformationByDomainName(domainName='{id}')` | Application | `CrossTenantInformation.ReadBasic.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/catalogs` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/catalogs` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/catalogs` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /identityGovernance/entitlementManagement/catalogs/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /identityGovernance/entitlementManagement/catalogs/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/accessPackages` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/accessPackages` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/accessPackages` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/accessPackages/{id}` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/accessPackages/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/accessPackages/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/accessPackages/{id}` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/accessPackages/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/entitlementManagement/accessPackages/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/entitlementManagement/accessPackages/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /identityGovernance/entitlementManagement/accessPackages/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/resourceRequests` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/resourceRequests` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/resourceRequests` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/resources` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/resources` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/resources` | Application | `EntitlementManagement.Read.All` | - | - |
| `POST /identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes` | DelegatedWork | Unknown / not annotated | - | The empty role-scope ID fallback produces a collection URI, not an item deletion. DevX does not annotate collection DELETE; this conservative failure-path candidate establishes neither bulk deletion support nor a permission grant. |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes` | DelegatedPersonal | Unknown / not annotated | - | The empty role-scope ID fallback produces a collection URI, not an item deletion. DevX does not annotate collection DELETE; this conservative failure-path candidate establishes neither bulk deletion support nor a permission grant. |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes` | Application | Unknown / not annotated | - | The empty role-scope ID fallback produces a collection URI, not an item deletion. DevX does not annotate collection DELETE; this conservative failure-path candidate establishes neither bulk deletion support nor a permission grant. |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes/{id}` | DelegatedWork | Unknown / not annotated | - | The pin annotates POST under the legacy accessPackageResourceRoleScopes name, but no DELETE item entry exists under either spelling. Do not infer delete grants from create. |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pin annotates POST under the legacy accessPackageResourceRoleScopes name, but no DELETE item entry exists under either spelling. Do not infer delete grants from create. |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes/{id}` | Application | Unknown / not annotated | - | The pin annotates POST under the legacy accessPackageResourceRoleScopes name, but no DELETE item entry exists under either spelling. Do not infer delete grants from create. |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/resourceRoles` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/resourceRoles` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/resourceRoles` | Application | `EntitlementManagement.Read.All` | - | - |
| `POST /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions/{id}` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions/{id}` | Application | `EntitlementManagement.Read.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions/{id}` | DelegatedWork | Unknown / not annotated | - | The pin has legacy accessPackageCustomWorkflowExtensions GET and POST entries only; neither current nor legacy DELETE is annotated. |
| `DELETE /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pin has legacy accessPackageCustomWorkflowExtensions GET and POST entries only; neither current nor legacy DELETE is annotated. |
| `DELETE /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions/{id}` | Application | Unknown / not annotated | - | The pin has legacy accessPackageCustomWorkflowExtensions GET and POST entries only; neither current nor legacy DELETE is annotated. |
| `PUT /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions/{id}` | DelegatedWork | Unknown / not annotated | - | The verified module uses PUT, but the pin has only legacy GET and POST extension entries. Do not change the HTTP method or infer update grants from create. |
| `PUT /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions/{id}` | DelegatedPersonal | Unknown / not annotated | - | The verified module uses PUT, but the pin has only legacy GET and POST extension entries. Do not change the HTTP method or infer update grants from create. |
| `PUT /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions/{id}` | Application | Unknown / not annotated | - | The verified module uses PUT, but the pin has only legacy GET and POST extension entries. Do not change the HTTP method or infer update grants from create. |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions` | Application | `EntitlementManagement.Read.All` | - | - |
| `POST /identityGovernance/entitlementManagement/assignmentPolicies` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/assignmentPolicies` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/assignmentPolicies` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `PUT /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `PUT /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PUT /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs//customWorkflowExtensions` | DelegatedWork | Unknown / not annotated | - | The guarded catalog-extension read has an empty catalog-ID candidate. Its double-slash URI is not annotated; do not turn it into an item path or borrow item grants. This conservative failure-path candidate establishes no supported endpoint. |
| `GET /identityGovernance/entitlementManagement/catalogs//customWorkflowExtensions` | DelegatedPersonal | Unknown / not annotated | - | The guarded catalog-extension read has an empty catalog-ID candidate. Its double-slash URI is not annotated; do not turn it into an item path or borrow item grants. This conservative failure-path candidate establishes no supported endpoint. |
| `GET /identityGovernance/entitlementManagement/catalogs//customWorkflowExtensions` | Application | Unknown / not annotated | - | The guarded catalog-extension read has an empty catalog-ID candidate. Its double-slash URI is not annotated; do not turn it into an item path or borrow item grants. This conservative failure-path candidate establishes no supported endpoint. |

DevX uses equivalent route spellings for these requests (the inventory retains both):

- `DELETE /directory/administrativeUnits/{id}/members/{id}/$ref` -> `/directory/administrativeunits/{id}/members/{id}`.
- `DELETE /groups/{id}/members/{id}/$ref` -> `/groups/{id}/members/{id}`.
- `DELETE /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors/{id}/$ref` -> `/identitygovernance/entitlementmanagement/connectedorganizations/{id}/externalsponsors/{id}`.
- `DELETE /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors/{id}/$ref` -> `/identitygovernance/entitlementmanagement/connectedorganizations/{id}/internalsponsors/{id}`.
- `GET /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions` -> `/identitygovernance/entitlementmanagement/accesspackagecatalogs/{id}/accesspackagecustomworkflowextensions`.
- `GET /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions/{id}` -> `/identitygovernance/entitlementmanagement/accesspackagecatalogs/{id}/accesspackagecustomworkflowextensions/{id}`.
- `GET /identityGovernance/entitlementManagement/catalogs/{id}/resourceRoles` -> `/identitygovernance/entitlementmanagement/accesspackagecatalogs/{id}/accesspackageresourceroles`.
- `GET /identityGovernance/entitlementManagement/catalogs/{id}/resources` -> `/identitygovernance/entitlementmanagement/accesspackagecatalogs/{id}/accesspackageresources`.
- `GET /tenantRelationships/findTenantInformationByDomainName(domainName='{id}')` -> `/tenantrelationships/findtenantinformationbydomainname(domainname={id})`.
- `POST /directory/administrativeUnits/{id}/members/$ref` -> `/directory/administrativeunits/{id}/members`.
- `POST /identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes` -> `/identitygovernance/entitlementmanagement/accesspackages/{id}/accesspackageresourcerolescopes`.
- `POST /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions` -> `/identitygovernance/entitlementmanagement/accesspackagecatalogs/{id}/accesspackagecustomworkflowextensions`.
- `POST /identityGovernance/entitlementManagement/connectedOrganizations/{id}/externalSponsors/$ref` -> `/identitygovernance/entitlementmanagement/connectedorganizations/{id}/externalsponsors`.
- `POST /identityGovernance/entitlementManagement/connectedOrganizations/{id}/internalSponsors/$ref` -> `/identitygovernance/entitlementmanagement/connectedorganizations/{id}/internalsponsors`.
- `POST /identityGovernance/entitlementManagement/resourceRequests` -> `/identitygovernance/entitlementmanagement/accesspackageresourcerequests`.

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `POST /invitations` | `inviteRedirectUrl`, `invitedUserEmailAddress`, `invitedUserMessageInfo`, `sendInvitationMessage` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /groups` | `description`, `displayName`, `groupTypes`, `isAssignableToRole`, `mailEnabled`, `mailNickname`, `members@odata.bind`, `membershipRule`, `membershipRuleProcessingState`, `owners@odata.bind`, `securityEnabled`, `visibility` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /groups/{id}` | `description`, `displayName`, `groupTypes`, `isAssignableToRole`, `mailEnabled`, `mailNickname`, `members@odata.bind`, `membershipRule`, `membershipRuleProcessingState`, `owners@odata.bind`, `securityEnabled`, `visibility` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /directory/administrativeUnits` | `description`, `displayName`, `isMemberManagementRestricted`, `membershipRule`, `membershipRuleProcessingState`, `membershipType`, `visibility` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /directory/administrativeUnits/{id}` | `description`, `displayName`, `isMemberManagementRestricted`, `membershipRule`, `membershipRuleProcessingState`, `membershipType`, `visibility` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /directory/administrativeUnits/{id}/scopedRoleMembers` | `roleId`, `roleMemberInfo` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /directory/administrativeUnits/{id}/scopedRoleMembers/{id}` | `roleId`, `roleMemberInfo` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /identityGovernance/entitlementManagement/connectedOrganizations` | `description`, `displayName`, `identitySources`, `state` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /identityGovernance/entitlementManagement/connectedOrganizations/{id}` | `description`, `displayName`, `identitySources`, `state` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `GET /identityGovernance/entitlementManagement/connectedOrganizations` | `displayName`, `id`, `identitySources`, `state` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /identityGovernance/entitlementManagement/catalogs` | `description`, `displayName`, `isExternallyVisible`, `state` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /identityGovernance/entitlementManagement/catalogs/{id}` | `description`, `displayName`, `isExternallyVisible`, `state` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /identityGovernance/entitlementManagement/accessPackages` | `catalog`, `description`, `displayName`, `isHidden` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /identityGovernance/entitlementManagement/accessPackages/{id}` | `catalog`, `description`, `displayName`, `isHidden` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /identityGovernance/entitlementManagement/resourceRequests` | `catalog`, `requestType`, `resource` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes` | `role`, `scope` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions` | `@odata.type`, `authenticationConfiguration`, `callbackConfiguration`, `description`, `displayName`, `endpointConfiguration` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PUT /identityGovernance/entitlementManagement/catalogs/{id}/customWorkflowExtensions/{id}` | `@odata.type`, `authenticationConfiguration`, `callbackConfiguration`, `description`, `displayName`, `endpointConfiguration` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /identityGovernance/entitlementManagement/assignmentPolicies` | `accessPackage`, `allowedTargetScope`, `customExtensionStageSettings`, `description`, `displayName`, `expiration`, `questions`, `requestApprovalSettings`, `requestorSettings`, `reviewSettings`, `specificAllowedTargets` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PUT /identityGovernance/entitlementManagement/assignmentPolicies/{id}` | `accessPackage`, `allowedTargetScope`, `customExtensionStageSettings`, `description`, `displayName`, `expiration`, `questions`, `requestApprovalSettings`, `requestorSettings`, `reviewSettings`, `specificAllowedTargets` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
