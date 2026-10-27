# licence-guard

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive outputs: `licensed_skus`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Plan-time licence check shared by the [security baseline](../README.md) modules. The
calling module declares the tier it needs; the guard fails the plan when the tenant has no
usable subscription for that tier. It creates no resources and sends no Graph writes.

- `free` reads nothing and always passes.
- `p1` and `p2` read [`GET /subscribedSkus`](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)
  with `$select=skuId,skuPartNumber,capabilityStatus,prepaidUnits,servicePlans`. The API
  supports only `$select`, so the guard filters the SKUs itself.

A tier is licensed when at least one subscribed SKU meets all three conditions:

1. `capabilityStatus` is `Enabled`;
2. `prepaidUnits.enabled` is an actual nonnegative integer greater than zero;
3. `servicePlans[].servicePlanId` lists the tier's service plan.

| Tier | Registry plan | Service plan | Service plan ID |
| --- | --- | --- | --- |
| `p1` | `ENTRA_ID_P1` | `AAD_PREMIUM` | `41781fb2-bc02-4b7c-bd55-b576c07bb09d` |
| `p2` | `ENTRA_ID_P2` | `AAD_PREMIUM_P2` | `eec0eb4f-6444-4f95-aba0-50c24d67f998` |

The IDs are generated into `plans.tf` from the licensing registry and are never typed into
the module logic. The Microsoft Entra ID P2 product lists `AAD_PREMIUM` as well as
`AAD_PREMIUM_P2`, so a tenant with only P2 passes `p1`
([licensing service plan reference](https://learn.microsoft.com/en-us/entra/identity/users/licensing-service-plan-reference)).

A SKU in the `Warning`, `Suspended`, `Deleted` or `LockedOut` state never counts
([subscribedSku](https://learn.microsoft.com/en-us/graph/api/resources/subscribedsku?view=graph-rest-1.0)).
It does not block another SKU that qualifies. When no SKU qualifies, the error names every
SKU that lists the plan, with its state and enabled units, for example
`AAD_PREMIUM_P2 (Suspended, 0 enabled units)`.

No `count` or `for_each` depends on licence data. The read exists only for `p1` and `p2`,
based on the tier input alone, so a licence change can fail a plan but never adds or
removes resources.

## Usage

Install a release using the [Terraform Registry instructions](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry); replace `<version>` with that release version.

```hcl
module "licence_guard" {
  source  = "satolap/modules/msgraph//verified/security-baseline/licence-guard"
  version = "<version>"

  tier          = var.tier
  allowed_tiers = ["p1", "p2"]
}

locals {
  # Use the guard's output, not var.tier, so dependent resources wait for the guard.
  tier = module.licence_guard.tier
}
```

Both checks are preconditions on the `tier` output. Terraform evaluates them in every plan,
even when the caller does not reference the output. Referencing it also orders dependent
resources after the check when the read can only happen during apply.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.6.0, < 0.7.0 |

Terraform 1.11 or later is required, including for the offline mock suites.

For `p1` and `p2`, the identity needs `LicenseAssignment.Read.All`, the least-privileged
permission for delegated and application access
([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).
Delegated callers acting on other users also need a supported role, such as Global Reader or
Directory Readers. The `free` tier needs no permission.

## Limits

- The guard checks the tenant's subscriptions, not per-user assignments. Licence
  compliance for the users in scope stays with the tenant preflight.
- `servicePlans[].provisioningStatus` is not evaluated.
- The guard fails every plan once the licence lapses. A caller that must still apply
  afterwards, for example to remove its objects, decides that explicitly.
- Provider 0.6.0 source follows collection next links, but real HTTP pagination is not proved
  by the mock suite. Missing paging exports, remaining markers, incomplete service-plan IDs,
  and malformed capacity types fail closed.
- `licensed_skus` is sensitive; state and saved plans retain subscription data. This is a
  tenant-capacity check, not per-user entitlement or a complete license-compliance assessment.
- Only mocked tests cover the module; it has not run against a licensed tenant.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- The guard only reads the tenant's subscribed SKUs and uses no premium feature itself. Its tier input states the calling module's requirement; the module that calls it carries that feature rule.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| tier | Tier the calling module needs: `free`, `p1` or `p2` | `string` | n/a | yes | no object change (validation or timing only) |
| allowed_tiers | Tiers the calling module supports | `set(string)` | `["free", "p1", "p2"]` | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| tier | The tier, once the allowed-tier and licence checks pass | yes |
| licensed_skus | SKUs that license the tier: `sku_id`, `sku_part_number`, `capability_status` and `prepaid_units`; empty for `free` | no |
