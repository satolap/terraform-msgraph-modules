# identity-governance/entitlement-management/catalogs/custom-extensions

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified live-accepted** (2026-10-25, commit `9c5263bf`). Acceptance covers the recorded run and configuration.

![live Dev: passed 2026-10-25](https://img.shields.io/badge/live%20Dev-passed%202026--10--25-brightgreen)
<!-- live-status:end -->

Manages one Microsoft Entra ID Governance entitlement management **custom workflow
extension** in a catalog
(`identityGovernance/entitlementManagement/catalogs/{catalog}/customWorkflowExtensions`) via
the `microsoft/msgraph` Terraform provider. The extension calls an existing Azure Logic App.
An assignment policy then runs it at the stages you choose. The folder mirrors the Graph
collection it manages.

One module covers both extension types. `extension_type` selects the concrete type:

| `extension_type` | `@odata.type` | Policy stages it can serve |
| --- | --- | --- |
| `request_workflow` | `accessPackageAssignmentRequestWorkflowExtension` | `assignmentRequestCreated`, `assignmentRequestApproved`, `assignmentRequestGranted`, `assignmentRequestRemoved` |
| `assignment_workflow` | `accessPackageAssignmentWorkflowExtension` | `assignmentFourteenDaysBeforeExpiration`, `assignmentOneDayBeforeExpiration` |

What the module manages, and what it does not:

- **The Logic App is an input, not a resource.** `logic_app` names an existing Consumption
  Logic App. The module creates no Azure resource and has no `azurerm` dependency.
- **Proof-of-possession authentication only.** The module always sends
  `azureAdPopTokenAuthentication`, the form that Microsoft Entra ID Governance uses by default
  since general availability. Bearer-token extensions are not supported.
- **Launch and continue only.** The module sends no callback configuration, so it cannot
  create a launch and wait extension. Launch and wait is planned for a later release.
- **Every managed key is in the body,** on create and on update: type, display name,
  description, endpoint configuration and authentication. Microsoft Learn documents `PUT` as
  the only way to update the item, and says that properties the body omits keep their previous
  values, so the module sends `description` as `null` rather than leaving it out.
- **The type and the catalog cannot change in place.** Changing `extension_type` or
  `catalog_id` replaces the extension, and the new one is created before the old one is
  deleted. The module uses the catalog id in lower case, so a change of its case alone
  replaces nothing and plans no change.
- **What it cannot manage is reported.** The `unmanaged_properties` check warns when Microsoft
  Graph returns a callback configuration, a client configuration, a behavior-on-error setting
  or an authentication type other than proof of possession, because an update keeps them.
- v1.0 only. There is no `api_version` input.

## When to use this module instead of a generated one

As published when this module was written, the generated modules for the same collection
(under `modules/generated/v1.0`) update with `PATCH`, which Microsoft Learn does not
document for this item; take the endpoint and authentication as untyped values; and
require the caller to name the concrete `@odata.type` (the base type is abstract). Prefer
this module: its inputs are typed, it updates with `PUT`, and it replaces the extension
when the type or catalog changes.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "grant_notice" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/catalogs/custom-extensions"
  version = "<version>"

  catalog_id     = module.engineering_catalog.id
  extension_type = "request_workflow"

  logic_app = {
    subscription_id     = var.logic_app_subscription_id
    resource_group_name = "rg-access-automation"
    workflow_name       = "notify-owner"
    # trigger_url = var.logic_app_trigger_url # needed when an application, not a user, runs Terraform
  }
}
```

`binding` holds the extension id and type in the shape of one element of the
`custom_extension_stage_settings` input of the assignment policy module, without the stage.
Add the stage with `merge`:

```hcl
module "engineering_policy" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/assignment-policies"
  version = "<version>"

  # ... the other policy inputs ...

  custom_extension_stage_settings = [
    merge(module.grant_notice.binding, { stage = "assignmentRequestGranted" }),
  ]
}
```

With the values above the `merge` yields
`{ extension_id = "<extension id>", extension_type = "request_workflow", stage = "assignmentRequestGranted" }`.
One extension can serve several stages of the same type. A policy can use only the extensions
of its own catalog.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.3.0 |

Terraform 1.5 is the first version with `check` blocks. The module and its offline test suite need
Terraform 1.11 or later. The module sets minimum versions only; set upper bounds in your root module.

| Operation | Least privileged application permission | Least privileged delegated roles |
| --- | --- | --- |
| [Create](https://learn.microsoft.com/en-us/graph/api/accesspackagecatalog-post-accesspackagecustomworkflowextensions?view=graph-rest-1.0) | `EntitlementManagement.ReadWrite.All` | Catalog owner or Identity Governance Administrator, and an Azure role on the Logic App |
| Update ([request workflow](https://learn.microsoft.com/en-us/graph/api/accesspackageassignmentrequestworkflowextension-update?view=graph-rest-1.0), [assignment workflow](https://learn.microsoft.com/en-us/graph/api/accesspackageassignmentworkflowextension-update?view=graph-rest-1.0)) | `EntitlementManagement.ReadWrite.All` | Catalog owner or Identity Governance Administrator, and an Azure role on the Logic App |
| Delete ([request workflow](https://learn.microsoft.com/en-us/graph/api/accesspackageassignmentrequestworkflowextension-delete?view=graph-rest-1.0), [assignment workflow](https://learn.microsoft.com/en-us/graph/api/accesspackageassignmentworkflowextension-delete?view=graph-rest-1.0)) | `EntitlementManagement.ReadWrite.All` | Catalog owner or Identity Governance Administrator, and an Azure role on the Logic App |
| Read, to refresh ([request workflow](https://learn.microsoft.com/en-us/graph/api/accesspackageassignmentrequestworkflowextension-get?view=graph-rest-1.0), [assignment workflow](https://learn.microsoft.com/en-us/graph/api/accesspackageassignmentworkflowextension-get?view=graph-rest-1.0)) and [list](https://learn.microsoft.com/en-us/graph/api/accesspackagecatalog-list-accesspackagecustomworkflowextensions?view=graph-rest-1.0) | `EntitlementManagement.Read.All` | Catalog reader |

- The update, delete and get pages of the two extension types list the same permissions. The
  create and list pages are shared by both types.
- The Azure role is Logic App Contributor, Contributor or Owner, on the Logic App or a higher
  scope. Microsoft Learn lists it for delegated callers on every write operation. For an
  application, Learn says the app can hold one of the catalog or Entra roles instead of the
  application permission, and that `logic_app.trigger_url` is needed when it creates the
  extension; whether an application also needs an Azure role on the Logic App is not
  documented.
- Binding the extension to a policy is an update of the policy, not of the extension: Access
  package manager is the least privileged catalog role for it, then Catalog owner.
- Run Terraform for this module as a dedicated automation identity that holds only the catalog
  roles it needs, rather than a tenant-wide permission.
- The module lists the catalog's extensions on every plan. A missing read permission (401 or
  403) fails the plan; it is not read as "no extensions".
- Only Microsoft Graph v1.0 is supported.

## Prerequisites outside this module

The Logic App must exist before the extension is created, and the module does not create it:

- A Consumption Logic App. Microsoft Learn describes the feature for consumption plan Logic
  Apps; Standard Logic Apps are not supported until proven.
- An HTTP request trigger.
- An authorization policy that accepts the proof-of-possession token that Microsoft Entra ID
  Governance sends. Learn says calls from Microsoft Entra ID Governance to a Logic App are
  authorized with the Microsoft Entra ID access token scheme, recommends disabling shared
  access signatures, and describes the claims to check in
  [Best practices for securing the custom extension extensibility to Azure Logic Apps](https://learn.microsoft.com/en-us/entra/id-governance/custom-extension-security).
  **Graph checks it when the extension is created** (live, 2026-10-25): it calls the Logic
  App, and without such a policy the create fails with `400 WorkFlowExtensionValidationError`
  whose inner error is `OAuthAccessPolicyNotFound` ("The OAuth authentication policy is not
  enabled for the workflow"). The policy that worked is of type `AADPOP` with the claims
  `iss` = `https://sts.windows.net/<tenant-id>/` (with the trailing slash), `aud` =
  `https://management.azure.com`, `appid` = the application ID of the tenant's
  "Azure AD Identity Governance - Entitlement Management" service principal, `m` = `POST`,
  `u` = `management.azure.com` and `p` = the Logic App's resource ID path. A Logic App created
  from the admin center gets this policy automatically.

## Policy stages, expiry and guests

- The request stages (`assignmentRequestCreated`, `assignmentRequestApproved`,
  `assignmentRequestGranted`, `assignmentRequestRemoved`) need a `request_workflow`
  extension. The expiration stages (`assignmentFourteenDaysBeforeExpiration`,
  `assignmentOneDayBeforeExpiration`) need an `assignment_workflow` extension.
- The expiration stages run only for assignments that expire automatically: Learn describes
  them as "14 days before an access package assignment auto expires".
- Custom extensions need Microsoft Entra ID Governance or Microsoft Entra Suite.
- **Guests.** A policy with guests or external users in scope that uses a custom extension
  needs the tenant linked to an Azure subscription for the Microsoft Entra ID Governance for
  guests add-on, and Learn lists Guest policy assigned with custom extension as billed on each
  successful request creation, counted as monthly active users. Without the link, Learn says
  such a policy cannot be created and an existing policy cannot be updated to add the
  extension ([licensing for guest users](https://learn.microsoft.com/en-us/entra/id-governance/microsoft-entra-id-governance-licensing-for-guest-users)).
  The extension itself targets nobody; these rules apply to the policies that bind it.

## Limits and lifecycle

- **Same Terraform state.** Keep the extension and every policy that binds it in one Terraform
  state. Only then can Terraform order a policy change and the replacement or deletion of the
  extension. Across states nothing orders the two.
- **Destroy order.** Microsoft Graph deletes an extension only after it is removed from every
  policy. Destroying the policy together with the extension is ordered by the policy's
  reference to `binding`. To drop a binding and its extension, apply twice: remove the
  binding from the policy and apply, then remove the extension and apply. The order that
  Terraform takes when one apply does both is not verified. Delete the Logic App after the
  extension, not before.
- **A replacement changes the id.** Changing `extension_type` or `catalog_id` creates the new
  extension first, then deletes the old one, and the policies that bind it are updated with the
  new id in the same apply when they are in the same state. The replacement is created from the
  configuration only, so a callback or client configuration set outside Terraform is lost.
  `catalog_id` is part of the replacement trigger because the provider would otherwise send
  the update to the catalog in the stored resource URL.
- **An update keeps what its body omits.** The `unmanaged_properties` check lists the
  properties this module does not manage that Graph returned set: `callbackConfiguration`,
  `clientConfiguration`, `behaviorOnError` and an authentication type other than proof of
  possession. The plan or apply still succeeds. On a plan that creates, updates or replaces
  the extension the read-back is not known yet, and Terraform warns that the result is known
  after apply instead. Whether Graph returns a non-null `clientConfiguration` or
  `callbackConfiguration` by default is not verified; if it does, the check warns on every
  read.
- **Changing the Logic App.** `logic_app` is part of the update body, so the Logic App can
  change in place. Removing `trigger_url` sends an endpoint configuration without `url`;
  whether Graph then keeps the stored url or computes a new one is not verified. Change
  `logic_app` and `trigger_url` together.
- **Warnings, not failures.** `unique_display_name` warns when another extension of the same
  type in the catalog has the same display name; Learn does not say whether names must be
  unique. It compares only the same type, so replacing the type does not warn. A replacement
  of the same type (`terraform apply -replace`) warns after that apply, because the listing
  that the plan read still holds the old extension.
  `logic_app_id_length` warns when the Logic App resource ID is longer than 150 characters;
  Learn states that limit for a Logic App created in the admin center and does not say whether
  it applies to an existing one. Graph accepted an existing Logic App with a 151-character
  resource ID (live, 2026-10-25), so the warning is cautious; as a failed `check` it still
  fails a `terraform test` run.
- **Naming.** `name_pattern` is a regular expression (RE2 syntax, unanchored) that the
  effective display name must match, or the plan fails. It applies to the default display name
  too.
- **No secret in the state.** `trigger_url` must not carry a shared access signature; the
  `sig`, `sp` and `sv` query parameters are rejected. The URL itself is stored in the state and
  appears in plan output, and the module never outputs it.
- **Tests that call this module.** In `terraform test`, a run with `command = plan` that
  creates, updates or replaces the extension through this module fails with "Check block
  assertion known after apply", and a calling test cannot name a check inside a module in
  `expect_failures`. Use `command = apply` for such runs.
- **Import is not verified.** The resource ID format follows the provider's documentation:
  `terraform import 'module.<name>.msgraph_resource.this' /identityGovernance/entitlementManagement/catalogs/<catalog-id>/customWorkflowExtensions/<extension-id>`.
  The module also creates `terraform_data.identity`, which has no counterpart to import. If the
  first plan after an import shows the extension replaced, do not apply it: the replacement
  creates a new extension with a new id and drops properties set outside Terraform.
- **Empty policy stage settings.** Learn says an update of a policy with an empty
  `customExtensionStageSettings` removes the stage settings "and their associated custom
  workflow extension objects". Whether that deletes the catalog extension is not verified. If it
  does, the next plan of this module shows the extension as gone and recreates it.

## Live test status

Live test status: partly verified in a licensed tenant (Dev, 2026-10-25). As an application
with `EntitlementManagement.ReadWrite.All`, the live suite created a request workflow extension
with `trigger_url` against a Logic App that has the policy above, updated its description in
place (the id stayed) and replaced it by changing the type (a new id). The governance identity
held only a narrow custom role on the Logic App's resource group (workflow read and write, no
callback URL listing); whether Graph needs any Azure role from the caller was not isolated.
These checks are still pending:

1. Create both extension types as an application, with and without `trigger_url`, and read the
   `url` that Graph returns (a rewritten url would show as drift). Record whether create
   validates the Logic App, the trigger and the authorization policy.
2. Update with a full-body `PUT`: whether Graph accepts a `null` description, and whether the
   next plan is empty with `ignore_missing_property = false` (nested `@odata.type`, a null
   description and the url are the candidates for a permanent diff).
3. Whether Graph returns a non-null `clientConfiguration` or a non-null `callbackConfiguration`
   by default for a launch and continue extension (the Learn list example shows a request
   workflow extension with a `callbackConfiguration`). If it does, the `unmanaged_properties`
   check warns on every read.
4. Replace the extension while policies bind it, and the behaviour when two extensions of the
   same type share a name.
5. Delete an extension that a policy still binds: the error, and the order Terraform takes
   when the binding and the extension are removed in one apply.
6. Whether an empty `customExtensionStageSettings` on a policy deletes the catalog extension.
7. The permissions an application needs on the Logic App, and the 403 behaviour under the
   least privileged catalog roles.
8. Import: the resource ID format and the first plan after an import.
9. The case of GUIDs in the response, which would show as drift if it differs from the input.
10. End to end: the Logic App is called with a proof-of-possession token and the authorization
    policy accepts it.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-ADVANCED | Automatic assignment through attribute rules, custom extensions and some advanced approval options require Microsoft Entra ID Governance or Microsoft Entra Suite. Microsoft Entra ID P2 alone is not sufficient. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user eligible under the policy that enables the advanced feature | group_based / per_user | documented |

Notes:

- Azure Logic Apps are billed separately by Azure; the module references an existing Logic App and that billing is not modelled here.
- A policy with guests or external users in scope that uses a custom extension needs the tenant linked to an Azure subscription for the Microsoft Entra ID Governance for guests add-on; without the link such a policy cannot be created, and an existing policy cannot be updated to add the extension. Guest policy assigned with custom extension is billed on each successful request creation, counted as monthly active users, to the linked subscription. This module creates the extension only; the guest rules apply to the policies that bind it. See [Microsoft Entra ID Governance licensing for guest users](https://learn.microsoft.com/en-us/entra/id-governance/microsoft-entra-id-governance-licensing-for-guest-users).
- The Logic App integration, including the custom extension types and the stages they serve, is described in [Trigger Logic Apps with custom extensions in entitlement management](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-logic-apps-integration).
- The custom extension rules were reviewed against Microsoft Learn on 2026-10-01, which is later than the review date stated above.

Sources: [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| catalog_id | ID of the catalog that holds the extension; a change replaces the extension, a change of case alone does not | `string` | n/a | yes | replaces `msgraph_resource.this` when its effect on `local.catalog_id` changes; not replaced or moved: the update targets the existing object; recreate it to move it |
| extension_type | `request_workflow` or `assignment_workflow`; a change replaces the extension | `string` | n/a | yes | replaces `msgraph_resource.this` |
| logic_app | The existing Consumption Logic App: `subscription_id`, `resource_group_name`, `workflow_name` and optionally `trigger_url` (https, contains `/triggers/`, no `sig`, `sp` or `sv` parameter) | `object` | n/a | yes | in place |
| display_name | Display name; null uses `logic_app.workflow_name` | `string` | `null` | no | in place |
| description | Description; always sent, as `null` when unset | `string` | `null` | no | in place |
| name_pattern | Regular expression that the effective display name must match, or the plan fails | `string` | `null` | no | no object change (validation or timing only) |
| timeouts | `create`, `read`, `update` and `delete` timeouts, such as `30m`; create, update and delete at least `15s`; retries count against them | `object` | `{}` (`10m` for create, update and delete; the provider default for read) | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The ID of the extension; it changes when `extension_type` or `catalog_id` changes | yes |
| catalog_id | The ID of the catalog that holds the extension, in lower case | yes |
| extension_type | `request_workflow` or `assignment_workflow` | yes |
| odata_type | The concrete `@odata.type` of the extension | yes |
| display_name | The effective display name | yes |
| logic_app_resource_id | The Azure resource ID of the Logic App; the trigger URL is never an output | yes |
| binding | `{ extension_id, extension_type }`, to merge with a `stage` into a policy's `custom_extension_stage_settings` | yes |

## Tests

`tests/custom_extension.tftest.hcl` runs offline against a mock provider and needs Terraform
1.11 or later: `terraform init` and `terraform test` in this folder. It covers both body
shapes, the request, update method and drift settings, the replacement of the extension when
the type or catalog changes, the description sent as `null`, the outputs and the `binding`
merge, each check, `name_pattern`, and every validation. A mock provider evaluates none of the
read-back expressions, so a Python test (`tests/test_custom_extensions.py`) ties them to the
mapping that consumes them and checks the validation messages. The live suite in
`tests/integration` runs in a licensed tenant; see [Live test status](#live-test-status). Its
`callback_probe.tftest.hcl` creates a launch and wait extension directly, with the duration
named `durationBeforeTimeout` as in Learn's entitlement management examples, and reads it
back: it settles which name Graph keeps before this module sends a callback.
