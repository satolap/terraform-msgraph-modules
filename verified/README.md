# Verified Microsoft Graph Terraform modules

These modules provide task-focused Terraform inputs and outputs for Microsoft
Entra users, groups and their members, applications, service principals,
administrative units, entitlement management, Privileged Identity Management role assignments and Conditional Access, and a naming module
that renders object names from a naming convention.
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

## Folder hierarchy

The tree shows every module folder. Each module has its own README, Terraform
configuration and tests; test and support files are omitted here for readability.
Intermediate folders group related modules and are not standalone modules.

```text
verified/
├── README.md
├── applications/
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
├── naming/
├── role-management/
│   ├── directory/
│   │   └── role-schedules/
│   └── entitlement-management/
│       └── role-assignments/
├── roleManagement/
│   └── directory/
│       └── roleDefinitions/
├── security-baseline/
│   ├── admin-consent-workflow/
│   ├── authentication-methods/
│   ├── authorization-policy/
│   ├── conditional-access-p1/
│   ├── licence-guard/
│   └── emergency-access-guard/
│       └── verify/
├── service-principals/
└── users/
```

`groups/`, `access-packages/` and `catalogs/` are modules themselves; their child
folders provide separate relationship modules. `directory/`, `identity/`,
`conditional-access/`, `named-locations/` and `role-management/` only group modules. A Terraform module
source points to the
specific module folder, rather than this index or a grouping folder.

## Browse modules

| Module | Purpose |
| --- | --- |
| [Applications](applications/README.md) | Application registrations and application roles |
| [Groups](groups/README.md) | Microsoft Entra groups |
| [Group members](groups/members/README.md) | Authoritative direct members of an existing group |
| [Service principals](service-principals/README.md) | Tenant application identities linked by application ID |
| [Users](users/README.md) | Microsoft Entra user accounts |
| [Administrative units](directory/administrative-units/README.md) | Administrative units, restricted management or dynamic, and their members |
| [Catalogs](identity-governance/entitlement-management/catalogs/README.md) | Entitlement management resource catalogs |
| [Catalog resources](identity-governance/entitlement-management/catalogs/resources/README.md) | Resource associations within a catalog |
| [Catalog custom extensions](identity-governance/entitlement-management/catalogs/custom-extensions/README.md) | Logic App custom workflow extensions that assignment policies call |
| [Access packages](identity-governance/entitlement-management/access-packages/README.md) | Packages of access to catalog resources |
| [Resource role scopes](identity-governance/entitlement-management/access-packages/resource-role-scopes/README.md) | Resource roles and scopes attached to an access package |
| [Assignment policies](identity-governance/entitlement-management/assignment-policies/README.md) | Access-package request and assignment policies, with approval stages, requestor questions and access reviews |
| [Connected organizations](identity-governance/entitlement-management/connected-organizations/README.md) | External tenants and domains whose users can request access packages, and their sponsors |
| [Role schedules](role-management/directory/role-schedules/README.md) | PIM eligible and active assignments of Microsoft Entra roles, permanent or time-bound |
| [Entitlement management role assignments](role-management/entitlement-management/role-assignments/README.md) | Catalog roles and tenant-wide entitlement management roles for a user, group or service principal |
| [Custom directory role definitions](roleManagement/directory/roleDefinitions/README.md) | New custom Microsoft Entra directory roles; makes no assignment |
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
| [Naming](naming/README.md) | Names rendered from a naming convention of templates and tokens; makes no Graph request |

## Naming conventions

Every verified module with a `display_name` input also takes an optional `name_pattern`, a
regular expression (RE2 syntax, not anchored unless it says so). When it is set and
`display_name` does not match, the plan fails; when it is null, the default, any name is
accepted. The groups and users modules also take `mail_nickname_pattern` for
`mail_nickname`. The service principal module has no such input, because Microsoft Graph
takes a service principal's display name from its application. Pass the same pattern that
the [naming module](naming/README.md) uses, and see its README for a convention with
placeholder values and for pipeline policy-as-code, which also catches configurations that
bypass these modules.

For the broader generated endpoint catalogs, browse [v1.0](../generated/v1.0/README.md)
or [beta](../generated/beta/README.md). Module availability and offline tests do not
by themselves establish live lifecycle support; consult each module's guidance.
