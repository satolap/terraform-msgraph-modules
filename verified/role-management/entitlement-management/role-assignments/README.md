# role-management/entitlement-management/role-assignments

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Potential personal-data inputs: `principal_id`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **optional**. Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Assigns an entitlement management role to a user, group or service principal, via the
`microsoft/msgraph` Terraform provider. The folder mirrors the Graph collection it manages:
`roleManagement/entitlementManagement/roleAssignments`
([Create unifiedRoleAssignment](https://learn.microsoft.com/en-us/graph/api/rbacapplication-post-roleassignments?view=graph-rest-1.0),
example 4 for a catalog scope).

Entitlement management has its own role-based access control
([Delegate access governance](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-delegate#entitlement-management-roles)):

- **Catalog roles**, defined for each catalog: `catalog_owner`, `catalog_reader`,
  `access_package_manager` and `access_package_assignment_manager`. The assignment names the
  catalog (`appScopeId = /AccessPackageCatalog/<catalog-id>`).
- **Tenant-wide roles**, which apply across all catalogs: `catalog_creator`. The assignment
  uses `directoryScopeId = /`.

These roles authorize actions within entitlement management only: the delegation page
describes them as permissions for administering entitlement management itself. Microsoft Entra
directory roles use a different Graph provider (`roleManagement/directory`) and are not
assigned by this module.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
# A group owns a catalog created by the verified catalogs module
module "engineering_catalog_owners" {
  source  = "satolap/modules/msgraph//verified/role-management/entitlement-management/role-assignments"
  version = "<version>"

  principal_id = module.engineering_owners_group.id
  role         = "catalog_owner"
  catalog_id   = module.engineering_catalog.id
}

# A user manages the access packages of the same catalog
module "engineering_access_package_manager" {
  source  = "satolap/modules/msgraph//verified/role-management/entitlement-management/role-assignments"
  version = "<version>"

  principal_id = module.platform_lead.id
  role         = "access_package_manager"
  catalog_id   = module.engineering_catalog.id
}

# A tenant-wide role: the principal can create catalogs
module "catalog_creators" {
  source  = "satolap/modules/msgraph//verified/role-management/entitlement-management/role-assignments"
  version = "<version>"

  principal_id = module.catalog_creators_group.id
  role         = "catalog_creator"
}

# A role without a name here, by role definition ID (see below)
module "connected_organization_admin" {
  source  = "satolap/modules/msgraph//verified/role-management/entitlement-management/role-assignments"
  version = "<version>"

  principal_id       = module.identity_team.id
  role_definition_id = var.connected_organization_administrator_role_definition_id
}
```

## Roles and scope

| `role` | Role definition ID | Scope | `catalog_id` |
| --- | --- | --- | --- |
| `catalog_creator` | `ba92d953-d8e0-4e39-a797-0cbedb0a89e8` | tenant (`directoryScopeId = /`) | refused |
| `catalog_owner` | `ae79f266-94d4-4dab-b730-feca7e132178` | catalog (`appScopeId`) | required |
| `catalog_reader` | `44272f93-9762-48e8-af59-1b5351b1d6b3` | catalog | required |
| `access_package_manager` | `7f480852-ebdc-47d4-87de-0d8498384a83` | catalog | required |
| `access_package_assignment_manager` | `e2182095-804a-4656-ae11-64734e9b7ae5` | catalog | required |

The IDs are those on the Learn page above. Set exactly one of `role` and
`role_definition_id`; the module refuses both or neither. With `role_definition_id`, the scope
is the catalog when `catalog_id` is set and the tenant when it is null.

**Connected Organization Administrator** (tenant-wide) has no name here. The ID that the Learn
page prints for it, `e65cf63f-9cc2-4b48-8871-cb667e9d90f`, has 35 characters instead of the 36
of a GUID, so it is not copied into this module. Look up its role definition ID in the tenant
(`GET /roleManagement/entitlementManagement/roleDefinitions`), pass it as `role_definition_id`
and leave `catalog_id` null. This route is not verified live.

## How create, change and destroy work

Learn documents create, [get](https://learn.microsoft.com/en-us/graph/api/unifiedroleassignment-get?view=graph-rest-1.0)
and [delete](https://learn.microsoft.com/en-us/graph/api/unifiedroleassignment-delete?view=graph-rest-1.0)
of a role assignment for the entitlement management provider (`GET` and `DELETE` on
`roleManagement/entitlementManagement/roleAssignments/{id}`), so the module is an ordinary
CRUD `msgraph_resource`: destroy deletes the assignment, with no Azure CLI hook.

A role assignment cannot be updated (Learn lists no update). Any change to `principal_id`,
the role, `catalog_id` or `api_version` therefore replaces the assignment. The replacement
deletes the old assignment first and creates the new one afterwards: it deliberately does not
use `create_before_destroy`, because an assignment of the same principal, role and scope is
refused as a duplicate. Between the delete and the create the principal briefly has no role.
The `id` output changes with each replacement.

Learn's create page says only "identifier of the principal" and names no principal types. The
[delegation page](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-delegate)
says an administrator or catalog owner can add identities, groups of identities or service
principals to the catalog roles. Not verified live.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.3.0 |

The configuring identity/application needs the `EntitlementManagement.ReadWrite.All`
Microsoft Graph permission (delegated or application) to create and delete an assignment;
reading one also accepts `EntitlementManagement.Read.All`
([create](https://learn.microsoft.com/en-us/graph/api/rbacapplication-post-roleassignments?view=graph-rest-1.0#permissions),
[get](https://learn.microsoft.com/en-us/graph/api/unifiedroleassignment-get?view=graph-rest-1.0#permissions)).

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |

Notes:

- Entitlement management roles authorize only within entitlement management. Microsoft Learn documents the roles and the license requirement of entitlement management but does not state whether a principal that holds only a catalog role needs its own license; EM-CORE is applied to the entitlement management deployment, so confirm coverage for the people who hold roles. See [Delegate access governance to catalog owners](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-delegate).

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| principal_id | Object ID (GUID) of the user, group or service principal that receives the role | `string` | n/a | yes | replaces `msgraph_resource.assignment` when its effect on `local.principal_id` changes |
| role | Role by name: `catalog_creator`, `catalog_owner`, `catalog_reader`, `access_package_manager` or `access_package_assignment_manager`; set this or `role_definition_id` | `string` | `null` | no | replaces `msgraph_resource.assignment` when its effect on `local.role_definition_id`, `local.app_scope_id`, `local.directory_scope_id` changes |
| role_definition_id | Role definition ID (GUID) of a role without a name here; set this or `role` | `string` | `null` | no | replaces `msgraph_resource.assignment` when its effect on `local.role_definition_id` changes |
| catalog_id | Catalog ID (GUID): required for catalog roles, refused for `catalog_creator`; with `role_definition_id`, set means catalog scope and null tenant scope | `string` | `null` | no | replaces `msgraph_resource.assignment` when its effect on `local.app_scope_id`, `local.directory_scope_id` changes |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no | replaces `msgraph_resource.assignment` |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The ID of the role assignment; changes whenever an input changes | yes |
| role_definition_id | The role definition ID assigned | yes |
| app_scope_id | `/AccessPackageCatalog/{catalog-id}` for a catalog role; null for a tenant-wide role | yes |
| directory_scope_id | `/` for a tenant-wide role; null for a catalog role | yes |
| principal_id | The principal's object ID, in lower case | yes |

## Tests

`terraform test` runs offline unit tests that mock the `msgraph` provider.
`tests/role_assignment.tftest.hcl` asserts the request URL, each named role's role definition
ID and scope property, a raw role definition ID with and without a catalog, the replace
trigger, and every refusal (neither or both of `role` and `role_definition_id`, a catalog role
without a catalog, `catalog_creator` with a catalog, and malformed or unknown inputs). Tests
require Terraform 1.11 or later. Nothing here is verified against a live tenant.

See [live test setup and lifecycle limits](../../../../../docs/test-tenant-setup.md).

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `principal_id`: replaces `msgraph_resource.assignment` when its effect on `local.principal_id` changes.
- `role`: replaces `msgraph_resource.assignment` when its effect on `local.role_definition_id`, `local.app_scope_id`, `local.directory_scope_id` changes.
- `role_definition_id`: replaces `msgraph_resource.assignment` when its effect on `local.role_definition_id` changes.
- `catalog_id`: replaces `msgraph_resource.assignment` when its effect on `local.app_scope_id`, `local.directory_scope_id` changes.
- `api_version`: replaces `msgraph_resource.assignment`.
<!-- drift:end -->
