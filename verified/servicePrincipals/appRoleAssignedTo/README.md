# App role assignments

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Potential personal-data inputs: `principalId`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: not yet run](https://img.shields.io/badge/live-not%20yet%20run-lightgrey)
<!-- live-status:end -->

Create one app role assignment for a user, group or client service principal at
Microsoft Graph v1.0 `servicePrincipals/{resourceId}/appRoleAssignedTo`. This is
the resource service principal's relationship, with Graph's original casing.
For a client service principal, this grants an **application permission**. Review
the exact recipient and role before applying; this module can grant powerful
API access. It creates no application, principal, app role or delegated consent
grant. Delegated `oauth2PermissionGrants` are outside this module's scope.

For a published release containing this module, replace `<version>` with the
release version. The [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry)
explains registry installation. Availability in this source tree does not mean
that an existing release already includes the module.

```hcl
module "reader_assignment" {
  source  = "satolap/modules/msgraph//verified/servicePrincipals/appRoleAssignedTo"
  version = "<version>"

  resourceId  = var.resource_service_principal_object_id
  principalId = var.recipient_object_id
  appRoleId   = var.reader_app_role_id
}
```

## Role selection

Supply exactly one of `appRoleId` and `appRoleValue`. `resourceId` is the
resource **service principal object ID**, not the application's client ID or
application object ID. `principalId` is a user, group or client service principal
object ID. `appRoleId` is the role GUID defined by that resource. The output `id`
is the assignment's opaque identifier, a different kind of ID.

To resolve a role by value, replace the example's `appRoleId` with
`appRoleValue = "Reader"`. A read-only GET of the resource service principal
selects `id,appRoles`. Matching is exact and case-sensitive and must find exactly
one role, which must be enabled and have a valid GUID. Zero matches, duplicates
(even if one is disabled), a different returned resource or incomplete evidence
fail the plan. No display-name lookup, assignment enumeration, role creation,
service principal update or automatic adoption takes place. Graph checks the
recipient's existence and the role's `allowedMemberTypes`; groups use `User`
roles, while client service principals use `Application` roles. The module does
not infer principal type from a GUID or pre-read the recipient.

For an application that declares no roles, explicitly set
`appRoleId = "00000000-0000-0000-0000-000000000000"`. This assigns access without
a specific app role. The module reads the resource service principal even for
this explicit ID and requires matching resource identity and an explicitly
returned empty `appRoles` collection. Declared roles, missing/null collections
and incomplete evidence fail closed. A value lookup cannot bypass this check.
The zero GUID is never a default or a fallback for a failed lookup. Explicit
nonzero role IDs do not read the resource's role definitions.

The value lookup is read again on normal plans. An upstream rename, disablement
or duplicate value fails the selection precondition; deleting the resource
service principal can make data-source refresh fail, including before destroy.
To remove the owned assignment, keep the module configured and use
`terraform destroy -refresh=false` with its previously captured ownership state.
This skips the failing refresh; cleanup still uses the saved ID with provider
credentials. If the resource SP was deleted, deletion of its assignment might
succeed or error; the provider's absent-item behavior requires live acceptance.
No replacement assignment is searched for or removed.

For a surviving resource, another recovery option is to switch from
`appRoleValue` to the previously captured explicit nonzero `appRoleId` and leave
`appRoleValue` null. This avoids the role-definition lookup, but changes the
selector and therefore plans replacement; Graph may refuse recreating an
assignment to a disabled/removed role. Inspect the plan and choose destroy when
access should be removed. Neither recovery path adopts a replacement role or
changes the stored cleanup identity. If no ownership record was captured,
independently reconcile the POST result before recovery.

## Lifecycle and ownership

Only **new assignments created by this module** are supported. Do not import or
adopt an existing assignment, share ownership with another Terraform resource,
or use this module to manage an entire assignment collection. A duplicate
create is not adopted; reconcile it before applying. No migration from a
generated module or another path is supplied.

Graph documents create, item GET and item DELETE, with no assignment PATCH. The
module uses a **one-shot** `msgraph_resource_action` POST plus a separate pinned
ownership record and guarded cleanup. The action does not detect out-of-band
deletion or reconcile drift on refresh: independently read assignments when
verifying access. It is not an authoritative assignment collection.
`ignore_changes = all` prevents an in-place write, and `terraform_data.immutable`
forces destroy-first replacement when `resourceId`, `principalId`, `appRoleId`,
the `appRoleValue` selector or the resolved role GUID changes. All GUIDs are
lowercased in bodies, paths and triggers. A GUID case-only change keeps the
assignment; role values keep their case. Replacement interrupts access and
creates a new assignment ID. No create-before-destroy is enabled. The immutable helper
resource makes no Graph request; its first creation alone does not replace an
assignment. Recovery that removes the helper from state requires an unchanged
apply before relying on its replacement behavior.

A selector-only change also replaces the assignment, even if the GUID stays
the same: switching between a value and its explicit ID, or updating a renamed
value, deletes the old assignment before the replacement POST. Expect a brief
access gap during that delete/create window; GUID case-only changes cause no gap.

A response postcondition requires a nonempty URL-safe opaque assignment ID and
the configured identity triple in Graph's response. It runs after the provider operation, not as
an import or pre-write barrier. Missing or different identity evidence fails.

`data.msgraph_resource.verify` performs an independent GET of the exact created
item and requires matching immutable identity before `terraform_data.owned` is
captured. Missing, null or different identity blocks deletion registration.
`msgraph_resource_action.remove` registers `when = "destroy"`, `method = "DELETE"`
without sending a request on create/update. It stores the exact owned item URL
and uses the same provider credentials as creation. The ownership dependency
orders deletion of the old ID before a replacement POST; labels and collection
searches are never used to select a delete target.

Accepted limitation: there is **no destroy-time identity re-check**. Destroy uses
the saved URL proven by the independent GET at registration; it does not confirm absence
after DELETE. Create-time verification is the ownership control. Out-of-band
changes after verification are outside this contract. Coordinate with other
writers, protect state, and independently verify exact-ID absence after destroy.
An already absent item might succeed or error according to provider/Graph
behavior; this remains a live acceptance probe. `-refresh=false` skips failing
reads but still sends DELETE to the saved ID with provider credentials.

### Failed verification after create

The verification GET retries HTTP 404 / NotFound / Request_ResourceNotFound
errors for at most two minutes, using the provider's supported retry object and
read timeout. This is a bounded replication workaround, not live replication
proof. It is configured only on GET, never on POST or DELETE.

If apply fails after create because verification cannot yet read the item,
**re-run apply with unchanged inputs; never use destroy as recovery**. Keep the
saved successful POST action: retrying apply reads its saved ID and registers
cleanup without re-sending POST. Until `msgraph_resource_action.remove` exists,
destroy silently forgets the POST action and can leave the assignment in the tenant
with nothing in state to delete it. Do not taint, force replacement or edit state to retry verification.
If POST itself was ambiguous or its response identity failed, stop for the
manual exact-ID recovery below before any retry; do not blindly replay POST.

### Upgrade from the earlier cleanup provisioner

Back up state privately. Before any other change, run an **unchanged apply** and
verify that `msgraph_resource_action.remove` is registered with the existing
owned item's URL and that the plan does not replace the POST or ownership record.
**Destroy or identity replacement before that unchanged apply leaves the old
object in the tenant with nothing in state to delete it.** In particular, merely
upgrading configuration does not register cleanup. A first apply that also
changes identity can discard the old ID before any DELETE action exists.

Terraform configuration cannot test whether `remove` already existed in prior
state rather than being created in this plan without a dependency cycle. This
upgrade sequencing requirement is documented, not enforced by a state-presence
check. Failed verification must be reconciled, never bypassed.

### Exact-ID manual recovery and absent-item cleanup

For a created item whose removal was not registered, recover the exact created
ID from the saved POST response in the provider's tenant. Independently GET the
exact item route and compare its immutable identity with the intended request.
Only matching ownership evidence permits manual DELETE of that same route;
then confirm exact-ID GET 404 before retrying creation. Missing IDs, denied
reads or different identity require independent owner investigation, never a
label, principal or collection search for a substitute item.

```http
GET https://graph.microsoft.com/v1.0/servicePrincipals/{created-resource-id}/appRoleAssignedTo/{created-assignment-id}
DELETE https://graph.microsoft.com/v1.0/servicePrincipals/{created-resource-id}/appRoleAssignedTo/{created-assignment-id}
```

Compare `id`, `resourceId`, `principalId` and `appRoleId` with the captured POST
and intended request. Preserve the opaque assignment ID exactly; GUID case
does not change identity. No existing assignment may be imported or adopted.

The pinned action schema has no ignore-404 / successful-status override.
If a registered DELETE fails on an already absent item, independently confirm
absence with **GET of that exact saved ID returning 404** in the same tenant.
A 401/403 or a newly created item's replication 404 is not absence evidence.
Only after confirmed absence, remove just the cleanup action from state:

```shell
terraform state rm 'module.assignment.msgraph_resource_action.remove'
terraform destroy -refresh=false
```

Adapt the module address to the calling root. This is a cleanup-only exception
to the prohibition on state editing: state removal itself revokes no access.
Finish destroying the remaining local records; do not re-apply between state
removal and completing destroy, which would register the absent ID again.
Never use this exception to recover a verification failure after create.

Keep both actions and ownership state until cleanup succeeds, except for the
confirmed-absence exception above. Registration preconditions require an opaque
URL-safe item ID and a normalized resource GUID. These checks reject malformed saved ownership when
registering removal; they are not a destroy-time state integrity check. Direct
edits to the stored action URL are unsupported and can bypass configuration.
No Python interpreter or Azure CLI session is required. No secret input or
output is exposed; object identifiers and permissions live in Terraform state.

## Requirements

| Name | Version |
| --- | --- |
| Terraform | >= 1.11.0 |
| microsoft/msgraph | >= 0.6.0, < 0.7.0 |

Offline execution uses msgraph 0.6.0. Each calling root must commit its provider
lock file. The provider range admits only the reviewed 0.6 minor line.

The pinned create permissions are `AppRoleAssignment.ReadWrite.All` **and**
`Application.Read.All`. The resource lookup and item read need
`Application.Read.All`; deletion needs `AppRoleAssignment.ReadWrite.All`.
The provider credentials cover creation, verification and deletion. Delegated access also requires a supported Entra
administrator role. The pinned write-role include lists Application
Administrator and Cloud Application Administrator, among others; for Microsoft
Graph and Azure AD Graph app roles, Privileged Role Administrator is the least
privileged supported role. Do not infer authorization from license entitlement.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- This baseline covers the directory operation only. Assigning a group to an application requires APP-GROUP-ASSIGNMENT: Microsoft Entra ID P1 or P2 for users receiving application access through the group. The opaque principalId input cannot distinguish a group from a user or service principal, so this registry cannot activate that conditional rule automatically; independently identify the principal type and verify group coverage before applying.
- An app role assignment to a client service principal grants an application permission; it does not grant a delegated permission, provision licenses or establish entitlement to the resource API or SaaS service. Verify the resource-specific product requirements separately.
- AppRoleAssignment.ReadWrite.All and Application.Read.All, plus an appropriate Entra administrator role for delegated access, are authorization requirements. Creation, verification and deletion use the same provider credentials. Live lifecycle and effective access remain unverified.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | On change |
| --- | --- | --- | --- | --- |
| resourceId | Resource service principal object GUID | `string` | required | replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.assignment` |
| principalId | User, group or client service principal object GUID | `string` | required | replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.assignment` |
| appRoleId | Explicit app role GUID; all-zero requires a resource read proving no appRoles | `string` | `null` | replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.assignment` when its effect on `local.app_role_id` changes |
| appRoleValue | Exact value resolved by a read-only lookup; exclusive with appRoleId | `string` | `null` | replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.assignment` |

## Outputs

| Name | Description | Known in plan after an update |
| --- | --- | --- |
| id | Opaque owned assignment ID | yes |
| resourceId | Configured, normalized resource GUID, verified by postcondition | yes |
| principalId | Configured, normalized recipient GUID, verified by postcondition | yes |
| appRoleId | Explicit or lookup-derived configured role GUID, verified by postcondition | yes |

## Live status and acceptance runbook

No live run has been made. Pinned Learn contracts, mocked Terraform tests and
built-in-provider lifecycle tests check construction, refusal and replacement
dependencies only. Provider DELETE transport, replication and effective access
remain unverified. Before live use, confirm the selected provider schema on
each execution platform supports destroy-only actions and DELETE.

The owner-dispatched acceptance probe uses a sandbox resource application with
an enabled User/Application role, a test user, group and client service
principal, and separately reviewed automation permissions. Owner steps:

1. Confirm licensing (especially group-based access) and authorization for the
   provider credentials used by create, verification and delete.
2. Create one assignment for each principal kind using explicit IDs; independently
   GET each item and confirm the ID and identity triple. Confirm another existing
   assignment to the resource stays unchanged. Refresh and verify a no-op plan.
3. Repeat with the exact role-value lookup; test no match, disabled role and
   wrong principal/role member type without accepting unintended access. Confirm
   a GUID case-only input change causes no write or replacement.
4. Change principal, resource and role independently, then the value selector or
   resolved GUID. Verify destroy-first replacement, old-ID absence, new-ID
   identity, unrelated assignments unchanged, and a no-op plan afterwards.
5. On a separate resource application with no declared roles, assign the explicit
   all-zero role. Confirm Graph's read-back and actual application-access behavior.
6. Exercise denied creation verification reads and different identity evidence
   in a controlled test harness. Verify failure prevents deletion registration,
   reconcile the saved POST result, then retry without POST replay. Probe
   out-of-band removal and `-refresh=false` deletion of the saved ID.
7. Destroy all owned assignments; verify exact-ID absence, unchanged unrelated
   assignments, and eventual loss of effective access with fresh tokens. Remove
   sandbox principals/application fixtures only after assignments are gone.

Also probe bounded replication retries, retry apply without POST replay, legacy
unchanged upgrade, and confirmed-absence state removal after DELETE 404.

Retain sanitized run evidence for the request, independent read-back, replacement
order and cleanup outcome without tenant identifiers or tokens. Delayed effective
access/token revocation and relationship replication remain live acceptance questions.

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `resourceId`: replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.assignment`.
- `principalId`: replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.assignment`.
- `appRoleId`: replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.assignment` when its effect on `local.app_role_id` changes.
- `appRoleValue`: replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.assignment`.
<!-- drift:end -->
