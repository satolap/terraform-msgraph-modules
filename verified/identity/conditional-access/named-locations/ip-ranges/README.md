# Conditional Access IP named locations

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Potential personal-data inputs: `ip_ranges`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified live-accepted** (2026-10-24, commit `344ecc7e`). Acceptance covers the recorded run and configuration.

![live Dev: passed 2026-10-24](https://img.shields.io/badge/live%20Dev-passed%202026--10--24-brightgreen)
<!-- live-status:end -->

Creates a Microsoft Entra IP named location (`#microsoft.graph.ipNamedLocation` at
`identity/conditionalAccess/namedLocations`) via the `microsoft/msgraph` Terraform provider.
Conditional Access policies reference the location's `id` in their location condition.

The module sends the derived `@odata.type` on create and on every update, as Microsoft Graph
requires, and types each range as `#microsoft.graph.iPv4CidrRange` or
`#microsoft.graph.iPv6CidrRange` from its address. Ranges must already be in canonical CIDR
form (the value `cidrsubnet(range, 0, 0)` returns), so the module never sends a range that
Microsoft Graph could return in a different form. Every managed key is in the configured
body, and an update sends each changed top-level key in full, so a changed `ipRanges` list
is replaced as a whole.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "office_egress" {
  source  = "satolap/modules/msgraph//verified/identity/conditional-access/named-locations/ip-ranges"
  version = "<version>"

  display_name = "Office egress"
  ip_ranges    = ["192.0.2.0/24", "2001:db8::/48"]
  is_trusted   = false
}

# Reference it from a policy module:
#   locations = { include_locations = ["All"], exclude_locations = [module.office_egress.id] }
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.6.0, < 0.7.0 |

`microsoft/msgraph` 0.6.0 is required for the typed trust action. The supported
range is below 0.7.0; the release manifest records the tested provider version.

Only the Microsoft Graph v1.0 API is supported: `api_version = "beta"` fails at plan, because
Microsoft does not support beta APIs in production applications. Switching an existing named
location from `"beta"` to `"v1.0"` plans one in-place update; it sends no PATCH request and
reads the named location back through v1.0, so the apply fails if v1.0 cannot read it (not
verified).

| Operation | Least privileged application permissions | Least privileged delegated roles |
| --- | --- | --- |
| [Create](https://learn.microsoft.com/en-us/graph/api/conditionalaccessroot-post-namedlocations?view=graph-rest-1.0) | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | Conditional Access Administrator or Security Administrator |
| [Update](https://learn.microsoft.com/en-us/graph/api/ipnamedlocation-update?view=graph-rest-1.0) | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | Conditional Access Administrator or Security Administrator |
| [Delete](https://learn.microsoft.com/en-us/graph/api/namedlocation-delete?view=graph-rest-1.0) | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | Conditional Access Administrator or Security Administrator |
| [Read](https://learn.microsoft.com/en-us/graph/api/namedlocation-get?view=graph-rest-1.0) (refresh) | `Policy.Read.All` | Conditional Access Administrator, Security Administrator, Security Reader or Global Reader |

Delegated callers also need the `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess`
scopes in their token.

## Limits and lifecycle

- A tenant can hold at most 195 IP named locations, each with at most 2000 ranges, and only
  CIDR masks greater than /8 are accepted
  ([Network assignment](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-assignment-network)).
  The module validates the last two.
- **Trusted locations and destroy.** "Locations marked as trusted can't be deleted without
  first removing the trusted designation"
  ([Network assignment](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-assignment-network#trusted-locations)).
  Before `terraform destroy`, or before removing a trusted location from the configuration,
  apply `is_trusted = false` in a separate apply.
- **Untrusting changes policies that use `AllTrusted`.** Policies that include or exclude
  `AllTrusted` apply to every trusted location without naming it, so Terraform sees no
  dependency and cannot order or warn about the change. As soon as `is_trusted = false` is
  applied, a policy such as "all locations except `AllTrusted`: block" blocks sign-ins
  from this network, including a person running Terraform from it, and "MFA except
  trusted" policies start prompting. Trusted locations also feed Microsoft Entra ID
  Protection's risk calculation
  ([Network assignment, Trusted locations](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-assignment-network#trusted-locations)).
  Before untrusting, list the enabled policies
  (`GET /identity/conditionalAccess/policies`) and filter on the client for `AllTrusted`
  in `conditions.locations`. Then either create and trust the replacement location first,
  or change those policies to reference this location's `id` explicitly, so that
  Terraform orders the change.
- A location that a policy still references should be destroyed after that policy. Pass the
  location's `id` output to the policy so that Terraform orders the destroy. That ordering
  works only within one state: keep each location in the same state as every policy that
  references it, or change the reference in the other state first. What Microsoft Graph
  does when a referenced location is deleted (refuse, or delete and leave the policy
  pointing at nothing) is not documented and not tested here. A block policy that excludes
  only this location would then apply everywhere (inference).
- Deleted named locations are soft-deleted and can be restored for 30 days; a restored location
  comes back untrusted
  ([Recover from deletions](https://learn.microsoft.com/en-us/entra/architecture/recover-from-deletions)).
- Sign-ins are matched against the public IP address that reaches Microsoft Entra ID, not a
  private intranet address.
- **Create, update and delete timeouts of at least `15s`.** After each request the provider
  waits for three consistent reads 5 seconds apart, within the same timeout, so a value
  under 10 seconds always fails after the request was sent, and the module rejects values
  under `15s`. A create that fails this way leaves the named location in Microsoft Graph but
  not in the state (inference from the provider code). The provider already retries status
  codes 408, 429, 500, 502, 503 and 504 by itself, and those retries count against the
  timeouts.

## Trust verification and teardown

Before destroy or removing the module from configuration, set `is_trusted = false`
and complete a separate apply. The module sends a dedicated provider-native PATCH
with exactly `@odata.type = "#microsoft.graph.ipNamedLocation"` and the requested
`isTrusted` value. Trust changes replace only the PATCH action registration, never
the named location. The action's destroy sends no request. Other updates finish
before the trust PATCH; an independent GET then confirms the saved ID, derived type
and requested trust value. Only this GET polls a stale trust boolean or a replication 404 for the new ID (an anchored
Graph not-found envelope or leading 404 status; GB-msgraph-provider-611), for at most
two minutes, without a fixed sleep or replay of a successful create/PATCH. This
implements GB-conditional-access-501, GB-conditional-access-503/504 and
GB-delete-and-recovery-501.

A failed verification is a failed preparation, not permission to delete. Re-apply
unchanged inputs to retry the GET. If trust still has not changed, replace only
`msgraph_resource_action.trust` in the module with a reviewed apply to resend the
minimal PATCH, then require verification again. Preserve state and the live run's
ownership journal for #208 recovery; never recover an object based on its name alone
(GB-live-cleanup-504/505). Do not publish raw TF_LOG output or tenant identifiers.
The original request-body/timing cause in #226 remains unproven until a protected
provider trace is captured by the orchestrator's live run.

After successful preparation, destroy deletes the original CRUD resource. Destroy
alone does not perform this preparation and Terraform does not evaluate apply-time
GET postconditions during destroy. A direct destroy of a trusted object still fails
with Graph error 1177; do not retry that DELETE blindly. Check enabled policies
using `AllTrusted` before untrusting, since that changes their effect immediately.
No replacement ordering is needed for the location: trust changes keep its ID.

After a failed first apply, re-apply rather than destroy. For legacy state, first
complete one unchanged apply to register the action and verify the existing ID;
change trust in a later apply. If the exact saved-ID GET independently returns 404,
the location is absent: the CRUD resource refresh removes it from state, and the
PATCH action can be removed without an HTTP call. There is no destroy-only removal
action to remove from state. A 403, missing journal, or expired timeout is not absence.

Live acceptance must demonstrate trusted, independently untrusted, then exact-ID
404 after teardown, including repeated preparation and a delayed read. Protected
tracing must compare the actual update/untrust PATCH bodies and request order;
offline mocks prove neither transport nor convergence in Graph.

## Upgrading from v4.0.0 and drift behaviour

- **Provider.** Roots whose lock file pins `microsoft/msgraph` 0.5.x must run
  `terraform init -upgrade` first; this module requires `>= 0.6.0, < 0.7.0`.
- **First upgraded apply.** Run one unchanged apply. Terraform registers the new
  `msgraph_resource_action.trust` without replacing the named location (the state saved by
  v4.0.0 has no action; `tests/upgrade.tftest.hcl` covers this). That registration is a
  PATCH carrying the configured `is_trusted`. It overwrites any trust change made outside
  Terraform and takes effect at once for every Conditional Access policy that uses
  `AllTrusted`. Review that plan, and the enabled `AllTrusted` policies, before applying.
- **Drift is no longer corrected in place.** v4.0.0 corrected out-of-band trust drift with an
  in-place update. Now `msgraph_resource.named_location` ignores `body.isTrusted` and the
  trust action ignores all changes, so a refresh does not propose a change. Instead the
  independent GET (`data.msgraph_resource.verify_trust`) is read on every plan and apply. If
  the live trust value differs from `is_trusted`, each plan polls for up to two minutes and
  then fails on the postcondition; it does not fix the value. Reconcile it with a reviewed
  apply that replaces only the trust action, which resends the typed PATCH:

  ```sh
  terraform apply -replace='module.<name>.msgraph_resource_action.trust'
  ```

  `<name>` is the label of this module call in your configuration. Check the enabled
  `AllTrusted` policies first, because the PATCH changes their effect immediately.

## Independent checks

No [Maester](https://maester.dev/) test reads an IP named location's ranges.
[MT.1011](https://maester.dev/docs/tests/MT.1011/) reads its `is_trusted` flag: the check
looks for an enabled policy that targets all users, all client apps and the security
information registration user action, includes all locations, and excludes `AllTrusted` or a
named location that Maester resolves as trusted by reading every IP named location's
`isTrusted`. A location created with `is_trusted = true` can be the exclusion that satisfies
the check; one with `is_trusted = false` cannot, whatever the policy excludes. Only enabled
policies count, so a report-only policy never satisfies it. Maester reads named locations and
policies through the beta endpoint while the module uses v1.0, so a disagreement over a
beta-only property is a finding to investigate, not a module failure.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | CONDITIONAL-ACCESS | Conditional Access requires Microsoft Entra ID P1. Risk-based policies (sign-in risk and user risk) also need Microsoft Entra ID Protection, a Microsoft Entra ID P2 feature, which is a separate rule. When the licenses expire, existing policies are not disabled or deleted; they can be viewed and deleted but no longer updated. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). | Users in scope of the policies; the reviewed pages state the tenant requirement without a per-user counting rule, so review coverage against the product terms | direct / per_tenant | documented |

Notes:

- Named locations are configured under Conditional Access and take effect only through a policy that references them. The reviewed pages state no separate licence rule for named locations; the CONDITIONAL-ACCESS rule is applied to them by inference.
- The Conditional Access rules were reviewed against Microsoft Learn on 2026-09-29, which is later than the review date stated above.

Sources: [Conditional Access license requirements](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview#license-requirements), [Microsoft Entra Conditional Access licensing](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#microsoft-entra-conditional-access).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| display_name | Display name of the location | `string` | n/a | yes | in place |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that display_name must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |
| ip_ranges | 1 to 2000 canonical IPv4 or IPv6 CIDR ranges, each longer than /8 | `set(string)` | n/a | yes | in place |
| is_trusted | Mark the location as trusted; set false before destroy | `bool` | `false` | no | replaces `msgraph_resource_action.trust`; ignored in `msgraph_resource.named_location` |
| api_version | Graph API version; only `v1.0` is supported | `string` | `"v1.0"` | no | kept from creation in `msgraph_resource_action.trust`; updates `msgraph_resource.named_location` in place |
| timeouts | `create`, `read`, `update` and `delete` timeouts, such as `30m`; create, update and delete at least `15s`; retries count against them | `object` | `{}` (`10m` for create, update and delete; the provider default for read) | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The ID of the named location, for a policy's location condition | yes |
| display_name | The display name Microsoft Graph returned on the last read | no |
| is_trusted | The trusted flag Microsoft Graph returned on the last read | no |
| ip_ranges | The CIDR ranges Microsoft Graph returned on the last read, sorted | no |

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `display_name`: in place.
- `ip_ranges`: in place.
- `is_trusted`: replaces `msgraph_resource_action.trust`; ignored in `msgraph_resource.named_location`.
- `api_version`: kept from creation in `msgraph_resource_action.trust`; updates `msgraph_resource.named_location` in place.
- `timeouts`: no object change (validation or timing only).
- `name_pattern`: no object change (validation or timing only).
<!-- drift:end -->
