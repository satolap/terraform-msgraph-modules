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

| `extension_type` | `@odata.type` | Policy stages it can serve | Launch and wait |
| --- | --- | --- | --- |
| `request_workflow` | `accessPackageAssignmentRequestWorkflowExtension` | `assignmentRequestCreated`, `assignmentRequestApproved`, `assignmentRequestGranted`, `assignmentRequestRemoved` | Supported (`callback`) |
| `assignment_workflow` | `accessPackageAssignmentWorkflowExtension` | `assignmentFourteenDaysBeforeExpiration`, `assignmentOneDayBeforeExpiration` | Not supported; the plan fails when `callback` is set |

What the module manages, and what it does not:

- **The Logic App is an input, not a resource.** `logic_app` names an existing Consumption
  Logic App. The module creates no Azure resource and has no `azurerm` dependency.
- **Proof-of-possession authentication only.** The module always sends
  `azureAdPopTokenAuthentication`, the form that Microsoft Entra ID Governance uses by default
  since general availability. Bearer-token extensions are not supported.
- **Launch and continue, or launch and wait.** Without `callback` the extension is launch and
  continue: entitlement management calls the Logic App and goes on. With
  `callback = { timeout = "PT1H" }` it is launch and wait: entitlement management pauses the
  request until the resume action is called on it. See [Launch and wait](#launch-and-wait).
  The module sends only the base callback type; the approval stage callback that lets a Logic
  App return the approval stages of a request is not supported.
- **Every managed key is in the body,** on create and on update: type, display name,
  description, endpoint configuration and authentication, and the callback configuration
  while `callback` is set. Microsoft Learn documents `PUT` as the only way to update the item,
  and says that properties the body omits keep their previous values, so the module sends
  `description` as `null` rather than leaving it out. The callback configuration is the
  exception: without `callback` it is left out, so a caller that does not set `callback` sends
  the same body as before the input existed, and removing `callback` does not remove the
  callback from the extension (see [Switching between the modes](#switching-between-the-modes)).
- **The type and the catalog cannot change in place.** Changing `extension_type` or
  `catalog_id` replaces the extension, and the new one is created before the old one is
  deleted. The module uses the catalog id in lower case, so a change of its case alone
  replaces nothing and plans no change.
- **What it cannot manage is reported.** The `unmanaged_properties` check warns when Microsoft
  Graph returns a client configuration, a behavior-on-error setting or an authentication type
  other than proof of possession, and, while `callback` is null, a callback configuration,
  because an update keeps them.
- v1.0 only. There is no `api_version` input.

## When to use this module instead of a generated one

As published when this module was written, the
[generated module for the same collection](https://github.com/satolap/terraform-msgraph-modules/tree/main/v1.0/identity-and-access/identity-governance/entitlement-management/catalogs/by-access-package-catalog-id/custom-workflow-extensions)
updates with `PATCH`, which Microsoft Learn does not document for this item; takes the
endpoint and authentication as untyped values; and requires the caller to name the
concrete `@odata.type` (the base type is abstract). Prefer
this module: its inputs are typed, it updates with `PUT`, and it replaces the extension
when the type or catalog changes.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

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

A launch and wait extension sets `callback`. It is bound like any other request workflow
extension; `binding` does not change:

```hcl
module "provisioning_gate" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/catalogs/custom-extensions"
  version = "<version>"

  catalog_id     = module.engineering_catalog.id
  extension_type = "request_workflow"
  display_name   = "Provision external account"

  logic_app = {
    subscription_id     = var.logic_app_subscription_id
    resource_group_name = "rg-access-automation"
    workflow_name       = "provision-external-account"
  }

  # Pause each bound stage until the Logic App calls resume, for at most one hour.
  callback = { timeout = "PT1H" }
}
```

Bind it with `merge(module.provisioning_gate.binding, { stage = "assignmentRequestGranted" })`,
and with a second element for `assignmentRequestRemoved` when the Logic App also has to finish
before access is removed. `launch_and_wait` is `true` for this extension.

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
- `callback` needs no other permission for Terraform: the callback configuration is part of
  the create and update requests above. The identity that resumes a waiting request is the
  Logic App's, not Terraform's; see [Launch and wait](#launch-and-wait).
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

## Launch and wait

With `callback` set the module sends a callback configuration with the extension:

```json
"callbackConfiguration": {
  "timeoutDuration": "PT1H"
}
```

What Microsoft Learn documents, and what the module does with it:

- **Which extensions and stages.** The request workflow type supports launch and wait, and the
  pre-expiration type does not
  ([Trigger Logic Apps with custom extensions](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-logic-apps-integration#create-and-add-a-logic-app-workflow-to-a-catalog-for-use-in-entitlement-management)).
  The create request documents `callbackConfiguration` for
  `accessPackageAssignmentRequestWorkflowExtension` only
  ([Create accessPackageCustomWorkflowExtension](https://learn.microsoft.com/en-us/graph/api/accesspackagecatalog-post-accesspackagecustomworkflowextensions?view=graph-rest-1.0)).
  The module therefore fails the plan when `callback` is set with
  `extension_type = "assignment_workflow"`. A resume can be sent for all four request stages,
  `assignmentRequestCreated`, `assignmentRequestApproved`, `assignmentRequestGranted` and
  `assignmentRequestRemoved`
  ([resume](https://learn.microsoft.com/en-us/graph/api/accesspackageassignmentrequest-resume?view=graph-rest-1.0)),
  so Learn limits no request stage to launch and continue, and the assignment policy module
  needs no rule of its own: it already binds request stages to request workflow extensions
  only. Launch and wait is a setting of the extension; a policy stage setting holds only the
  stage and the extension, so each stage bound to a launch and wait extension is expected to
  wait. That every stage waits, `assignmentRequestRemoved` included, is not verified.
- **Timeout.** Learn gives the valid range for entitlement management as 5 minutes to 14 days,
  in ISO 8601, with `PT3H`, `P3D` and `PT10M` as examples
  ([customExtensionCallbackConfiguration](https://learn.microsoft.com/en-us/graph/api/resources/customextensioncallbackconfiguration?view=graph-rest-1.0)),
  and the entitlement management article notes it in minutes, hours or days. The module
  accepts whole days, hours and minutes from `PT5M` to `P14D`, in normal form (`PT1H30M`, not
  `PT90M`), so that a duration that Graph returns in normal form does not show as drift;
  whether Graph normalizes it is not verified. When no resume arrives in time, Learn says the
  process "would be considered a failure", and the requestor sees "Process expired" in My
  Access. Whether the request is then denied, delivered or left pending is not verified.
- **Resume.** The Logic App, or a process it starts, calls
  `POST /identityGovernance/entitlementManagement/assignmentRequests/{id}/resume` on a request
  whose status is `WaitingForCallback`, with `source`, `type` (the stage) and `data`
  (`accessPackageAssignmentRequestCallbackData` with `stage` and
  `customExtensionStageInstanceId`). The call that the Logic App receives carries the request
  ID, the `customExtensionStageInstanceId` and a `callbackUriPath`
  ([accessPackageAssignmentRequestCalloutData](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageassignmentrequestcalloutdata?view=graph-rest-1.0)).
  Learn also describes denying a request from the Logic App with `state = "denied"`; the
  article and the API page disagree on whether that works at `assignmentRequestCreated`, and
  the module does not model it. When the Logic App resumes through its HTTP action, Learn
  advises disabling the asynchronous pattern of that action.
- **Who may resume.** The resume action needs `EntitlementManagement.ReadWrite.All`, or one of
  the catalog roles Access package assignment manager (least privileged), Access package
  manager or Catalog owner, or Identity Governance Administrator. Learn recommends the Logic
  App's managed identity, enabled by you for entitlement management, with the Access package
  assignment manager role on the catalog instead of the tenant-wide permission
  ([securing custom extensions](https://learn.microsoft.com/en-us/entra/id-governance/custom-extension-security#assign-least-privileged-permissions-with-entitlement-management)).
  This module assigns neither; grant the role with the catalog role assignment of your choice.
- **Clouds.** The resume page lists the global service only, while the create page lists the
  US Government and China clouds too. Launch and wait outside the global service is not
  verified.
- **Property name.** The module sends only `timeoutDuration` inside
  `callbackConfiguration`, without `@odata.type`. Confirmed in the dev tenant on
  2026-10-28: the duration round-trips on create and update, and Graph accepts the
  callback without a discriminator and does not return one. Learn's entitlement
  management examples use `durationBeforeTimeout`; use the type page's
  `timeoutDuration` instead.

### Switching between the modes

| Change | What the module does |
| --- | --- |
| Set `callback` on a launch and continue extension | In-place update that adds the callback |
| Change `callback.timeout` | In-place update |
| Set `callback` back to `null` | In-place update without the callback. Graph keeps the callback that the body omits, so the extension stays launch and wait, and the `unmanaged_properties` check warns after the apply. Replace the extension to remove the callback |
| Change `extension_type` to `assignment_workflow` with `callback` set | The plan fails |

To return a launch and wait extension to launch and continue, set `callback = null` and
replace the extension in the same apply:
`terraform apply -replace='module.<name>.msgraph_resource.this'`. The new extension is created
from the configuration without a callback, gets a new id, and the policies in the same state
are updated with it. The module does not send `callbackConfiguration = null` instead: without
`callback` it sends the same body as before the input existed, so callers that do not use
launch and wait see no change, and whether Graph accepts a `null` callback configuration is
not verified.

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
  configuration only, so a client configuration set outside Terraform is lost, and so is a
  callback configuration while `callback` is null. A callback that `callback` declares is
  created with the replacement. `callback` is not part of the replacement trigger.
  `catalog_id` is part of the replacement trigger because the provider would otherwise send
  the update to the catalog in the stored resource URL.
- **An update keeps what its body omits.** The `unmanaged_properties` check lists the
  properties this module does not manage that Graph returned set: `clientConfiguration`,
  `behaviorOnError`, an authentication type other than proof of possession, and
  `callbackConfiguration` while `callback` is null. While `callback` is set the callback is in
  the body, and a change made outside Terraform shows in the plan instead. The plan or apply
  still succeeds. On a plan that creates, updates or replaces the extension the read-back is
  not known yet, and Terraform warns that the result is known after apply instead. Whether
  Graph returns a non-null `clientConfiguration`, or a non-null `callbackConfiguration` for a
  launch and continue extension, by default is not verified; if it does, the check warns on
  every read.
- **Removing `callback` keeps launch and wait.** Setting `callback` back to `null` updates the
  extension without the callback, and Graph keeps the callback. Replace the extension to
  return it to launch and continue; see
  [Switching between the modes](#switching-between-the-modes).
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
11. Launch and wait: the callback shape is confirmed on create and update (2026-10-28).
    The module suite still needs a live run proving its next plan is empty, and whether
    Graph normalizes other duration spellings.
12. Launch and wait: whether create and update reject a duration outside 5 minutes to 14 days,
    and a callback on an assignment workflow extension (the module rejects both first).
13. Launch and wait: that removing `callback` leaves the callback on the extension, and that
    a replacement removes it.
14. Launch and wait end to end, at each of the four request stages: the request waits with
    status `WaitingForCallback`, a resume by the Logic App's managed identity with the Access
    package assignment manager role continues it, and what happens to the request when the
    timeout passes.

**Probe P13 (check 11).** The independent `callback_probe.tftest.hcl` passed all eight
runs in the dev tenant on 2026-10-28: `timeoutDuration` round-trips on create and
update without callback `@odata.type`. The module integration suite creates an extension
with `callback = { timeout = "PT1H" }`, updates it to `PT2H`, reads both back with fresh
GETs. Check an unchanged plan after each apply during owner acceptance; Terraform test
assertions alone do not prove an empty plan. The suite does not invoke the Logic App.
Run from this folder with msgraph provider credentials for an identity with
`EntitlementManagement.ReadWrite.All`, and `TF_VAR_logic_app` for the Logic App fixture.

```bash
terraform init -test-directory=tests/integration
terraform test -test-directory=tests/integration
```

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

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
| callback | Launch and wait: `{ timeout }`, an ISO 8601 duration in whole days, hours and minutes, in normal form, from `PT5M` to `P14D`; `request_workflow` only. `null` leaves the callback out of the body (launch and continue on create); setting it back to `null` does not remove a callback | `object` | `null` | no | in place |
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
| launch_and_wait | `true` when `callback` is set, `false` otherwise; it follows the configuration, not the read-back | yes |
| logic_app_resource_id | The Azure resource ID of the Logic App; the trigger URL is never an output | yes |
| binding | `{ extension_id, extension_type }`, to merge with a `stage` into a policy's `custom_extension_stage_settings` | yes |

## Tests

`tests/custom_extension.tftest.hcl` runs offline against a mock provider and needs Terraform
1.11 or later: `terraform init` and `terraform test` in this folder. It covers both body
shapes, the request, update method and drift settings, the replacement of the extension when
the type or catalog changes, the description sent as `null`, the outputs and the `binding`
merge, each check, `name_pattern`, and every validation. For launch and wait it covers the
body without `callback` (the body sent before the input existed), the callback in the body,
in-place updates when the callback is added, changed and removed, the warning about a
callback that Graph keeps after `callback` is removed, the rule that only request workflow
extensions take a callback, and each timeout rule. A mock provider evaluates none of the
read-back expressions, so a Python test (`tests/test_custom_extensions.py`) ties them to the
mapping that consumes them and checks the validation and precondition messages. The live
suite in `tests/integration` includes both the module launch-and-wait suite and the independent
`callback_probe.tftest.hcl` create/update probe; see [Live test status](#live-test-status).

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `catalog_id`: replaces `msgraph_resource.this` when its effect on `local.catalog_id` changes; not replaced or moved: the update targets the existing object; recreate it to move it.
- `extension_type`: replaces `msgraph_resource.this`.
- `logic_app`: in place.
- `display_name`: in place.
- `description`: in place.
- `callback`: in place.
- `name_pattern`: no object change (validation or timing only).
- `timeouts`: no object change (validation or timing only).
<!-- drift:end -->
