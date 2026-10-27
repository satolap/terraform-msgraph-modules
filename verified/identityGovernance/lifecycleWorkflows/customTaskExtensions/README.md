# identityGovernance/lifecycleWorkflows/customTaskExtensions

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Manages one Microsoft Entra ID Governance **Lifecycle Workflows custom task extension**
(`identityGovernance/lifecycleWorkflows/customTaskExtensions`, v1.0) through the
`microsoft/msgraph` Terraform provider. An extension is a configuration record that points a
workflow task at an **existing Azure Logic App**, so that the built-in task "Run a custom task
extension" can call it for each user a workflow runs for. It is not the entitlement management
custom workflow extension, which is catalog-scoped and bound to a policy stage (see the
[custom-extensions module](../../../identity-governance/entitlement-management/catalogs/custom-extensions/README.md)):
the contracts differ and nothing is shared.

The module **creates no Azure resource and reads none**. The Logic App, its resource group,
subscription and the Entra application that authenticates the call are inputs, and you deploy and
authorize them yourself. Applying the module only writes the extension record: Learn describes the
call to the Logic App as made by a workflow task that references the extension, so a plan, an
apply or a destroy of this module does not invoke the Logic App. The module sets no credential and
holds no secret; the request body holds only identifiers.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "manager_access" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/lifecycleWorkflows/customTaskExtensions"
  version = "<version>"

  display_name = "Grant manager access to mailbox"

  logic_app = {
    subscription_id         = var.logic_app_subscription_id
    resource_group_name     = "rg-lifecycle"
    logic_app_workflow_name = "ManagerAccess"
  }

  authentication_resource_id = var.logic_app_auth_application_id

  # Launch and wait: the task fails when nobody answers within this time (30 minutes to 3 hours).
  # Leave it out for launch and continue.
  callback_timeout_duration = "PT30M"
}

module "leaver_workflow" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/lifecycleWorkflows/workflows"
  version = "<version>"

  display_name         = "Offboard: manager access"
  category             = "leaver"
  execution_conditions = { type = "on_demand" }

  tasks = [
    {
      task         = "run_a_custom_task_extension"
      display_name = "Grant manager access"
      arguments    = { customTaskExtensionID = module.manager_access.id }
    },
  ]

  # The task calls an external system the module cannot classify: acknowledge the extension by
  # its ID. The ID exists only after the extension is created, so apply the extension module
  # first (terraform apply -target=module.manager_access), then write its ID here.
  acknowledged_custom_task_extension_ids = [var.manager_access_extension_id]
}
```

## Behavior

- **Request.** `POST identityGovernance/lifecycleWorkflows/customTaskExtensions` with
  `displayName`, `description`, a `logicAppTriggerEndpointConfiguration`
  (`subscriptionId`, `resourceGroupName`, `logicAppWorkflowName`), an
  `azureAdTokenAuthentication` (`resourceId`, an application ID), a
  `customExtensionClientConfiguration` (`timeoutInMilliseconds`, optional `maximumRetries`) and,
  only when `callback_timeout_duration` is set, a `customTaskExtensionCallbackConfiguration`
  (`timeoutDuration`). The `request_body` output shows it. The module never sends `replyMode` or
  `authorizedApps`, which no request table lists.
- **Launch and continue or launch and wait.** Without `callback_timeout_duration` the extension
  has no callback configuration, which follows Learn's description of launch and continue (the
  task succeeds once the Logic App is started). With it, the task waits for an answer and fails
  when none arrives in time. Learn says the answer may come from a third party through
  [taskProcessingResult: resume](https://learn.microsoft.com/en-us/graph/api/identitygovernance-taskprocessingresult-resume);
  who may answer (`authorizedApps`) is not managed here. The `reply_mode` output is derived from
  the input (`none` or `callback`), not read from Graph.
- **Callback duration form.** `callback_timeout_duration` accepts only the normalised form:
  `PT30M` to `PT59M`, `PT1H` to `PT2H59M` (hours without a leading zero, minutes below 60, no `0H`
  or `0M`) and `PT3H`. `PT90M`, `PT0H30M` and `PT180M` are rejected. Graph probably stores the
  normalised form, and a different string would show as a diff on every plan; this is not
  verified (GB-lifecycle-workflows-014, open probe in the runbook).
- **Two timeouts.** `timeout_in_milliseconds` (200 to 2000, default 1000) is how long Entra waits to
  connect to the Logic App; `callback_timeout_duration` is how long the task waits for the answer.
  Retries (`maximum_retries`) are 0 or 1; null leaves the service default.
- **Failure, timeout and error policy.** Learn documents no error policy (such as continue on
  error) for the extension itself. The task that runs it has `continue_on_error` in the workflows
  module. A connection that times out may be retried at most once; a missing callback fails the
  task. What the service does after a failed task is the workflow's `continue_on_error` setting,
  independent of whether the extension was created successfully.

## Changing an extension

Learn's [update page](https://learn.microsoft.com/en-us/graph/api/identitygovernance-customtaskextension-update?view=graph-rest-1.0)
documents the same six properties as the create page, so **every input is updated in place and
the ID never changes**: renaming it, pointing it at another Logic App or application, and changing
the timeouts are all a PATCH. The provider sends the changed top-level keys, and a changed nested
object (the endpoint, for example) whole. There is no replacement trigger, and because the ID
is stable a workflow that runs the extension is not replaced.

- **Unsetting does not clear.** A PATCH keeps what its body omits, and Learn documents no way to
  clear a value. Setting `callback_timeout_duration` or `maximum_retries` back to null removes it from
  the request, **not from Graph**: an extension that waits keeps waiting. To go back to launch and
  continue, create a new extension (new ID, so the workflow task changes and the workflow is
  replaced, which deletes its run history; see the workflows README) or change it in the portal.
- **The Logic App is not checked.** The module checks the shape of the inputs. Whether the Logic App
  exists, is a consumption workflow with a request trigger, is configured for Lifecycle Workflows
  (see [Configure a Logic App for Lifecycle Workflow use](https://learn.microsoft.com/en-us/entra/id-governance/configure-logic-app-lifecycle-workflows))
  and accepts the token of the application is not verified at apply time.
- **Out-of-band edits.** The read returns the configured properties and `createdBy` and
  `lastModifiedBy`. A change made in the portal to a managed property is reported as drift and
  corrected on the next apply; an unmanaged property (such as `authorizedApps`) is neither
  detected nor reset, because `ignore_missing_property` keeps configured keys that a read omits.
  Import of an existing extension has not been verified.

## Removing an extension

Learn's [delete page](https://learn.microsoft.com/en-us/graph/api/identitygovernance-customtaskextension-delete?view=graph-rest-1.0)
does not say what happens when a workflow still runs the extension. The entitlement management
rule (a referenced extension cannot be deleted) is a different API and is **not assumed**. Pass
`module.<name>.id` to the workflows module so that Terraform destroys the workflow before the
extension, and keep both in one state. If you remove only the workflow task and the extension in
one apply, Terraform replaces the workflow (new version, history deleted) before the extension is
deleted. Delete the Logic App only after the extension. Whether a task that names a deleted
extension fails at run time or is refused when the workflow is created is not documented.

**A soft-deleted workflow may still count as using the extension (unverified).** Deleting a
workflow moves it to the deleted items for 30 days (see the workflows README), and nothing says
whether that copy still references the extension. If it does, deleting the extension in the same
destroy, or right after a workflow replacement, can fail until the soft-deleted workflow is
permanently deleted or its 30 days pass. The module neither restores nor permanently deletes a
workflow, so if the extension delete is refused, retry after the workflow is permanently removed
in the portal or Graph, or leave the extension in place and remove it from the state only after
checking that nothing references it.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.5.0 |

Microsoft Learn lists `LifecycleWorkflows-CustomExt.ReadWrite.All` as the least privileged
delegated and application permission to create, update and delete an extension (higher:
`LifecycleWorkflows.ReadWrite.All`), and `LifecycleWorkflows-CustomExt.Read.All` to get or list
one. For delegated access the least privileged role is Lifecycle Workflows Administrator. For create and update Learn
adds that the calling user needs **Logic App Contributor, Contributor or Owner** on the Logic App
(Logic App Operator is not sufficient). Whether an application identity needs the Azure role, and
whether Graph changes the Logic App's access settings while creating the extension, is not
documented, so assume the apply may touch the Logic App's authorization configuration.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | LIFECYCLE-WORKFLOWS | Lifecycle workflows, including their custom task extensions, require Microsoft Entra ID Governance or Microsoft Entra Suite for the organization's member users. Microsoft Entra ID P2 alone is not sufficient. Agent sponsorship tasks need Microsoft Agent 365, and some capabilities involve guest billing. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every member user a workflow processes, and the Lifecycle Workflows administrator | direct / per_user | documented |

Notes:

- A custom task extension is a configuration record that a Lifecycle Workflows task references, so the LIFECYCLE-WORKFLOWS rule applies to the member users of the workflows that run it, not to the identity that deploys the module. Microsoft Learn states that Lifecycle Workflows, including their custom task extensions, need Microsoft Entra ID Governance or Microsoft Entra Suite.
- The extension calls an existing Azure Logic App that this module neither creates nor reads. The Logic App, its Azure subscription and its Azure Resource Manager role requirements (Logic App Contributor, Contributor or Owner for the caller on create and update) are outside the Microsoft Entra licenses; Logic App consumption is billed by Azure and is not modelled here. See [Lifecycle Workflows custom task extension](https://learn.microsoft.com/en-us/entra/id-governance/lifecycle-workflow-extensibility).
- The Lifecycle Workflows rules for this module were reviewed against Microsoft Learn on 2026-10-23, which is later than the review date stated above.

Sources: [Lifecycle workflows license requirements](https://learn.microsoft.com/en-us/entra/id-governance/what-are-lifecycle-workflows#license-requirements), [Microsoft Entra licensing: lifecycle workflows](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#lifecycle-workflows), [Microsoft Entra ID Governance licensing fundamentals: licensing FAQs](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#licensing-faqs).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| display_name | Display name; Learn calls it unique; updated in place | `string` | n/a | yes | in place |
| logic_app | The existing Logic App: `subscription_id` (GUID), `resource_group_name`, `logic_app_workflow_name` | `object` | n/a | yes | in place |
| authentication_resource_id | The appId (GUID) of the application that authenticates the call | `string` | n/a | yes | in place |
| description | Description; updated in place | `string` | `""` | no | in place |
| timeout_in_milliseconds | Connection timeout, 200 to 2000 | `number` | `1000` | no | in place |
| maximum_retries | 0 or 1; null leaves the service default; unsetting does not clear it | `number` | `null` | no | in place |
| callback_timeout_duration | Normalised `PT30M` to `PT3H` (for example `PT1H30M`, not `PT90M`) makes launch and wait; null is launch and continue; unsetting does not clear it | `string` | `null` | no | in place |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that display_name must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The extension ID, for the `customTaskExtensionID` argument of the workflows module | yes |
| display_name | The display name, as configured | yes |
| reply_mode | `callback` when a callback duration is set, otherwise `none`; derived, not read | yes |
| created_date_time | Creation time from the last read | no |
| last_modified_date_time | Last modification time from the last read | no |
| request_body | The create request body that the module sends | yes |

## Live status and acceptance runbook

Offline mock tests establish the request body, the validation and the in-place update. Contract
tests bind the body to the pinned Learn pages under `tests/fixtures/lifecycle-cte-contracts`. **No
live run has been made**: mocks are construction evidence, not proof that a tenant accepts the
body, that the Logic App is called with the expected identity, or what a delete does to a
referenced extension.

The owner-dispatched live probe (not dispatched while the technical-blocker hold stands) uses a
sandbox tenant with Entra ID Governance, a test user, a consumption Logic App prepared for
Lifecycle Workflows that only logs the call (it changes nothing), and a service principal with
`LifecycleWorkflows-CustomExt.ReadWrite.All`, `LifecycleWorkflows-Workflow.ReadWrite.All` and the
Logic App Contributor role on that Logic App only. It records, without tenant identifiers in the
repository:

1. **Create.** Apply this module for a launch-and-continue extension; read it back and confirm the
   returned configuration equals the request, which properties the read adds, and that the Logic App
   was not called.
2. **Update.** Apply a changed display name, timeouts and a callback duration written as `PT1H30M`;
   read it back and record the exact string Graph returns for `PT1H30M` and for `PT30M` and `PT3H`
   (whether it is normalised or echoed), and whether a plan after the apply shows a diff. Confirm
   the ID is unchanged and the callback configuration was added. Then unset the callback duration and confirm
   whether Graph keeps it (expected, GB-lifecycle-workflows-012).
3. **Bind.** Create a disabled on-demand workflow that runs the extension; read the task arguments back.
4. **Invocation.** Run the workflow on demand for the test user; record the calling identity and the
   token audience at the Logic App, how long the call takes, and the task result for launch and
   continue and for launch and wait (answered, and unanswered until the timeout).
5. **Delete while referenced.** Attempt to delete the extension while the workflow runs it and
   record the response. Then delete the workflow and, at once, the extension: record whether the
   soft-deleted workflow in the deleted items blocks the extension delete, and whether permanently
   deleting that workflow unblocks it.
6. **Cleanup.** Destroy both modules, confirm the extension is gone, delete the Logic App and the
   test user, and record the deleted-workflow behavior (the 30-day container).

Each result belongs in `docs/graph-behavior/lifecycle-workflows.md` (the entries named above) as
confirmed-live, with a link to the run.
