# Application federated identity credentials

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: not yet run](https://img.shields.io/badge/live-not%20yet%20run-lightgrey)
<!-- live-status:end -->

Manage one federated identity credential on an **existing application object** at
`POST /applications/{id}/federatedIdentityCredentials` (v1.0), equivalent to
`azuread_application_federated_identity_credential`. The module creates no application,
service principal, role assignment or external identity provider. It establishes a trust:
a matching external workload token can authenticate as the application, with that
application's independently granted permissions. Review the issuer and exact subject.

Protect trust subjects in state and plans as described in the
[state and plan protection guide](../../../../docs/scenarios/state-protection.md).

For a published release containing this module, replace `<version>` with that release
version. Source-tree availability does not establish publication. See the
[terraform-msgraph-modules installation guide](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry).

```hcl
module "github_main" {
  source  = "satolap/modules/msgraph//verified/applications/federatedIdentityCredentials"
  version = "<version>"

  application_id = module.application.id # object ID, not application/client appId
  name           = "github-main"
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:example-org/example-repo:ref:refs/heads/main"
  description    = "GitHub Actions main branch"
  # audiences defaults to ["api://AzureADTokenExchange"]
}
```

## Common workload subjects

These are literal-subject configuration examples, not token-exchange verification.
Confirm the actual token's `iss`, `sub` and `aud` before deployment; customized GitHub
subject templates can differ. The module preserves case, whitespace and trailing slashes
rather than silently changing a trust boundary. GitHub Actions also needs permission to
request an OIDC token (`id-token: write`) in the consuming workflow.

> [!WARNING]
> **Use the GitHub `pull_request` subject only for low-privilege applications.**
> It matches any PR-triggered run in the repository, without distinguishing the
> contributor or source branch. Treat anyone who can open a PR as potentially able
> to run workflow code that obtains a token with the application's permissions.
> For privileged applications, use an **environment subject with required reviewers**
> or a **protected-branch subject**, and enforce those protections in GitHub.
> This module does not configure reviewers, branch protection or workflow permissions.

| Workload | issuer | subject example |
| --- | --- | --- |
| GitHub branch | `https://token.actions.githubusercontent.com` | `repo:example-org/example-repo:ref:refs/heads/main` |
| GitHub environment | `https://token.actions.githubusercontent.com` | `repo:example-org/example-repo:environment:production` |
| GitHub pull request (low privilege only) | `https://token.actions.githubusercontent.com` | `repo:example-org/example-repo:pull_request` |
| Kubernetes service account | Cluster's exact OIDC issuer URL | `system:serviceaccount:example-namespace:example-service-account` |

For Kubernetes, supply the issuer configured by the cluster (including a trailing slash
if the token has one), configure the service account and workload identity integration
separately, and project a service-account token with the configured audience. This module
does not configure a cluster or service account. Subjects are exact strings: a literal
`*` does not enable wildcard matching in this v1.0 module.

## Contract and validation

The contract follows Microsoft Learn's
[resource](https://learn.microsoft.com/en-us/graph/api/resources/federatedidentitycredential?view=graph-rest-1.0),
[create](https://learn.microsoft.com/en-us/graph/api/federatedidentitycredential-post?view=graph-rest-1.0),
[read](https://learn.microsoft.com/en-us/graph/api/federatedidentitycredential-get?view=graph-rest-1.0),
[update](https://learn.microsoft.com/en-us/graph/api/federatedidentitycredential-update?view=graph-rest-1.0)
and [delete](https://learn.microsoft.com/en-us/graph/api/federatedidentitycredential-delete?view=graph-rest-1.0)
pages, pinned to documentation revision `4ad99fd37a9e2e8538275a0a9cdff7907052f3ec`.
Offline contract tests bind the configuration to those pinned bytes; live behavior
remains subject to the acceptance runbook below.

- **Name:** Learn requires a unique, immutable, URL-friendly name with a maximum of
  120 characters. The pinned Graph pages do not enumerate the character set or a
  minimum length. **This module's conservative subset** is 3 to 120 ASCII letters,
  digits, hyphens and underscores, starting with a letter or digit. This deliberately
  narrower module policy is not presented as an exhaustive Graph rule.
- **Issuer:** at most 600 characters. Graph requires the external identity provider URL
  to match the token's issuer. This module conservatively accepts absolute HTTPS URLs
  with a DNS/IPv4 host, optional port and path, and rejects userinfo, query, fragment,
  whitespace and backslashes. IPv6 and other URL forms are outside this module's
  validation contract. URL shape validation does not prove discovery, keys or reachability.
- **Subject:** nonempty text, at most 600 characters; the issuer/subject pair must be
  unique within the application. There is no cross-state uniqueness lookup.
- **Audiences:** exactly one non-null, nonempty string, at most 600 characters;
  default `["api://AzureADTokenExchange"]` follows Learn's Entra recommendation.
- **Description:** optional, at most 600 characters. Null omits it. Changing an existing
  description back to null does not clear it through the provider's diff-based PATCH.
- **Limit:** Learn states a maximum of **20 federated identity credentials per
  application**, across all owners and Terraform states. This single-credential module
  does not count siblings or reserve capacity; Graph enforces the application-wide limit.

## Lifecycle and ownership

This is an ordinary `msgraph_resource` child with item GET, PATCH and DELETE, rather than
a one-shot request/action. Creation POST is never used for an in-place update. `issuer`,
`subject`, `audiences` and a non-null `description` update with PATCH and retain the
credential ID. Changing `name` or the normalized `application_id` explicitly replaces
the credential through `terraform_data.immutable`; a case-only application GUID change
does nothing. Identity names and external claims are never lower-cased.

By default, replacement deletes the old credential **before** creating the new one. Creating first
could collide with the unique name or issuer/subject pair, or exceed the 20-object limit.
**A dependent resource that consumes this module's `id` and sets
`create_before_destroy = true` propagates create-first ordering to this credential too.**
Keep resources in that dependency chain destroy-first to avoid those Graph failures.
If create-first has already propagated into state, stage the dependent's removal and
recreation in separate applies before replacing the credential, and inspect the plan's
ordering; setting `create_before_destroy = false` on the credential cannot override it.
Expect an authentication interruption: existing external workloads can no longer exchange
tokens under the removed trust. Replacement produces a new credential ID and does not
revoke access tokens already issued by Entra.

Destroy uses the provider's stored child GUID at
`DELETE /applications/{application-object-id}/federatedIdentityCredentials/{credential-id}`.
It does not delete the application, list or replace the credential collection, use a
name-based upsert, or delete sibling credentials. Passing `module.application.id` orders
credential deletion before application deletion. A postcondition verifies that Graph's
returned GUID matches the provider's stored ID and that the returned immutable name
matches the configuration. Missing or conflicting evidence fails closed rather than
silently adopting another identity. These are response checks after a provider operation,
not pre-write or destroy-time ownership barriers; the delete route relies on the recorded
resource identity. Import, adoption, manually edited state and migration from another
provider are unsupported. Never share ownership of the same credential across states.

`terraform_data.immutable` makes no network request. Its first creation does not replace
an existing resource: recovery that drops this helper requires an unchanged-input apply
before relying on its replacement behavior. Normal refresh reconciles managed properties;
the module sets `ignore_missing_property = false`. The immutable name is ignored for
PATCH and checked in read-back. No custom retry expression or broad cleanup script runs.

This API takes no password, client secret or private key and outputs no token. Issuer,
subject, audience, description and identifiers live in Terraform plans and state; avoid
putting secrets in them and protect the state backend. No credential material is generated.

## Flexible credentials follow-up (#381)

The pinned beta resource, expression, create and update pages describe
`claimsMatchingExpression = { languageVersion = 1, value = ... }`, mutually exclusive
with `subject`. They delegate the supported restricted expression grammar and claims to
an external Flexible FIC reference that is absent from the permitted pinned documentation.
Switching an existing trust between subject and expression also requires a reliable
null-clear contract that the provider's diff-based PATCH does not establish. Beta support
is therefore deferred under #381: pin that grammar and supported issuers, validate it,
and prove mode transitions/read-back before adding a separate reviewed beta interface.
This module fixes `api_version = "v1.0"` and exposes no expression input.

## Requirements

| Name | Version |
| --- | --- |
| Terraform configuration and mocked tests | >= 1.11.0 |
| microsoft/msgraph | >= 0.6.0, < 0.7.0 |

The offline provider baseline is 0.6.0. A caller must maintain its own provider lock file.
Pinned permission tables list `Application.ReadWrite.OwnedBy` for application access
(higher: `Application.ReadWrite.All`) and `Application.ReadWrite.All` for delegated
access for create, item read, update and delete. The application identity must own the
target application when using OwnedBy. For delegated work/school access the pinned RBAC
include permits a non-admin member or Application Developer for applications they own,
Cloud Application Administrator, Application Administrator, or an appropriately authorized
custom role. These are authorization requirements, not permission grants made by this module.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- The pinned federatedIdentityCredential create/read/update/delete pages state no premium license prerequisite. DIRECTORY-BASIC is applied by inference for the application credential configuration only; a successful token exchange does not establish entitlement for the workload or target API. See [Create federatedIdentityCredential](https://learn.microsoft.com/en-us/graph/api/federatedidentitycredential-post?view=graph-rest-1.0).
- This module creates a trust record, no application, service principal, role assignment or external identity provider. Evaluate downstream Microsoft or third-party services, premium workload-identity protections and external platform charges separately. Live lifecycle and token exchange remain unverified.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | On change |
| --- | --- | --- | --- | --- |
| application_id | Existing application object GUID, normalized to lower case | `string` | required | replaces `msgraph_resource.credential` |
| name | Unique immutable credential name within the documented module subset | `string` | required | replaces `msgraph_resource.credential` |
| issuer | Exact trusted issuer HTTPS URL, at most 600 characters | `string` | required | in place |
| subject | Exact external token subject, 1 to 600 characters | `string` | required | in place |
| audiences | Exactly one audience, at most 600 characters | `list(string)` | `["api://AzureADTokenExchange"]` | in place |
| description | Administrative description; null omits without clearing | `string` | `null` | in place |

## Outputs

| Name | Description | Known in plan after an update |
| --- | --- | --- |
| id | This credential's object ID | yes |
| application_id | Lower-case application object ID | yes |
| name | Immutable credential name as configured | yes |

## Live status and acceptance runbook

Offline mocks and contract tests verify request construction, guards and state transitions.
They do not prove Graph HTTP behavior, authorization, propagation, token exchange or cleanup.
No live acceptance has run. The owner must dispatch the following in an isolated sandbox,
keeping identifiers, tokens and raw responses outside this repository:

The pinned item GET example wraps the object in `value`, while the create response is
an unwrapped entity. This documentation discrepancy is unverified. The module expects
ordinary entity `id`/`name` read-back and refuses missing or wrapped identity evidence;
the live probe must establish the actual response shape before acceptance.

1. Create a disposable application with an owned automation identity and a separate sibling
   credential as a preservation control. Record sibling IDs outside the repository.
2. Apply one GitHub branch or Kubernetes credential, independently GET the exact created ID,
   compare all claims/name/description, and verify a subsequent plan is empty on both
   Terraform 1.11.4 and 1.16.2 with the approved locked provider.
3. Obtain a token from the intended external workload; verify successful exchange for the
   configured subject/audience and refusal for a different branch/environment/service
   account or audience. Record propagation delay and permission requirements without tokens.
4. Change description, subject, issuer and the single audience in controlled valid steps;
   verify PATCH retains the credential ID, independently read back each value and obtain
   an empty plan. Check the documented null-description omission without claiming clearing.
5. Change application GUID letter case only and confirm no changes. Rename the credential,
   then move it to a second disposable application; verify each is destroy-first replacement
   with a new ID, old item absence and both applications' sibling credentials preserved.
6. Destroy the module. Verify item GET returns 404, the application and sibling remain,
   and the removed trust cannot exchange a newly issued external token after propagation.
   Remove the separately created sibling controls and disposable applications explicitly.
   Retain sanitized acceptance results and a run link in the deployment's operator documentation.

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `application_id`: replaces `msgraph_resource.credential`.
- `name`: replaces `msgraph_resource.credential`.
- `issuer`: in place.
- `subject`: in place.
- `audiences`: in place.
- `description`: in place.
<!-- drift:end -->
