# Conditional Access country named locations

Creates a Microsoft Entra country named location (`#microsoft.graph.countryNamedLocation` at
`identity/conditionalAccess/namedLocations`) via the `microsoft/msgraph` Terraform provider.
Conditional Access policies reference the location's `id` in their location condition.

The module sends the derived `@odata.type` on create and on every update, as Microsoft Graph
requires. Changing `country_lookup_method` replaces the location, because the update API does
not list that property; the replacement is created before the old location is deleted.

## Usage

```hcl
module "blocked_regions" {
  source = "../../modules/curated/identity/conditional-access/named-locations/countries"

  display_name          = "Blocked regions"
  countries_and_regions = ["CA", "IN"]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.5.0 |

`microsoft/msgraph` 0.5.0 is the first release that sends a changed nested object in full on
update; earlier releases are not supported by this module.

| Operation | Least privileged application permissions | Least privileged delegated roles |
| --- | --- | --- |
| [Create](https://learn.microsoft.com/en-us/graph/api/conditionalaccessroot-post-namedlocations?view=graph-rest-1.0) | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | Conditional Access Administrator or Security Administrator |
| [Update](https://learn.microsoft.com/en-us/graph/api/countrynamedlocation-update?view=graph-rest-1.0) | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | Conditional Access Administrator or Security Administrator |
| [Delete](https://learn.microsoft.com/en-us/graph/api/namedlocation-delete?view=graph-rest-1.0) | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | Conditional Access Administrator or Security Administrator |
| [Read](https://learn.microsoft.com/en-us/graph/api/namedlocation-get?view=graph-rest-1.0) (refresh) | `Policy.Read.All` | Conditional Access Administrator, Security Administrator, Security Reader or Global Reader |

Delegated callers also need the `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess`
scopes in their token.

## Lookup method and report-only side effects

- `clientIpAddress` (default) maps the sign-in IP address to a country or region.
- `authenticatorAppGps` uses the Microsoft Authenticator app. Users can be prompted every hour
  to share their location, and "a Conditional Access policy with GPS-based named locations in
  report-only mode prompts users to share their GPS location, not sharing this information may
  result in a block"
  ([Network assignment](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-assignment-network#countries)).
  Use it only for sensitive apps where that is acceptable. It is not supported in the
  Microsoft Cloud for US Government.
- `include_unknown_countries_and_regions = true` also matches IP addresses that do not map to a
  country or region. Learn describes it for IP-based lookup only; its effect with
  `authenticatorAppGps` is not documented.

## Limits and lifecycle

- Deleted named locations are soft-deleted and can be restored for 30 days
  ([Recover from deletions](https://learn.microsoft.com/en-us/entra/architecture/recover-from-deletions)).
- A location that a policy still references should be destroyed after that policy. Pass the
  location's `id` output to the policy so that Terraform orders the destroy. That ordering
  works only within one state: keep each location in the same state as every policy that
  references it, or change the reference in the other state first. What Microsoft Graph
  does when a referenced location is deleted (refuse, or delete and leave the policy
  pointing at nothing) is not documented and not tested here. A block policy that excludes
  only this location would then apply everywhere (inference).
- **After a failed replacement, do not rerun a plain apply.** If an apply that changed
  `country_lookup_method` fails, Terraform has already recorded the new method in its
  replacement trigger, so the retry updates the old location in place with a property the
  update API does not list, and the old method can stay in force. If the new location was
  created but could not be read back, it also exists outside the state. Look for a location
  with the same display name, delete the one that is not in state, then run
  `terraform apply -replace='<module address>.msgraph_resource.named_location'`, and check
  that the `country_lookup_method` output matches the configuration.
- Learn states the 195 named location limit for IP locations only; whether country locations
  count towards it is not documented.

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
| countries_and_regions | Two-letter upper-case codes, at least one | `set(string)` | n/a | yes |
| include_unknown_countries_and_regions | Also match addresses without a country or region | `bool` | `false` | no |
| country_lookup_method | `clientIpAddress` or `authenticatorAppGps`; a change replaces the location | `string` | `"clientIpAddress"` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the named location, for a policy's location condition |
| display_name | The display name Microsoft Graph returned on the last read |
| countries_and_regions | The codes Microsoft Graph returned on the last read, sorted |
| include_unknown_countries_and_regions | The unknown-countries flag Microsoft Graph returned on the last read |
| country_lookup_method | The lookup method Microsoft Graph returned on the last read |
