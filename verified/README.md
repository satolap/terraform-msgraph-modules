# Verified Microsoft Graph Terraform modules

These modules provide task-focused Terraform inputs and outputs for Microsoft
Entra users, groups and their members, applications, service principals,
administrative units, entitlement management, Lifecycle Workflows (with custom task extensions), Terms of Use agreements, Privileged Identity Management role assignments and Conditional Access, a naming module
that renders object names from a naming convention, and composite modules that combine
them for a task.
Start with the module README for configuration, permissions, license requirements
and lifecycle limitations.

## Sensitive values

Preserve sensitivity when composing these modules and exposing derived outputs;
`nonsensitive(...)` explicitly declassifies a value. Sensitivity redacts normal
Terraform presentation, but values still exist in saved plans and state. Restrict
access to those artifacts and the state backend.

Removing an input's sensitivity can expose values in normal CLI output. Adding
it can require a calling root's output to be declared sensitive too. Review both
directions during upgrades rather than removing sensitivity to silence an error.

## Input and output declarations

Each module folder has a `declaration.json`, and its README tables show the same
information:

- **On change** (Inputs table): what changing an input does to the module's Graph
  objects. It says `in place` only when the input reaches nothing but an in-place update
  of an object's body; anything the declaration cannot prove safe is stated instead:
  - `replaces` deletes and recreates the named object, sometimes only when a stated
    value changes;
  - `adds or removes relationships` and `creates or deletes instances` change which
    objects exist;
  - `submits again` posts a one-shot request, such as a role assignment, again;
  - `kept from creation` means the module keeps the created value and refuses or
    ignores a change; the module notes say how to apply one deliberately;
  - `see the module notes` marks an effect, such as a destroy-time cleanup or a
    create-time binding, that the notes describe;
  - `not replaced or moved` marks an input that builds the request URL of an object;
  - `no object change` marks an input that only validates, times or documents, such as
    a name pattern.

  A nested object attribute behaves like the input that holds it.
- **Known in plan after an update** (Outputs table): whether a plan still knows the
  value while it updates the object in place. It says `yes` only when proven: an
  input, the object ID or URL, or a value kept from creation. A value read from the
  Graph response, an action or a data source is known only after apply in that plan, so
  do not feed it into something that is replaced when its input becomes unknown.

`declaration.json` also records each output's source (the service, an input, or a
derived value) and whether it is sensitive.

An input that reaches a top-level key of a Graph resource body unchanged has a
`graph_property` in the declaration. When the pinned Graph metadata proves the value
must be unique (an `AlternateKeys` key, or a description that states the rule), the
declaration carries `unique` with its scope, basis and evidence, and the module README
lists it under "Unique values". These claims are the ones the generator infers for the generated modules
from the same pinned Graph metadata commit; `uniqueness-evidence.json` stores them for the
mapped properties, with that commit, so the check runs offline. The check fails when the
commit differs from the one the generated catalog pins. An input with no such mapping or no such evidence claims nothing.

## Shared Graph rules

Verified and generated modules follow one set of reviewed Graph rules (the contracts).
Per endpoint, the contracts list the properties Graph needs on create, the properties it
sets only at creation, and the combinations it refuses. Generated modules are built from
the contracts, and a conformance check holds each verified module to the same rules.
Verified code is never derived from generated code: a new rule fails the check until
someone updates and reviews the verified module.

For each module that posts to a collection named in the contracts, the check requires:

- every property Graph needs on create to be sent;
- every create-only property to replace the object on change, or to keep its created value;
- every refused combination to be refused at plan time. Each one becomes runs in the
  generated `tests/contract_conformance.tftest.hcl`: compliant plans that must pass, each
  violation, which must fail, and the same violating value without the rule's condition,
  which must pass. That last run proves the refusal comes from this rule, not from another
  check that refuses the value anyway. A rule on properties the module does not expose is
  skipped.

A verified module that replaces an object for a reason the contracts do not state either
gets that rule added to the contracts, so generated modules learn it too, or is recorded
as a reviewed exception with its reason. So is any rule a module deliberately does not
meet.

## Folder hierarchy

The tree shows every module folder. Each module has its own README, Terraform
configuration and tests; test and support files are omitted here for readability.
Intermediate folders group related modules and are not standalone modules.

```text
verified/
├── README.md
├── applications/
│   ├── federatedIdentityCredentials/
│   └── passwordCredentials/
├── compositions/
│   └── connected-organization-access/
├── directory/
│   └── administrative-units/
├── groups/
│   └── members/
├── identity/
│   └── conditional-access/
│       ├── named-locations/
│       │   ├── countries/
│       │   └── ip-ranges/
│       └── policies/
├── identity-governance/
│   └── entitlement-management/
│       ├── access-packages/
│       │   └── resource-role-scopes/
│       ├── assignment-policies/
│       ├── catalogs/
│       │   ├── custom-extensions/
│       │   └── resources/
│       └── connected-organizations/
├── identityGovernance/
│   ├── accessReviews/
│   │   └── definitions/
│   ├── entitlementManagement/
│   │   ├── assignments/
│   │   └── settings/
│   ├── lifecycleWorkflows/
│   │   └── workflows/
│   └── privilegedAccess/
│       └── group/
│           ├── assignmentScheduleRequests/
│           └── eligibilityScheduleRequests/
├── naming/
├── oauth2PermissionGrants/
├── policies/
│   └── authenticationStrengthPolicies/
├── role-management/
│   ├── directory/
│   │   └── role-schedules/
│   └── entitlement-management/
│       └── role-assignments/
├── roleManagement/
│   └── directory/
│       ├── roleAssignments/
│       └── roleDefinitions/
├── security-baseline/
│   ├── admin-consent-workflow/
│   ├── authentication-methods/
│   ├── authorization-policy/
│   ├── conditional-access-p1/
│   ├── licence-guard/
│   └── emergency-access-guard/
│       └── verify/
├── servicePrincipals/
│   ├── appRoleAssignedTo/
│   └── passwordCredentials/
├── service-principals/
└── users/
```

`groups/`, `access-packages/` and `catalogs/` are modules themselves; their child
folders provide separate relationship modules. `compositions/`, `directory/`,
`identity/`, `conditional-access/`, `named-locations/` and `role-management/` only group
modules. A Terraform module source points to the specific module folder, rather than this
index or a grouping folder. A module under `compositions/` calls other verified modules with
relative sources, so it needs the whole `verified/` tree, which the registry package
provides.

## Browse modules

| Module | Purpose |
| --- | --- |
| [Applications](applications/README.md) | Application registrations and application roles |
| [Application federated identity credentials](applications/federatedIdentityCredentials/README.md) | One v1.0 workload trust with a literal subject; preserves sibling credentials |
| [Application passwords](applications/passwordCredentials/README.md) | One-time passwords and rotation; explicit acknowledgement of clear-text plan/show exposure required |
| [Groups](groups/README.md) | Microsoft Entra groups |
| [Group members](groups/members/README.md) | Authoritative direct members of an existing group |
| [Service principals](service-principals/README.md) | Tenant application identities linked by application ID |
| [Service principal passwords](servicePrincipals/passwordCredentials/README.md) | One-time passwords and keyed rotation; explicit acknowledgement of clear-text plan/show exposure required |
| [App role assignments](servicePrincipals/appRoleAssignedTo/README.md) | One resource application role granted to a user, group or client service principal; exact role-value lookup and identity-checked owned cleanup |
| [Delegated permission grants](oauth2PermissionGrants/README.md) | Explicit user or tenant-wide delegated consent; scope-only updates and identity-checked owned cleanup |
| [Users](users/README.md) | Microsoft Entra user accounts |
| [Administrative units](directory/administrative-units/README.md) | Administrative units, restricted management or dynamic, and their members |
| [Catalogs](identity-governance/entitlement-management/catalogs/README.md) | Entitlement management resource catalogs |
| [Catalog resources](identity-governance/entitlement-management/catalogs/resources/README.md) | Resource associations within a catalog; DirectoryRole preview onboarding only |
| [Catalog custom extensions](identity-governance/entitlement-management/catalogs/custom-extensions/README.md) | Logic App custom workflow extensions, launch and continue or launch and wait, that assignment policies call |
| [Access packages](identity-governance/entitlement-management/access-packages/README.md) | Packages of access to catalog resources |
| [Resource role scopes](identity-governance/entitlement-management/access-packages/resource-role-scopes/README.md) | Resource roles and scopes attached to an access package |
| [Assignment policies](identity-governance/entitlement-management/assignment-policies/README.md) | Access-package request and assignment policies, with approval stages, requestor questions and access reviews |
| [Access-package assignments](identityGovernance/entitlementManagement/assignments/README.md) | Grants one user an access package with adminAdd, separates pending, denied and delivered requests from the resolved assignment, and revokes only that assignment |
| [Connected organizations](identity-governance/entitlement-management/connected-organizations/README.md) | External tenants and domains whose users can request access packages, and their sponsors |
| [Group access reviews](identityGovernance/accessReviews/definitions/README.md) | One access review definition of an owned static group's members, with explicit reviewers, an explicit schedule and every automatic action off |
| [Lifecycle workflow custom task extensions](identityGovernance/lifecycleWorkflows/customTaskExtensions/README.md) | Logic App-backed extensions that the "Run a custom task extension" task calls; takes the Logic App as an input and invokes nothing |
| [Lifecycle workflows](identityGovernance/lifecycleWorkflows/workflows/README.md) | Joiner, mover and leaver workflows and their built-in tasks, created disabled, with activation and dangerous-task guards |
| [Terms of Use agreements](identityGovernance/termsOfUse/agreements/README.md) | One Terms of Use agreement and its localized PDFs, delegated access only; fixed files, a refused change guard and no enforcement, acceptance or policy |
| [Role schedules](role-management/directory/role-schedules/README.md) | PIM eligible and active assignments of Microsoft Entra roles, permanent or time-bound |
| [Entitlement management role assignments](role-management/entitlement-management/role-assignments/README.md) | Catalog roles and tenant-wide entitlement management roles for a user, group or service principal |
| [Entitlement management settings](identityGovernance/entitlementManagement/settings/README.md) | Tenant-wide external user lifecycle settings, updating the existing singleton with a tested restore and no delete |
| [Direct directory role assignments](roleManagement/directory/roleAssignments/README.md) | Permanent active built-in/custom Entra role assignments; tenant, AU and application scopes; separate from PIM |
| [Custom directory role definitions](roleManagement/directory/roleDefinitions/README.md) | New custom Microsoft Entra directory roles; makes no assignment |
| [PIM for Groups eligibility requests](identityGovernance/privilegedAccess/group/eligibilityScheduleRequests/README.md) | One bounded administrative eligibility request for group membership or ownership, with schedule and instance correlation; no activation or removal |
| [PIM for Groups active assignment requests](identityGovernance/privilegedAccess/group/assignmentScheduleRequests/README.md) | One bounded administrative active membership or ownership request, with schedule and instance correlation; no revocation or policy change |
| [Authentication strength policies](policies/authenticationStrengthPolicies/README.md) | Custom authentication strengths and combination configurations (`/policies/authenticationStrengthPolicies`) |
| [Conditional Access policies](identity/conditional-access/policies/README.md) | Conditional Access policies, report-only by default, with mandatory break-glass exclusions |
| [IP named locations](identity/conditional-access/named-locations/ip-ranges/README.md) | IPv4 and IPv6 named locations for Conditional Access |
| [Country named locations](identity/conditional-access/named-locations/countries/README.md) | Country and region named locations for Conditional Access |
| [Authorization policy](security-baseline/authorization-policy/README.md) | Tenant authorization policy baseline: one user consent policy, guest settings and optional app and tenant creation, with a tested restore |
| [Authentication methods](security-baseline/authentication-methods/README.md) | Authentication methods policy baseline: Authenticator, passkeys, registration campaign and optional SMS and voice restriction, updating existing singletons |
| [Conditional Access baseline (P1)](security-baseline/conditional-access-p1/README.md) | Four Conditional Access policies that replace security defaults, report-only by default, with mandatory break-glass exclusions and a decommission that restores security defaults |
| [Emergency access guard](security-baseline/emergency-access-guard/README.md) | Read-only existing-account and static-group safety checks, with gate-bound exclusions |
| [Emergency access verification](security-baseline/emergency-access-guard/verify/README.md) | Read back configured policy exclusions; no effective sign-in claim |
| [Admin consent workflow](security-baseline/admin-consent-workflow/README.md) | The admin consent request policy singleton: enable the workflow, name reviewers, with a snapshot and restore |
| [Licence guard](security-baseline/licence-guard/README.md) | Explicit tier and tenant subscription-capacity checks |
| [Naming](naming/README.md) | Names rendered from a naming convention of templates and tokens, checked against the limits of each object, with a pattern per name for the modules' `name_pattern`; makes no Graph request |
| [Connected organization access](compositions/connected-organization-access/README.md) | Composite: a connected organization with its catalog, access package, sponsor groups, administrative unit, policies, custom extensions and sponsor invitations |

## Using a verified module

Published verified modules use `satolap/modules/msgraph//verified/<module-path>` with a
version from [GraphModules Releases](https://github.com/satolap/terraform-msgraph-modules/releases),
where `<module-path>` is the folder path under `verified/` shown in the tree above;
generated modules use `satolap/modules/msgraph//<api-version>/<graph-route>`.
Modules inherit the provider configuration from the calling root. Use Azure CLI
authentication locally or workload identity federation in CI, following the provider
documentation. Relation cleanup additionally requires Bash, Azure CLI, and
curl; see the catalog-resource and role-scope READMEs before using them.

## Licensing and prerequisites

Every verified README carries a **Licensing and prerequisites** section rendered from one
feature-level registry. It lists the Microsoft feature rule that applies always, the rules
that specific inputs switch on, who needs coverage, the review confidence and official
sources. A successful API call never counts as license evidence.

## Naming conventions

Every verified module with a `display_name` input also takes an optional `name_pattern`, a
regular expression (RE2 syntax, not anchored unless it says so). When it is set and
`display_name` does not match, the plan fails; when it is null, the default, any name is
accepted. The groups and users modules also take `mail_nickname_pattern` for
`mail_nickname`. The service principal module has no such input, because Microsoft Graph
takes a service principal's display name from its application. The
[naming module](naming/README.md) derives these patterns from a convention in its `patterns`
output, and its `kinds` input checks each name against the limits of the module that takes
it. See its README for a convention with placeholder values and for pipeline policy-as-code,
which also catches configurations that bypass these modules.

For the broader generated endpoint catalogs, browse
[v1.0](https://github.com/satolap/terraform-msgraph-modules/blob/main/v1.0/README.md)
or [beta](https://github.com/satolap/terraform-msgraph-modules/blob/main/beta/README.md).
Module availability and offline tests do not by themselves establish live lifecycle
support; consult each module's guidance.
