# Delegated permission grants

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

Create one Microsoft Graph v1.0 `oauth2PermissionGrants` delegated permission
grant, equivalent in purpose to `azuread_service_principal_delegated_permission_grant`.
This authorizes a client application to call a resource API on behalf of a user.
It creates no application, service principal, user or application permission.

For a published release containing this module, replace `<version>` with the
release version. Availability in this source tree does not mean that an
existing release already includes the module. See the
[terraform-msgraph-modules installation guide](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry).

```hcl
module "delegated_reader" {
  source  = "satolap/modules/msgraph//verified/oauth2PermissionGrants"
  version = "<version>"

  clientId    = var.client_service_principal_object_id
  resourceId  = var.resource_service_principal_object_id
  consentType = "Principal"
  principalId = var.user_object_id
  scopes      = ["User.Read"]
}
```

Both service principal inputs take **object IDs**, not application (client)
IDs. `consentType` has no default. `Principal` requires a user `principalId`.
For **tenant-wide admin consent**, explicitly set `consentType = "AllPrincipals"`,
leave `principalId = null`, and set `acknowledge_all_principals = true`.
Without the acknowledgement the plan fails, including on scope updates.
Acknowledgement expresses intent; it does not confer administrator privileges.

`scopes` is a nonempty set of exact, case-sensitive permission claim values from
the resource service principal's `oauth2PermissionScopes`, not display names or
permission GUIDs. Names cannot be null, empty or contain whitespace. The module
sorts and deduplicates them into single-space-separated Graph `scope` (at most
3,850 characters, including separators). It does not read or create scope
definitions; Graph validates availability and consent authorization. Review the
privilege of every scope, particularly with tenant-wide consent.

## Lifecycle and ownership

Only **new grants created by this module** are supported. Do not import, adopt
or share an existing grant with another writer, including the AzureAD provider.
Reconcile an existing equivalent grant before create; duplicates are not
adopted. There is no collection enumeration, automatic discovery or migration.

`msgraph_resource_action.grant` performs a one-shot POST with
`ignore_changes = all`. It never re-sends POST for an in-place change. A response
postcondition requires a URL-safe opaque ID and matching client, resource,
consent type and user (explicit null for AllPrincipals). This runs **after** the
operation; failed or ambiguous POSTs can leave a remote grant without ownership
state. Independently reconcile the response before retrying; never blindly
repeat POST. The action does not detect out-of-band deletion or recreate a
missing grant on refresh.

### Recovery after a failed create postcondition

If POST succeeds but its identity postcondition fails, `terraform_data.owned`
is never created. The remote grant, including tenant-wide consent, then has
**no automatic delete path**: Terraform destroy only forgets the POST action.
A repeated create can hit a duplicate-grant conflict. Stop before retrying;
neither a failed apply nor removal of local state revokes this access.

An owner must privately recover the exact URL-safe `created-grant-id` from the
captured POST response or the failed action's saved output, confirm the provider tenant, and independently read that same ID:

```http
GET https://graph.microsoft.com/v1.0/oauth2PermissionGrants/{created-grant-id}
```

Compare the returned `id` with the captured created ID, and `clientId`,
`resourceId`, `consentType`, `principalId` (explicit null for AllPrincipals) and
`scope` with the intended create request. GUID letter case and scope ordering
do not change identity. The created ID and matching evidence must prove this
is the grant created by this apply. If the created ID is unavailable or the
identity cannot be proved, stop for independent owner investigation. Never
select a substitute grant by client/resource or delete mismatched consent.

Only after that identity check, manually delete the verified created ID:

```http
DELETE https://graph.microsoft.com/v1.0/oauth2PermissionGrants/{created-grant-id}
```

Confirm exact-ID absence with the same GET returning 404 before retrying.
Denied reads do not prove absence; existing access tokens remain valid until
expiry. If the failed action remains in Terraform state, review
`terraform plan -replace=module.delegated_reader.msgraph_resource_action.grant`
(adapt the module address) only after remote absence is confirmed, then apply
the reviewed plan. A new POST must pass its response postcondition, followed by
the independent GET verification, before ownership is captured. Do not import/adopt another grant or fabricate an ownership record.
Keep recovery responses and state private; retain only sanitized evidence.

Learn documents PATCH of **scope only**. `msgraph_update_resource.scope` sends
the complete desired scope string, once after creation and whenever scopes
change. Adding and removing scopes updates in place and keeps the grant ID;
scope order and duplicates cause no change. PATCH overwrites the grant's scopes,
so concurrent external edits are outside the ownership contract. The sidecar
reads the item but is not proof of independent read-back or effective access.
It never creates or deletes a grant. An out-of-band deletion can make its GET
fail; use `terraform destroy -refresh=false` with captured ownership to clean
up. This skips refresh; cleanup uses the previously verified saved ID with
provider credentials. No absent grant is silently recreated.

`terraform_data.immutable` replaces the action destroy-first when `clientId`,
`resourceId`, `consentType` or `principalId` changes. GUIDs are lowercased in
bodies, triggers and stored ownership; a GUID case-only change is a no-op.
Scope changes do not replace the grant. Identity replacement deletes the old
grant before creating a new ID, interrupting access. The helper's first creation
alone does not trigger replacement; after lost helper state, apply unchanged
inputs before relying on it. No create-before-destroy is enabled.

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
behavior; this remains a separate live acceptance probe. The governance
`tests/integration/grant.tftest.hcl` run `destroy_grant` checks collection absence
after normal registered deletion; it does not exercise DELETE of an already
absent item. That probe requires an out-of-band exact-ID deletion and recovery
of a potentially failed destroy action, so it is not added to the automatic
suite until the runner can preserve and classify either provider outcome.
`-refresh=false` skips failing reads but still sends DELETE to the saved ID with
provider credentials.

### Failed verification after create

The verification GET retries HTTP 404 / NotFound / Request_ResourceNotFound
errors for at most two minutes, using the provider's supported retry object and
read timeout. This is a bounded replication workaround, not live replication
proof. It is configured only on GET, never on POST or DELETE.

If apply fails after create because verification cannot yet read the item,
**re-run apply with unchanged inputs; never use destroy as recovery**. Keep the
saved successful POST action: retrying apply reads its saved ID and registers
cleanup without re-sending POST. Until `msgraph_resource_action.remove` exists,
destroy silently forgets the POST action and can leave the grant in the tenant
with nothing in state to delete it. For AllPrincipals this can leave tenant-wide
consent. Do not taint, force replacement or edit state to retry verification.
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
GET https://graph.microsoft.com/v1.0/oauth2PermissionGrants/{created-grant-id}
DELETE https://graph.microsoft.com/v1.0/oauth2PermissionGrants/{created-grant-id}
```

Compare `id`, `clientId`, `resourceId`, `consentType` and `principalId` (explicit
null for AllPrincipals); also review the intended `scope`. Existing access
tokens can survive deletion until expiry. The failed-create postcondition
recovery above gives the full reconciliation sequence.

The pinned action schema has no ignore-404 / successful-status override.
If a registered DELETE fails on an already absent item, independently confirm
absence with **GET of that exact saved ID returning 404** in the same tenant.
A 401/403 or a newly created item's replication 404 is not absence evidence.
Only after confirmed absence, remove just the cleanup action from state:

```shell
terraform state rm 'module.delegated_reader.msgraph_resource_action.remove'
terraform destroy -refresh=false
```

Adapt the module address to the calling root. This is a cleanup-only exception
to the prohibition on state editing: state removal itself revokes no access.
Finish destroying the remaining local records; do not re-apply between state
removal and completing destroy, which would register the absent ID again.
Never use this exception to recover a verification failure after create.

Keep both actions and ownership state until cleanup succeeds, except for the
confirmed-absence exception above. Registration preconditions require an opaque
URL-safe item ID. These checks reject malformed saved ownership when
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
lock file. The pinned create, update and delete pages name
`DelegatedPermissionGrant.ReadWrite.All`; read names `Directory.Read.All`
as least privileged and also permits `DelegatedPermissionGrant.ReadWrite.All`.
Cleanup needs permission to read and
delete. Delegated writes also require a supported Entra role, including
Application Administrator or Cloud Application Administrator as listed in the
pinned role include. Verify the exact permissions and role for your API and
consent policy. API authorization is separate from licensing.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- Delegated permission grants use the basic directory-operation baseline by inference: the pinned Graph grant APIs specify authorization permissions and roles but no additional premium license. This grants consent only; it does not license the client, resource API or downstream workloads. Verify resource-specific product requirements separately.
- AllPrincipals grants tenant-wide admin consent and requires explicit acknowledgement in this module. DelegatedPermissionGrant.ReadWrite.All and supported delegated administrator roles are authorization requirements, not license entitlement. Creation, verification and deletion use the same provider credentials. Live lifecycle and effective access remain unverified.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | On change |
| --- | --- | --- | --- | --- |
| clientId | Client service principal object GUID | `string` | required | replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.grant` when its effect on `local.identity` changes |
| resourceId | Resource API service principal object GUID | `string` | required | replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.grant` when its effect on `local.identity` changes |
| consentType | Explicit Principal or AllPrincipals | `string` | required | replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.grant` when its effect on `local.identity` changes |
| principalId | User object GUID for Principal; null for AllPrincipals | `string` | `null` | replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.grant` when its effect on `local.identity` changes |
| acknowledge_all_principals | Explicit tenant-wide admin consent acknowledgement | `bool` | `false` | no object change (validation or timing only) |
| scopes | Complete nonempty set of delegated scope names | `set(string)` | required | kept from creation in `msgraph_resource_action.grant`; updates `msgraph_update_resource.scope` in place |

## Outputs

| Name | Description | Known in plan after an update |
| --- | --- | --- |
| id | Opaque owned grant ID | yes |
| clientId | Normalized client object GUID verified on create | yes |
| resourceId | Normalized resource object GUID verified on create | yes |
| consentType | Consent type verified on create | yes |
| principalId | Normalized user object GUID or null verified on create | yes |
| scope | Configured sorted scope string | yes |

## Live status and acceptance runbook

No live run has been made. Pinned Learn contracts, mocked Terraform tests and
built-in-provider lifecycle tests check construction, identity refusal and
replacement dependencies only. Provider DELETE transport, refresh behavior,
consent enforcement, replication and effective access remain unverified.
Before live use, confirm the selected provider schema on each execution platform
supports destroy-only actions and DELETE.

Owner-dispatched sandbox steps remaining:

1. Review API scopes, licensing, consent policy and provider credentials. Prepare
   sandbox client and resource service principals, two scope definitions, a test
   user and an unrelated grant.
2. Apply Principal consent. Independently GET the created ID and compare all
   identity fields and scope. Confirm a refresh/no-op plan and effective delegated
   access using a fresh user token. Confirm unrelated consent stays unchanged.
3. Add and remove scopes; verify scope-only PATCH, unchanged ID, exact independent
   read-back, fresh-token access and no-op plans. Reorder scopes and change GUID
   case only; verify no write. Exercise invalid scopes without unintended consent.
4. Confirm AllPrincipals fails planning without acknowledgement and with a user
   ID; deliberately acknowledge a reviewed sandbox tenant-wide grant. Independently
   verify null principalId, scope and access for two sandbox users.
5. Change client, resource, user and consent type separately. Verify old-ID absence
   before new POST, a new matching ID, unchanged unrelated grants and no-op plans.
6. In a controlled harness, test denied creation verification reads and
   incomplete/different identity; confirm no deletion registration or scope PATCH.
   Reconcile the saved POST result, retry without POST replay, then test
   out-of-band removal and exact-ID DELETE with `-refresh=false`. Confirm the
   selected provider uses the same credentials for create, verification and delete.
7. Destroy every owned grant. Independently verify exact-ID absence, unchanged
   unrelated consent and eventual loss of access with fresh tokens before removing
   sandbox principals. Existing access tokens can remain valid until expiry.

Also probe bounded replication retries, failed verification followed by unchanged
apply without POST replay, legacy-state unchanged upgrade, and confirmed-absence
state removal after DELETE 404. Never use destroy to recover failed verification.

Retain sanitized evidence without tenant identifiers, raw tokens or responses.

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `clientId`: replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.grant` when its effect on `local.identity` changes.
- `resourceId`: replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.grant` when its effect on `local.identity` changes.
- `consentType`: replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.grant` when its effect on `local.identity` changes.
- `principalId`: replaces `msgraph_resource_action.remove` (its destroy deletes the previous ID); replaces `msgraph_resource_action.grant` when its effect on `local.identity` changes.
- `acknowledge_all_principals`: no object change (validation or timing only).
- `scopes`: kept from creation in `msgraph_resource_action.grant`; updates `msgraph_update_resource.scope` in place.
<!-- drift:end -->
