# Conditional Access IP named locations

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

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one.

```hcl
module "office_egress" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/identity/conditional-access/named-locations/ip-ranges?ref=<release-tag>"

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
| terraform | >= 1.5.0 |
| msgraph | >= 0.5.0 |

`microsoft/msgraph` 0.5.0 is the first release that sends a changed nested object in full on
update; earlier releases are not supported by this module.

The module sets minimum versions only. Azure Verified Modules also require a maximum major
version (TFNFR25, TFNFR26); this module follows HashiCorp's guidance for reusable modules
instead, which is to "constrain only their minimum allowed versions of Terraform and
providers"
([Version constraints](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)).
The provider is 0.x, so a minor release can break the module; the release manifest records
the provider version it was tested with. Set upper bounds in your root module.

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

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | CONDITIONAL-ACCESS | Conditional Access requires Microsoft Entra ID P1. Risk-based policies (sign-in risk and user risk) also need Microsoft Entra ID Protection, a Microsoft Entra ID P2 feature, which is a separate rule. When the licenses expire, existing policies are not disabled or deleted; they can be viewed and deleted but no longer updated. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). | Users in scope of the policies; the reviewed pages state the tenant requirement without a per-user counting rule, so review coverage against the product terms | direct / per_tenant | documented |

Notes:

- Named locations are configured under Conditional Access and take effect only through a policy that references them. The reviewed pages state no separate licence rule for named locations; the CONDITIONAL-ACCESS rule is applied to them by inference.
- The Conditional Access rules were reviewed against Microsoft Learn on 2026-09-29, which is later than the review date stated above.

Sources: [Conditional Access license requirements](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview#license-requirements), [Microsoft Entra Conditional Access licensing](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#microsoft-entra-conditional-access).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| display_name | Display name of the location | `string` | n/a | yes |
| ip_ranges | 1 to 2000 canonical IPv4 or IPv6 CIDR ranges, each longer than /8 | `set(string)` | n/a | yes |
| is_trusted | Mark the location as trusted; set false before destroy | `bool` | `false` | no |
| api_version | Graph API version; only `v1.0` is supported | `string` | `"v1.0"` | no |
| timeouts | `create`, `read`, `update` and `delete` timeouts, such as `30m`; create, update and delete at least `15s`; retries count against them | `object` | `{}` (`10m` for create, update and delete; the provider default for read) | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the named location, for a policy's location condition |
| display_name | The display name Microsoft Graph returned on the last read |
| is_trusted | The trusted flag Microsoft Graph returned on the last read |
| ip_ranges | The CIDR ranges Microsoft Graph returned on the last read, sorted |
