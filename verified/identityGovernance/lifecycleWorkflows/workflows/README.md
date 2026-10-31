# identityGovernance/lifecycleWorkflows/workflows

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: not yet run](https://img.shields.io/badge/live-not%20yet%20run-lightgrey)
<!-- live-status:end -->

Manages one Microsoft Entra ID Governance **Lifecycle Workflows workflow**
(`identityGovernance/lifecycleWorkflows/workflows`, v1.0) and its tasks through the
`microsoft/msgraph` Terraform provider. A workflow automates joiner, mover and leaver steps
such as enabling or disabling an account, sending an email or removing group membership, for
the users that a scope rule selects.

The module is **disabled by default**: it creates the workflow with `isEnabled = false` and
`isSchedulingEnabled = false`, and enabling either needs an explicit `activation_opt_in`.
Planning and refreshing never run, reprocess or restore a workflow, and the module sends no
action. Tasks are the built-in task definitions that Microsoft Learn lists, chosen by key, so
a task that is not in that list, an argument that its definition does not have, and a task
that does not belong to the workflow's category all fail the plan.

## Usage

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "onboard_marketing" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/lifecycleWorkflows/workflows"
  version = "<version>"

  displayName = "Onboard marketing new hires"
  description = "Enable the account and welcome the new hire on the hire date"
  category    = "joiner"

  execution_conditions = {
    type       = "trigger_and_scope"
    scope_rule = "(department eq 'Marketing')"
    trigger = {
      timeBasedAttribute = "employeeHireDate"
      offsetInDays       = 0
    }
  }

  tasks = [
    {
      task         = "enable_user_account"
      displayName = "Enable user account"
    },
    {
      task         = "send_welcome_email"
      displayName = "Send welcome email"
      arguments    = { locale = "en-us", to = "User" }
    },
  ]

  # Created disabled. To run it, set all three of these after reviewing the plan:
  # isEnabled = true, isSchedulingEnabled = true, activation_opt_in = true.
}
```

A workflow that runs a custom task extension needs the extension's ID in `acknowledged_custom_task_extension_ids`
and the extension's ID:

```hcl
module "notify_integration" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/lifecycleWorkflows/workflows"
  version = "<version>"

  displayName = "Notify the integration on hire"
  category    = "joiner"

  execution_conditions = { type = "on_demand" }

  tasks = [
    {
      task         = "run_a_custom_task_extension"
      displayName = "Notify the integration"
      arguments    = { customTaskExtensionID = module.manager_access.id }
    },
  ]

  # The ID, written out: the plan fails if it differs from the extension the task runs.
  acknowledged_custom_task_extension_ids = ["<extension id>"]
}
```

A workflow that disables a user or removes access needs `acknowledge_dangerous_tasks = true`:

```hcl
module "offboard_leaver" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/lifecycleWorkflows/workflows"
  version = "<version>"

  displayName = "Offboard leavers"
  category    = "leaver"

  execution_conditions = { type = "on_demand" }

  tasks = [
    {
      task         = "disable_user_account"
      displayName = "Disable user account"
      arguments    = { disableOnPremisesAccount = "false" }
    },
    {
      task         = "revoke_all_refresh_tokens_for_user"
      displayName = "Revoke refresh tokens"
    },
  ]

  acknowledge_dangerous_tasks = true
}
```

## Tasks

`task-definitions.json` holds the 25 built-in task definitions of the example response on
[List taskDefinitions](https://learn.microsoft.com/en-us/graph/api/identitygovernance-lifecycleworkflowscontainer-list-taskdefinitions?view=graph-rest-1.0),
keyed by a name such as `enable_user_account`: its definition ID (a Microsoft-published
constant), display name, the categories it may be used in, its parameters and whether each
parameter has a fixed set of values. It is the example response, not a live catalogue of your
tenant, and a tenant can offer definitions that it does not list. A test compares it with the
pinned Learn page.

- Tasks run in list order. `executionSequence` is not an input and is not sent: Learn does not
  say who assigns it, and its responses show 1..N in list order.
- `arguments` is a map of name to value. A name must be a parameter of the definition. A value
  for a parameter with a fixed set of values (such as `disableOnPremisesAccount`) must be one of
  them; a string parameter is not limited to the example values Learn lists (such as the `to`
  recipients). Which parameters a task requires is not stated by the pinned pages and is not
  checked.
- **Tasks that can disable or delete a user or remove access**: `disable_user_account`,
  `delete_user_account`, `remove_user_from_selected_groups`, `remove_user_from_all_groups`,
  `remove_user_from_selected_teams`, `remove_user_from_all_teams`,
  `remove_access_package_assignment_for_user`, `remove_all_access_package_assignments_for_user`,
  `remove_all_licenses_for_user`, `remove_licenses_from_user` and
  `revoke_all_refresh_tokens_for_user`. This is the repository's own selection, not a Microsoft
  classification, and it covers tasks that remove access, not tasks that grant it (such as
  `add_user_to_groups` or `assign_licenses_to_user`). Selecting any of them needs `acknowledge_dangerous_tasks = true`; the
  `dangerous_task_keys` output lists them.
- **The custom task extension task** (`run_a_custom_task_extension`) is selectable only as an
  explicit opt-in, and only with the ID of an extension. It needs its ID in `acknowledged_custom_task_extension_ids`, and its `arguments` must hold `customTaskExtensionID`, a GUID (the `id` output of the
  [customTaskExtensions module](../customTaskExtensions/README.md) fits). The module cannot
  classify the task as dangerous or safe, because the effect lies in an external Azure Logic App
  that Graph does not describe, so it needs its own acknowledgement instead of
  `acknowledge_dangerous_tasks`; neither acknowledgement covers the other. The acknowledgement
  names the extensions: `acknowledged_custom_task_extension_ids` must equal, in lower case, the
  set of `customTaskExtensionID` values of the tasks, so a new, changed or removed extension ID
  fails the plan until the set is updated, and an acknowledgement that is no longer used fails
  too. Because an ID exists only once the extension is created, apply the extension first and
  then write its ID. The acknowledgement covers the ID only: a later change of the Logic App the
  extension points to is made in the extension module and is not seen here. Whoever sets it
  accepts what the extension does for every user the workflow runs for. The module cannot read the
  extension, so it does not check that the ID exists, that it is in this tenant or that the
  Logic App behind it is configured for Lifecycle Workflows; a workflow that names a missing
  extension is refused by Graph or fails at run time (not observed). The `custom_task_extension_ids`
  output lists the IDs. Changing the extension ID is a task change, so it replaces the workflow
  (see [Changing a workflow](#changing-a-workflow)). Creating the workflow does not call the
  Logic App; the call happens when a run reaches the task.

## Activation

`isEnabled` and `isSchedulingEnabled` default to `false` and are independent: enabling
either one needs `activation_opt_in = true`. For a `trigger_and_scope` workflow the scope rule
is required and must not be empty; the module does not parse the rule, so it cannot tell
whether it selects few users, and the rule is the only bound on the population. An `on_demand`
workflow has no scheduled population, so it has no rule. `administrationScopeTargets` is not
supported: Learn shows it only in the createNewVersion examples, not in the create request.

## Changing a workflow

Learn documents that only `description`, `displayName`, `isEnabled` and `isSchedulingEnabled`
can be updated with a PATCH of the workflow. Every other change (category, execution
conditions, and any task's definition, arguments, order, `isEnabled`, `continueOnError`) needs
the [createNewVersion](https://learn.microsoft.com/en-us/graph/api/identitygovernance-workflow-createnewversion?view=graph-rest-1.0)
action. Learn also documents a task PATCH for a task's `displayName` and `description`. This
module sends no action and no task PATCH, so:

- A change of `displayName`, `description`, `isEnabled` or `isSchedulingEnabled` updates
  the workflow in place and keeps its ID.
- A change of `category`, `execution_conditions` or **anything in `tasks`, including only a
  task's display name or description**, **replaces the workflow**
  (`terraform_data.immutable` with `replace_triggered_by`). The module does not use the task
  PATCH, so there is no in-place task rename.

### Replacing a workflow deletes it

A replacement is a **delete followed by a create**. Learn's
[Delete workflow](https://learn.microsoft.com/en-us/graph/api/identitygovernance-workflow-delete?view=graph-rest-1.0)
deletes the workflow **and its tasks, task processing results and versions**, that is, its run
history, and moves it to the deleted workflows container, from which it can be restored within
30 days. The new workflow has a new ID, starts at its first version and has no history. The old
workflow is deleted first because Learn calls the display name unique, and **whether the create
fails while the deleted workflow still holds the name is not verified**. If it does, the apply
stops after the delete and the old workflow has to be restored or renamed outside Terraform.

Before changing the category, the execution conditions or the tasks of a workflow that has run
or is enabled:

1. Apply a change that sets `isEnabled = false` and `isSchedulingEnabled = false` first, in a
   separate apply, so that no run starts while the workflow is being replaced.
2. Read the plan and check that it shows the workflow as replaced, not updated.
3. Export anything you need from the run history, because the replacement does not carry it.

The module never restores a workflow, never permanently deletes one and never creates a version.
Creating a new version with createNewVersion keeps the history and is the safer long-term route
for task and condition changes; it needs an action-backed resource and is not part of this
module.

### Changes made outside Terraform

Learn's [Get workflow](https://learn.microsoft.com/en-us/graph/api/identitygovernance-workflow-get?view=graph-rest-1.0)
returns the tasks (expanded by default) and the execution conditions, with server-added
properties such as each task's `id` and `executionSequence`. If someone edits them in the
portal, a plan that compared them would try to PATCH keys the update does not accept. The module
therefore ignores `body.tasks` and `body.executionConditions` on update
(`lifecycle.ignore_changes`): **an out-of-band edit of the tasks or the execution conditions is
not detected and not reconciled**. A change in the configuration still replaces the workflow
through `terraform_data.immutable`, which is computed from the configuration alone. A drifted
`isEnabled`, `isSchedulingEnabled`, `displayName` or `description` is still reported and
corrected in place. The mock tests cannot return a modified body, so this behaviour is checked by
a static test of the `ignore_changes` setting and has not been observed against a tenant.
Importing an existing workflow has not been verified either.

The tenant settings singleton (`identityGovernance/lifecycleWorkflows/settings`, the workflow
schedule interval) is a separate ownership surface and is not managed here. Task definitions,
workflow templates, runs, insights and reports are read-only or operational and are not managed
either.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.5.0 |

Microsoft Learn lists `LifecycleWorkflows-Workflow.ReadWrite.All` as the least privileged
delegated and application permission to create and to delete a workflow (the Lifecycle Workflows
Administrator role is the least privileged role), and `LifecycleWorkflows-Workflow.ReadBasic.All`
to get one (Global Reader or Lifecycle Workflows Administrator). The module reads a workflow
and updates it, and the update page is pinned but its permissions table is not reproduced, so the
create permission is the safe grant. A workflow processes member users, so the licensing rule below applies
to them.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | LIFECYCLE-WORKFLOWS | Lifecycle workflows, including their custom task extensions, require Microsoft Entra ID Governance or Microsoft Entra Suite for the organization's member users. Microsoft Entra ID P2 alone is not sufficient. Agent sponsorship tasks need Microsoft Agent 365, and some capabilities involve guest billing. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every member user a workflow processes, and the Lifecycle Workflows administrator | direct / per_user | documented |

Notes:

- A lifecycle workflow processes member users whom a scope rule selects (or whom someone runs it for on demand), so the LIFECYCLE-WORKFLOWS rule applies to those users, not to the identity that deploys the module. A workflow created by this module is disabled and has scheduling disabled until the caller opts in, but the licence rule applies to the feature, not to whether it currently runs.
- The built-in task definitions that Microsoft Learn lists include tasks that need other products: the custom task extension task needs an extension from the customTaskExtensions module and an explicit acknowledgement, access package tasks use entitlement management, and some email and temporary access pass tasks have their own prerequisites. Those are not modelled here; see [Lifecycle workflows license requirements](https://learn.microsoft.com/en-us/entra/id-governance/what-are-lifecycle-workflows#license-requirements).
- The Lifecycle Workflows rules for this module were reviewed against Microsoft Learn on 2026-10-22, which is later than the review date stated above.

Sources: [Lifecycle workflows license requirements](https://learn.microsoft.com/en-us/entra/id-governance/what-are-lifecycle-workflows#license-requirements), [Microsoft Entra licensing: lifecycle workflows](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#lifecycle-workflows), [Microsoft Entra ID Governance licensing fundamentals: licensing FAQs](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#licensing-faqs).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| displayName | Display name of the workflow; updated in place | `string` | n/a | yes | in place |
| category | `joiner`, `leaver` or `mover`; a change replaces the workflow | `string` | n/a | yes | replaces `msgraph_resource.workflow` |
| execution_conditions | `trigger_and_scope` (with `scope_rule` and a time-based `trigger`) or `on_demand`; a change replaces the workflow | `object` | n/a | yes | replaces `msgraph_resource.workflow` when its effect on `local.execution_conditions_body` changes |
| tasks | Built-in tasks by key, in order, with arguments; a change replaces the workflow | `list(object)` | n/a | yes | replaces `msgraph_resource.workflow` when its effect on `local.tasks_body` changes |
| description | Description of the workflow; updated in place | `string` | `""` | no | in place |
| isEnabled | Whether the workflow is enabled; needs `activation_opt_in` | `bool` | `false` | no | in place |
| isSchedulingEnabled | Whether scheduling is enabled; needs `activation_opt_in` | `bool` | `false` | no | in place |
| activation_opt_in | Explicit opt-in before either flag may be true | `bool` | `false` | no | no object change (validation or timing only) |
| acknowledge_dangerous_tasks | Explicit acknowledgement for tasks that disable or delete a user or remove access | `bool` | `false` | no | no object change (validation or timing only) |
| acknowledged_custom_task_extension_ids | IDs of the custom task extensions the reviewer accepted; must equal the extension IDs the tasks run | `set(string)` | `[]` | no | no object change (validation or timing only) |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that displayName must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The ID of the workflow; a replacement gives a new ID | yes |
| version | The version number that the last read returned | no |
| display_name | The display name, as configured | yes |
| category | The category, as configured | yes |
| is_enabled | Whether the workflow is enabled, as configured | yes |
| is_scheduling_enabled | Whether scheduling is enabled, as configured | yes |
| request_body | The create request body that the module sends | yes |
| dangerous_task_keys | The selected tasks that disable or delete a user or remove access | yes |
| custom_task_extension_ids | The IDs of the custom task extensions that the tasks run | yes |

## Live status

Offline mock tests establish the request body, the guards and the replacement behaviour. They
do not establish what a tenant accepts: no live run has been made. A bounded, owner-dispatched
sandbox probe that creates a disabled workflow, runs it on demand for a test user and recovers is
still outstanding. The prepared configuration-only suite does not execute the workflow.

The custom task extension binding is covered the same way: the mock tests build the request body
and the guards, and contract tests tie the task to the pinned definition. No workflow has run a
custom task extension, so the identity of the call, the behavior of a task whose extension is
missing or deleted, and the response or timeout of the Logic App are unobserved. The bounded probe
is in the [customTaskExtensions README](../customTaskExtensions/README.md#live-status-and-acceptance-runbook).

## Prepared governance suite

The optional `tests/integration` suite has not been run against a tenant. See
[governance live acceptance](../../../../../docs/governance-live-acceptance.md) for its
prerequisites, bounded assertions and the acceptance that remains outstanding.

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `displayName`: in place.
- `description`: in place.
- `category`: replaces `msgraph_resource.workflow`.
- `execution_conditions`: replaces `msgraph_resource.workflow` when its effect on `local.execution_conditions_body` changes.
- `tasks`: replaces `msgraph_resource.workflow` when its effect on `local.tasks_body` changes.
- `isEnabled`: in place.
- `isSchedulingEnabled`: in place.
- `activation_opt_in`: no object change (validation or timing only).
- `acknowledge_dangerous_tasks`: no object change (validation or timing only).
- `acknowledged_custom_task_extension_ids`: no object change (validation or timing only).
- `name_pattern`: no object change (validation or timing only).
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `POST /identityGovernance/lifecycleWorkflows/workflows` | DelegatedWork | `LifecycleWorkflows-Workflow.ReadWrite.All` | - | - |
| `POST /identityGovernance/lifecycleWorkflows/workflows` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/lifecycleWorkflows/workflows` | Application | `LifecycleWorkflows-Workflow.ReadWrite.All` | - | - |
| `GET /identityGovernance/lifecycleWorkflows/workflows/{id}` | DelegatedWork | `LifecycleWorkflows-Workflow.ReadBasic.All` | - | - |
| `GET /identityGovernance/lifecycleWorkflows/workflows/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/lifecycleWorkflows/workflows/{id}` | Application | `LifecycleWorkflows-Workflow.ReadBasic.All` | - | - |
| `DELETE /identityGovernance/lifecycleWorkflows/workflows/{id}` | DelegatedWork | `LifecycleWorkflows-Workflow.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/lifecycleWorkflows/workflows/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /identityGovernance/lifecycleWorkflows/workflows/{id}` | Application | `LifecycleWorkflows-Workflow.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/lifecycleWorkflows/workflows/{id}` | DelegatedWork | `LifecycleWorkflows-Workflow.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/lifecycleWorkflows/workflows/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /identityGovernance/lifecycleWorkflows/workflows/{id}` | Application | `LifecycleWorkflows-Workflow.ReadWrite.All` | - | - |

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `POST /identityGovernance/lifecycleWorkflows/workflows` | `category`, `description`, `displayName`, `executionConditions`, `isEnabled`, `isSchedulingEnabled`, `tasks` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /identityGovernance/lifecycleWorkflows/workflows/{id}` | `category`, `description`, `displayName`, `executionConditions`, `isEnabled`, `isSchedulingEnabled`, `tasks` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
