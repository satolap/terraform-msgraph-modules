# Application password credentials

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive outputs: `secretText`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

**Blocking security caveat (msgraph 0.6.0):** `terraform show`, `terraform state
show`, and rotation/destroy plans print the live `secretText` in clear text from
the managed action's nonsensitive `output`. Only the separate module output is
marked sensitive. Do not use this module where plan/show output cannot be kept
secret. No CI plan logs or PR plan comments are permitted for roots using it.
Explicit `acknowledge_secret_in_plan_output = true` is required; this opt-in
acknowledges the exposure and does not redact or encrypt anything.

See the [state and plan protection guide](../../../../docs/scenarios/state-protection.md)
for storage, access and incident controls and the provider exposure limitation
tracked as #265, PL-013.

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Create one new password on an existing application's **object ID**, through
Microsoft Graph v1.0 `POST /applications/{id}/addPassword`. Graph generates the
password and returns it once. This module never accepts a password, certificate
or private key and never adopts an existing credential. Application certificates
and service-principal certificates remain outside this delivery (#382). Service-principal passwords are available separately in
[`servicePrincipals/passwordCredentials`](../../servicePrincipals/passwordCredentials/README.md).

For a published release containing this module, replace `<version>` with that
release version. The [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry)
explains registry installation. Source availability does not establish published
availability.

```hcl
module "password" {
  source  = "satolap/modules/msgraph//verified/applications/passwordCredentials"
  version = "<version>"

  application-id   = module.application.id
  displayName      = "Automation credential"
  rotation_trigger = "generation-1"

  acknowledge_secret_in_plan_output = true
}

output "application_password" {
  value     = module.password.secretText
  sensitive = true
}
```

Terraform >= 1.11.0 and msgraph >= 0.6.0 with the destroy-only action schema are
required. This module uses the caller's provider authentication for both actions;
it needs no Azure CLI, local cleanup script or additional provider.

## Permissions and requirements

The pinned add/remove pages list application permission
`Application.ReadWrite.OwnedBy` as least privileged: the calling application must
own the target. Higher permissions are `Application.ReadWrite.All` or
`Directory.ReadWrite.All`. The independent GET needs permission to read the target
(`Application.Read.All` is its least-privileged application permission; the write
permissions above are also listed). For delegated access, the action tables list
`Application.ReadWrite.All`; the signed-in user's supported role or ownership is
also required. The pinned role include lists a non-admin member or Application
Developer for owned applications, Cloud Application Administrator, or Application
Administrator. Consent and ownership/role requirements are authorization, not
premium-license entitlement. Use an isolated application, never the credential
used to authenticate the provider itself.

## Secrets and state

Secret flow is exactly: Graph HTTPS addPassword response -> msgraph provider
memory and the action's `output.secretText` in Terraform state -> module
`secretText` sensitive output -> any caller-managed destination. State, state
history/backups and saved plans can contain the password in plaintext. The module
output's sensitive flag does not mark the underlying resource attribute:
`terraform show`, `terraform state show`, and rotation/destroy plans print the
live password in clear text. A plan that is never applied or fails can leak a
credential that remains valid. Treat all plan/show output as secret; do not
capture CI plan logs or publish PR plan comments for these roots. JSON output,
`terraform output -raw`, and provider debug/HTTP logs can expose it too. Keep debug
logging off and restrict access to these artifacts. No whole-response
output or password hint is exported. Verification selects only application ID and
password metadata. The removal action stores only the application object path and
keyId, never the password. The provider's own authentication token is handled by
the provider, not passed into a script or module output.

The approved policy and the specified local mirror contain only msgraph 0.6.0.
Offline Linux and Windows schema checks found no sensitive response export,
`sensitive_body`, write-only attribute, ephemeral resource, or Terraform action
that could avoid this durable response. Synthetic probes on Terraform 1.11.4 and
1.16.2 show that wrapping the body, response selectors or module output with
`sensitive()` does not mark the computed resource response. A child ephemeral
output cannot erase its source: 1.11.4 rejects this non-ephemeral source, while
1.16.2 accepts the output but still prints the durable resource value. The
provider does not implement an ephemeral `msgraph_resource_action`.
The acknowledgement is a blocking consent gate for this known limitation, not a
security fix or a claim that the secret is redacted.

A lost state cannot recover secretText through GET. Do not import, taint or target
individual internal resources: they form one lifecycle. Use paired state removal
only after the reconciliation described below. If a POST
succeeds but its response/state is lost, reconcile metadata on the isolated
application and revoke the orphan explicitly before retrying; do not blindly
re-send addPassword. Transient transport retries are provider behavior, so this
module does not claim exactly-once delivery on an ambiguous network failure.

## Rotation, verification and destroy

Every creation input and `rotation_trigger` is captured in a replacement trigger.
A case-only application-ID change is a no-op. Both actions have
`ignore_changes = all`: an in-place apply never re-sends either POST. A changed
trigger/input replaces the pair with `create_before_destroy`: add the new
credential, independently GET the same application and compare exactly one
returned keyId plus displayName/start/end, persist its destroy-only removal action,
then POST removePassword for the old keyId. No collection PATCH, collection-wide
ownership, application deletion or name-based removal is used.

The destroy-only action sends nothing on create/update. Its delete removes only
the keyId saved from this module's creation response **after that identity was
independently verified**. It does not GET again during destroy. KeyId is the
immutable credential identity; this relies on intact Terraform state and Graph
not reusing keyIds. Missing/ambiguous/mismatched proof fails removal registration
closed. Missing IDs, secretText or dates also fail closed. On verification failure
a newly added password can remain with its keyId in the saved add action but
without a registered remove action. With unchanged rotation inputs, a retry apply
re-reads that saved new key, registers its removal, then finishes deposed old-key
cleanup without re-sending addPassword. Destroy between the failed rotation and
its retry can revoke the old key while leaving the new one orphaned; reconcile
every saved current/deposed keyId before destroying. Out-of-band key removal can
fail verification on every ordinary plan; deletion of the application can make
the GET fail with 404. Learn documents only removePassword's successful 204,
so its response for an unknown keyId is unverified and might succeed or error.
No such outcome authorizes a collection or parent-delete fallback. Destroy never removes
other credentials or recovers the secret, and it does not prove absence by itself.

For recovery from out-of-band removal, independently confirm absence or explicitly
revoke only every owned current/deposed keyId recorded in protected state, and
preserve unrelated credentials. After all those keys are independently absent,
securely back up state, then forget both action addresses together (substitute the
actual module address):

```sh
terraform state rm 'module.password.msgraph_resource_action.add' 'module.password.msgraph_resource_action.remove'
```

State removal forgets current and deposed objects without sending revocation;
it cannot recover the password and is unsafe while any owned key remains live.
Leave the identity trigger in place. A subsequent full apply with the module still
configured creates a fresh password and removal registration; remove the module
configuration instead if retiring it. Do not target individual actions to recover.

Rotation orders credential creation and verification before old-key removal; it
does not wait for a consuming service to switch credentials. For a staged consumer
cutover, keep two separate module instances, deploy the new secret, confirm the
consumer uses it, then remove the old instance in a later apply. Do not put a
consumer deployment between the two internal actions with targeting. A future
startDateTime can leave an authentication gap even though the credential exists.

## Validity policy

Omitted dates let Graph use now and startDateTime + 2 years; the default expiration
is therefore two years. Explicit dates must be valid UTC RFC3339 timestamps ending
in Z. An explicit end requires an explicit start, must follow it, and must be in
the future relative to `plantimestamp()` (including on later plans). An expired
explicit date therefore blocks normal plans and requires the recovery above or
an intentional rotation to valid dates. This fail-closed rule is module policy.
Learn states no universal maximum for an explicit end; organization/application policies can
impose stricter limits and Graph can reject the requested lifetime. No artificial
upper bound is presented as a Graph limit. The nonempty, whitespace-free
1-256-character displayName bound is a conservative module policy.

## Live acceptance runbook (owner-dispatched)

Offline mocks prove module wiring, not Graph transport or credential usability.
The owner dispatches live acceptance in a protected environment after offline
validation:

1. Disable CI plan logging and PR plan comments for this root; protect local
   plan/show output and acknowledge the clear-text exposure explicitly. Create an
   isolated owned application and a separate unowned-by-this-module
   password as a preservation sentinel. Use the approved provider lock and verify
   its action schema includes `when = "destroy"` on every target platform.
2. Apply this module with default dates. Verify the single new keyId, name and
   validity by independent GET; check the expiration is at most two years from
   start. Consume secretText only through a protected secret store and prove it
   authenticates to the intended workload. Capture no secret or tenant response
   in repository files, logs, screenshots or PR artifacts.
3. Run a no-op apply, change only application-ID case, and run another apply:
   no add/remove POST or credential identity change is allowed.
4. Change rotation_trigger. Verify request ordering on a protected trace: new add,
   independent GET matching new metadata, then remove old keyId. Confirm new-secret
   authentication, old-key absence and sentinel preservation with independent
   reads. Check explicit valid dates, rejection of an explicit past expiration,
   invalid lifetime policy and future-start
   behavior separately on disposable instances.
5. Exercise malformed/missing/ambiguous verification and an interrupted apply.
   Confirm no unverified key is registered for removal, old-key preservation if
   replacement verification fails. Retry with unchanged rotation inputs and
   confirm no second addPassword POST, the same saved key/secret, new removal
   registration, then deposed old-key removal. Separately test destroy before
   retry only on a disposable fixture; reconcile the potentially orphaned new key.
6. Destroy normally; independently GET the application and verify only the managed
   keyId is absent, the sentinel remains, and the application still exists. Test
   out-of-band removal of the managed key, deletion of the application on a
   separate disposable instance, denied removal, and removePassword with an
   independently confirmed unknown keyId on an isolated owned application. Record
   whether unknown-key removal succeeds or errors; Learn does not promise its
   response. Confirm ordinary plans fail closed where verification cannot run or
   match, and never perform a destructive fallback. Exercise the two-address
   state-removal recovery above only after independently proving absence or
   revoking all owned current/deposed keys; verify unrelated keys are preserved
   wherever their parent still exists. Clean up only owned test fixtures and protect/destroy all
   secret-bearing state and traces according to the test environment's policy.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- Adding an application password is a basic application-management operation. Application.ReadWrite.OwnedBy requires ownership of the target; consent, ownership and delegated role requirements are authorization, not premium-license entitlement. This module does not license access to downstream workloads.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | On change |
| --- | --- | --- | --- | --- |
| application-id | Application object ID | `string` | required | replaces `msgraph_resource_action.remove`; replaces `msgraph_resource_action.add` |
| displayName | Password label, 1-256 characters | `string` | required | replaces `msgraph_resource_action.remove` when its effect on `local.password` changes; replaces `msgraph_resource_action.add` when its effect on `local.password` changes |
| startDateTime | UTC validity start; null means now | `string` | `null` | replaces `msgraph_resource_action.remove` when its effect on `local.password` changes; replaces `msgraph_resource_action.add` when its effect on `local.password` changes |
| endDateTime | UTC expiration; null means start + 2 years | `string` | `null` | replaces `msgraph_resource_action.remove` when its effect on `local.password` changes; replaces `msgraph_resource_action.add` when its effect on `local.password` changes |
| rotation_trigger | Caller-managed generation token | `string` | `"initial"` | replaces `msgraph_resource_action.remove`; replaces `msgraph_resource_action.add` |
| acknowledge_secret_in_plan_output | Required acceptance of clear-text plan/show exposure; does not redact | `bool` | `false` | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
| --- | --- | --- |
| keyId | Created and verified credential identity | no |
| secretText | One-time password; sensitive, stored in state | no |
| startDateTime | Graph-returned validity start | no |
| endDateTime | Graph-returned expiration | no |

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `application-id`: replaces `msgraph_resource_action.remove`; replaces `msgraph_resource_action.add`.
- `displayName`: replaces `msgraph_resource_action.remove` when its effect on `local.password` changes; replaces `msgraph_resource_action.add` when its effect on `local.password` changes.
- `startDateTime`: replaces `msgraph_resource_action.remove` when its effect on `local.password` changes; replaces `msgraph_resource_action.add` when its effect on `local.password` changes.
- `endDateTime`: replaces `msgraph_resource_action.remove` when its effect on `local.password` changes; replaces `msgraph_resource_action.add` when its effect on `local.password` changes.
- `rotation_trigger`: replaces `msgraph_resource_action.remove`; replaces `msgraph_resource_action.add`.
- `acknowledge_secret_in_plan_output`: no object change (validation or timing only).
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `POST /applications/{id}/addPassword` | DelegatedWork | `Application.ReadWrite.All` | - | - |
| `POST /applications/{id}/addPassword` | DelegatedPersonal | `Application.ReadWrite.All` | - | - |
| `POST /applications/{id}/addPassword` | Application | `Application.ReadWrite.OwnedBy` | - | - |
| `POST /applications/{id}/removePassword` | DelegatedWork | `Application.ReadWrite.All` | - | - |
| `POST /applications/{id}/removePassword` | DelegatedPersonal | `Application.ReadWrite.All` | - | - |
| `POST /applications/{id}/removePassword` | Application | `Application.ReadWrite.OwnedBy` | - | - |
| `GET /applications/{id}` | DelegatedWork | `Application.Read.All` | - | - |
| `GET /applications/{id}` | DelegatedWork | `Application.ReadWrite.All` | - | - |
| `GET /applications/{id}` | DelegatedPersonal | `Application.Read.All` | - | - |
| `GET /applications/{id}` | DelegatedPersonal | `Application.ReadWrite.All` | - | - |
| `GET /applications/{id}` | Application | `Application.Read.All` | - | - |
| `GET /applications/{id}` | Application | `Application.ReadWrite.OwnedBy` | - | - |

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `POST /applications/{id}/addPassword` | `passwordCredential` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /applications/{id}/removePassword` | `keyId` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `GET /applications/{id}` | `id`, `passwordCredentials` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
