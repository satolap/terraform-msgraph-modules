# verify

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive outputs: `verified_policy_ids`.

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

Read-back check for the [emergency access guard](../README.md). The submodule reads the
tenant's Conditional Access policies and fails when a checked policy does not exclude every
emergency access user and group that the guard resolved. It creates, changes and deletes
nothing: it uses one `msgraph_resource` data source and `terraform_data` gates, and sends no
Graph writes.

## Usage

Install a release using the [Terraform Registry instructions](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry); replace `<version>` with that release version.

```hcl
module "emergency_access_verify" {
  source  = "satolap/modules/msgraph//verified/security-baseline/emergency-access-guard/verify"
  version = "<version>"

  tier                = module.emergency_access.tier
  exclusions          = module.emergency_access.conditional_access_users_exclusions
  baseline_policy_ids = var.existing_baseline_policy_ids
  scope               = "baseline" # or "tenant"
  # Existing policies managed independently. If this root updates them, also add:
  # depends_on = [module.policy_writer]
}
```

Run it before the Conditional Access baseline's enforce apply, as an independent check. The
baseline does not take `verified` as an input.

## Checks

Each failure fails the plan, or the apply when the read is deferred, with a message that
uses masked stable policy/account labels and identifies the missing exclusion fields.

- Non-free baseline scope requires at least one `baseline_policy_ids` entry; an empty
  aggregation cannot report successful verification.
- Every ID in `baseline_policy_ids` exists in the tenant.
- Every baseline policy, whatever its `state`, lists all guard user IDs in
  `conditions.users.excludeUsers` and all guard group IDs in `conditions.users.excludeGroups`.
  Report-only policies need no exclusion according to Microsoft
  ([Conditional Access considerations](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/security-emergency-access#conditional-access-considerations)),
  but a baseline policy moves from report-only to enforced with one input change.
- With `scope = "tenant"`, every policy whose `state` is `enabled`, including
  [Microsoft-managed policies](https://learn.microsoft.com/en-us/entra/identity/conditional-access/managed-policies),
  meets the same rule. Report-only and disabled policies outside the baseline are not checked.
- `tier = "free"` with a non-empty `baseline_policy_ids` fails: the free tier keeps security
  defaults on and reads no policies.

Include lists apply unless a principal is explicitly excluded
([conditionalAccessUsers](https://learn.microsoft.com/en-us/graph/api/resources/conditionalaccessusers?view=graph-rest-1.0)),
so the check reads only the exclude lists.

## When the policies are read

The policy read depends on a `terraform_data` gate that holds the baseline policy IDs and the
exclusions. When either is unknown or changes, the gate has a planned change and Terraform
defers the read to apply. That local gate alone does not order a read after policy writers
elsewhere in the caller, especially when policy IDs are already known. A root that creates
or updates policies **must** add `depends_on = [module.policy_writer]` (or the concrete policy
resources) to its verifier module call. This dependency belongs on `verify`, not the initial
account guard. Supply policy IDs from the writer's outputs too; a constant ID list alone is
not an ordering guarantee.

For a root that manages a policy through `module.policy_writer`, use the writer's ID and
an explicit dependency together (the writer exports `id`):

```hcl
module "emergency_access_verify" {
  source  = "satolap/modules/msgraph//verified/security-baseline/emergency-access-guard/verify"
  version = "<version>"

  tier                = module.emergency_access.tier
  exclusions          = module.emergency_access.conditional_access_users_exclusions
  baseline_policy_ids = [module.policy_writer.id]
  depends_on          = [module.policy_writer]
}
```

With the explicit writer dependency, Terraform completes planned policy updates before the
read. When neither the writer nor the gate has changes, policies are read at plan time so
removed exclusions fail that plan. An independent read-only root can use existing policy IDs
as in the example, but it cannot sequence updates happening in another root or session.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.6.0, < 0.7.0 |

Terraform 1.11 or later is required, including for the offline mock suites.

| Call | Purpose | Least privileged (Learn) | Grant |
| --- | --- | --- | --- |
| `GET /identity/conditionalAccess/policies?$select=id,displayName,state,conditions` ([List policies](https://learn.microsoft.com/en-us/graph/api/conditionalaccessroot-list-policies?view=graph-rest-1.0)) | Read-back, `p1` and `p2` only | `Policy.Read.All` | `Policy.Read.All` |

`Policy.Read.ConditionalAccess` appears in the
[permissions reference](https://learn.microsoft.com/en-us/graph/permissions-reference), but
List policies does not list it, so the submodule does not rely on it. Delegated callers also
need a supported role, such as Security Reader, Global Reader or Conditional Access
Administrator. The `free` tier needs no permission.

## Limits

- The `msgraph_resource` data source follows `@odata.nextLink` on collection reads in provider
  version 0.6.0 according to source inspection. Missing paging exports and non-null remaining markers fail closed; real HTTP pagination and denied-read behavior remain tenant acceptance checks.
- Tenant scope with no baseline IDs and no enabled policies is allowed, but `verified` is
  false and `verified_policy_ids` is empty: no policy was proved. Free tier also returns false.
- The check reads `excludeUsers` and `excludeGroups` only. It does not evaluate roles, guests,
  applications or other conditions, and does not check that a policy grants what it should.
- User-exclusion validation covers only the checked population. Valid unrelated workload-identity
  policies are permitted in baseline scope. A checked policy without user conditions is
  explicitly refused as unsupported, including an enabled workload policy in tenant scope;
  its applicability requires a separate review. The Graph condition contract permits either
  [users or clientApplications](https://learn.microsoft.com/en-us/graph/api/resources/conditionalaccessconditionset?view=graph-rest-1.0).
- Every returned policy still needs a valid ID and recognized state; unknown states and
  missing exports fail closed. Checked user exclusion lists need non-null string elements.
- `verified_policy_ids` and gate inputs are sensitive. State and saved plans retain private
  policy data. Masked errors do not guarantee that provider diagnostics or debug logs redact it.
- No read-back result proves credential custody, role assignment, MFA, alerting or effective
  sign-in access. Independent emergency-login acceptance remains outstanding.
- Only offline mocked tests cover the module; tenant acceptance remains outstanding. No fixture, grant or live workflow is created by this change.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- The submodule only reads Conditional Access policies, and nothing for the free tier, and uses no premium feature itself. The Conditional Access baseline whose policies it reads must separately declare the Conditional Access feature requirement when implemented.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| tier | `free`, `p1` or `p2` | `string` | n/a | yes | no object change (validation or timing only) |
| exclusions | The guard's `conditional_access_users_exclusions` output | `object({ excludeUsers = set(string), excludeGroups = set(string) })` | n/a | yes | no object change (validation or timing only) |
| baseline_policy_ids | IDs of the Conditional Access baseline policies | `set(string)` | n/a | yes | no object change (validation or timing only) |
| scope | `baseline`, or `tenant` to also check every enabled policy | `string` | `"baseline"` | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| verified | True when at least one policy was checked and all exclusions passed; false for `free` or an empty tenant-scope population | no |
| verified_policy_ids | IDs of the checked policies: the baseline policies, plus every enabled policy in `tenant` scope | no |
