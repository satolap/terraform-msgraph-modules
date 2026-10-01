# identity-governance/entitlement-management/assignment-policies

Manages a Microsoft Entra ID Governance Entitlement Management **access package assignment
policy** (`identityGovernance/entitlementManagement/assignmentPolicies`) via the
`microsoft/msgraph` Terraform provider.

An assignment policy determines who can request or be assigned an access package, whether
approval is required (and by whom, across up to escalating approval stages), what questions
requestors must answer, and when the resulting assignment expires.

It also binds catalog custom extensions (Azure Logic Apps) to stages of the policy's requests
and assignments through `custom_extension_stage_settings`; see
[Custom extension bindings](#custom-extension-bindings). **This module is authoritative over
the custom extension bindings of every policy it manages**, so read
[Upgrading](#upgrading-from-a-release-without-custom-extension-bindings) before you update a
policy that has bindings.

## Usage

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one.

```hcl
module "engineering_policy" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/identity-governance/entitlement-management/assignment-policies?ref=<release-tag>"

  access_package_id    = module.engineering_access.id
  display_name         = "Standard request policy"
  description          = "Employees can request; manager approval required"
  allowed_target_scope = "allMemberUsers"

  expiration = {
    type          = "afterDuration"
    duration_days = 180
  }

  requestor_settings = {
    enable_targets_to_self_add_access = true
  }

  request_approval_settings = {
    is_approval_required_for_add        = true
    is_requestor_justification_required = true

    stages = [
      {
        approval_timeout_in_days = 14
        primary_approvers = [
          { type = "requestorManager" },
        ]
        is_escalation_enabled     = true
        escalation_timeout_in_days = 3
        escalation_approvers = [
          { type = "groupMembers", id = azuread_group.access_reviewers.object_id },
        ]
      },
    ]
  }

  questions = [
    { text = "Why do you need this access?", is_required = true, sequence = 1 },
  ]
}
```

To run catalog custom extensions, declare one entry per stage. The extensions must be in the
catalog of the access package:

```hcl
module "engineering_policy" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/identity-governance/entitlement-management/assignment-policies?ref=<release-tag>"

  access_package_id = module.engineering_access.id
  display_name      = "Standard request policy"

  expiration = {
    type          = "afterDuration"
    duration_days = 180
  }

  custom_extension_stage_settings = [
    { stage = "assignmentRequestGranted", extension_id = "<request extension id>", extension_type = "request_workflow" },
    { stage = "assignmentRequestRemoved", extension_id = "<request extension id>", extension_type = "request_workflow" },
    { stage = "assignmentOneDayBeforeExpiration", extension_id = "<expiration extension id>", extension_type = "assignment_workflow" },
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.3.0 |

The configuring identity/application needs the `EntitlementManagement.ReadWrite.All`
Microsoft Graph permission (or the *Access package manager*/*Catalog owner* Entitlement
Management delegated roles).

| Operation | Application permission | Least privileged role |
|-----------|------------------------|-----------------------|
| Create or update the policy, with or without bindings | `EntitlementManagement.ReadWrite.All` | *Access package manager*, then *Catalog owner* |
| Read the policy and its bindings (every plan) | `EntitlementManagement.Read.All` | *Catalog reader* |
| Read the access package's catalog and list the catalog's custom extensions (only when bindings are declared) | `EntitlementManagement.Read.All` | *Catalog reader* |

A `401` or `403` on the access package read or on the list of the catalog's custom extensions
fails the plan; it is not read as "no extensions". The policy read inside
`undeclared_custom_extension_bindings` is a data source scoped to a check, so a failed read
there only warns, and the check then reports nothing about undeclared bindings. It reports
nothing either when that read returns no stage settings, whether Graph omits them or returns
`null`.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |
| `specific_allowed_targets[*].type` contains `"attributeRuleMembers"` | EM-ADVANCED | Automatic assignment through attribute rules, custom extensions and some advanced approval options require Microsoft Entra ID Governance or Microsoft Entra Suite. Microsoft Entra ID P2 alone is not sufficient. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user eligible under the policy that enables the advanced feature | group_based / per_user | documented |
| `requestor_settings.enable_on_behalf_requestors_to_add_access` is `true` | EM-ON-BEHALF | Submitting an access package request on behalf of another user requires both the requestor and the target user to be covered by Microsoft Entra ID Governance or Microsoft Entra Suite. This differs from a manager merely approving a request. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Both the on-behalf requestor and the target user | direct / per_user | documented |
| `requestor_settings.enable_on_behalf_requestors_to_update_access` is `true` | EM-ON-BEHALF | Submitting an access package request on behalf of another user requires both the requestor and the target user to be covered by Microsoft Entra ID Governance or Microsoft Entra Suite. This differs from a manager merely approving a request. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Both the on-behalf requestor and the target user | direct / per_user | documented |
| `requestor_settings.enable_on_behalf_requestors_to_remove_access` is `true` | EM-ON-BEHALF | Submitting an access package request on behalf of another user requires both the requestor and the target user to be covered by Microsoft Entra ID Governance or Microsoft Entra Suite. This differs from a manager merely approving a request. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Both the on-behalf requestor and the target user | direct / per_user | documented |
| `request_approval_settings.approver_information_visibility` is not one of `["default", null]` | EM-ADVANCED | Automatic assignment through attribute rules, custom extensions and some advanced approval options require Microsoft Entra ID Governance or Microsoft Entra Suite. Microsoft Entra ID P2 alone is not sufficient. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user eligible under the policy that enables the advanced feature | group_based / per_user | documented |
| `requestor_settings.on_behalf_requestors[*].type` contains `"targetUserSponsors"` | EM-ADVANCED | Automatic assignment through attribute rules, custom extensions and some advanced approval options require Microsoft Entra ID Governance or Microsoft Entra Suite. Microsoft Entra ID P2 alone is not sufficient. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user eligible under the policy that enables the advanced feature | group_based / per_user | documented |
| `allowed_target_scope` is one of `["specificDirectoryServicePrincipals", "allDirectoryServicePrincipals", "allDirectoryAgentIdentities"]` | AGENT-IDENTITIES | Policies that target service principals or agent identities depend on Microsoft Agent 365 requirements that have not been reviewed for these modules. Treat the requirement as unknown until reviewed together with the API version and end-to-end behavior. No additional license specified. | Unknown | group_based / per_tenant | unknown |
| `custom_extension_stage_settings` is set | EM-ADVANCED | Automatic assignment through attribute rules, custom extensions and some advanced approval options require Microsoft Entra ID Governance or Microsoft Entra Suite. Microsoft Entra ID P2 alone is not sufficient. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user eligible under the policy that enables the advanced feature | group_based / per_user | documented |

Notes:

- An accepted enum value is not evidence of entitlement or lifecycle support. Human-user policies with standard approval stages, questions and expiration are the reviewed core profile.
- The custom extension rule was reviewed against Microsoft Learn on 2026-10-01, which is later than the review date stated above.
- When `specific_allowed_targets[*].type` contains `"attributeRuleMembers"`: Attribute-rule targets describe automatic assignment; inspect the emitted body and Graph contract before treating it as a supported workflow.
- When `request_approval_settings.approver_information_visibility` is not one of `["default", null]`: Nondefault approver information visibility is an advanced approval option; verify the exact feature mapping before enabling it in a licensed test.
- When `requestor_settings.on_behalf_requestors[*].type` contains `"targetUserSponsors"`: Sponsor-based subject sets are a feature-review trigger.
- When `custom_extension_stage_settings` is set: A policy that targets guests or external users and uses a custom extension also needs the tenant linked to an Azure subscription for Microsoft Entra ID Governance for guests, and each successful request is billed to that subscription (https://learn.microsoft.com/en-us/entra/id-governance/microsoft-entra-id-governance-licensing-for-guest-users). Azure Logic Apps billing is separate and not modelled.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license), [Request on behalf of other users](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-request-behalf), [Microsoft Entra ID Governance licensing fundamentals](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#types-of-licenses).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| access_package_id | ID of the access package this policy applies to | `string` | n/a | yes |
| display_name | Display name of the policy (1-90 characters) | `string` | n/a | yes |
| description | Description of the policy | `string` | `null` | no |
| allowed_target_scope | Who can be assigned via this policy (see `accessPackageAssignmentPolicy.allowedTargetScope` values) | `string` | `"notSpecified"` | no |
| specific_allowed_targets | Principals allowed when allowed_target_scope is a "specific*" value | `list(object)` | `[]` | no |
| expiration | `{ type, duration_days, end_date_time }` — expiration pattern for assignments | `object` | `{ type = "noExpiration" }` | no |
| requestor_settings | Self-service/on-behalf-of request toggles and on-behalf-of requestors | `object` | `{}` | no |
| request_approval_settings | Approval requirement flags and escalating approval stages | `object` | `{}` | no |
| questions | Text-input questions posed to the requestor | `list(object)` | `[]` | no |
| custom_extension_stage_settings | `{ stage, extension_id, extension_type }` per stage: the catalog custom extensions that run at that stage. Always sent; an empty list removes the bindings | `list(object)` | `[]` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

Approver/requestor/target objects share the shape `{ type, id, description, membership_rule }`,
where `type` is one of Microsoft Graph's `subjectSet` subtypes (`singleUser`, `groupMembers`,
`requestorManager`, `internalSponsors`, `externalSponsors`, `targetUserSponsors`, plus
`connectedOrganizationMembers` and `attributeRuleMembers` for `specific_allowed_targets`).
`id` maps to the correct underlying Graph property (`userId`, `groupId`, or
`connectedOrganizationId`) automatically based on `type`.

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the assignment policy |
| display_name | The display name of the assignment policy |
| access_package_id | The ID of the parent access package |
| custom_extension_stage_settings | The bindings Microsoft Graph returned on the last read, as `{ stage, extension_id }`; `null` when the read returned none of them |

## Custom extension bindings

**This module is authoritative over the custom extension bindings of every policy it manages.**
It sends `customExtensionStageSettings` on every apply. A binding that the policy has but
`custom_extension_stage_settings` does not declare is removed by the next apply, and with the
default `[]` every binding is removed, including one that was configured in the portal or by
another tool. The Logic App of a removed binding is no longer called for that policy.

Each entry binds one extension to one stage:

| `stage` | `extension_type` | Runs |
|---------|------------------|------|
| `assignmentRequestCreated` | `request_workflow` | When a request is created |
| `assignmentRequestApproved` | `request_workflow` | When a request is approved |
| `assignmentRequestGranted` | `request_workflow` | When access is granted |
| `assignmentRequestRemoved` | `request_workflow` | When access is removed |
| `assignmentFourteenDaysBeforeExpiration` | `assignment_workflow` | 14 days before an assignment expires |
| `assignmentOneDayBeforeExpiration` | `assignment_workflow` | 1 day before an assignment expires |

- The module sends the entry as `{ stage, customExtension = { "@odata.type", id } }`, with the
  concrete type of the extension type and the extension ID in lower case, as Graph returns it.
  `unknownFutureValue` is not accepted as a stage.
- A stage can be bound once per policy. Whether Graph accepts the same stage twice is not
  verified, so the module rejects it. One extension can be bound to several stages of its type.
- The two expiration stages run only for assignments that expire. The module fails the plan
  when one is bound and `expiration.type` is `noExpiration`.
- A policy can use only the custom extensions of its own catalog. The module fails the plan
  when a declared `extension_id` is not in the catalog of `access_package_id`. It reads the
  access package with `$expand=catalog` and lists the catalog's custom extensions, only when
  a binding is declared, so a policy without bindings makes no extra request. When the
  extension is created in the same apply, the list is read after that extension exists. The
  plan also fails when the access package read returns no catalog.
- `null` for `custom_extension_stage_settings` means the same as the default `[]`.

### Reading the bindings back

A plain `GET` of a policy does not return its bindings. The module reads the policy with
`$expand=customExtensionStageSettings($expand=customExtension)`, so a binding added or removed
outside Terraform shows as a change of the list in the next plan. The output
`custom_extension_stage_settings` keeps only the stage and the extension ID of each binding, in
the order Graph returned them, including bindings that are not declared. It is `null`, never an
empty list, when Graph returned no stage settings. The provider compares the declared list with
Graph's by position, and Graph's order is not documented: if a plan keeps showing an in-place
update of a list that did not change, reorder the entries to match the output.

The expanded read returns each extension object, including its endpoint configuration. When the
number of bindings on the server differs from the number declared, as when the server has
bindings that the configuration does not declare, the provider keeps the whole list Graph
returned in the `body` of the resource in the state, and the plan diff prints it. That includes
the endpoint configuration of every extension, such as the Azure subscription, resource group
and Logic App name. Review the output of the first plan after an upgrade before you share it.

### Checks and guards

| Name | Kind | Reports |
|------|------|---------|
| `expiration` guard | resource precondition | An expiration stage is bound and `expiration.type` is `noExpiration` |
| `catalog` read guard | data source precondition | The access package read returned no catalog, so its extensions cannot be listed |
| `catalog` guard | resource precondition | A declared extension is not in the catalog of the access package |
| `undeclared_custom_extension_bindings` | check (warning) | The server has bindings that the configuration does not declare, so the next apply removes them |
| `guest_custom_extension_prerequisite` | check (warning) | Bindings are declared for a policy that can include guests or external users |

`undeclared_custom_extension_bindings` reads the policy again on every plan, because on a plan
that updates the policy the resource's own read-back is not known yet. It names the stage and
extension ID of each binding that the next apply removes. It cannot warn before the policy
exists.

`guest_custom_extension_prerequisite` applies when `allowed_target_scope` is
`specificConnectedOrganizationUsers`, `allConfiguredConnectedOrganizationUsers`,
`allExternalUsers` or `allDirectoryUsers`, or is `specificDirectoryUsers` and
`specific_allowed_targets` names a target: a user, a group or a membership rule can be or
contain a guest. A policy that targets guests or external users and uses a custom extension
needs the tenant linked to an Azure subscription for Microsoft Entra ID Governance for guests,
and Learn lists "Guest policy assigned with custom extension" as billed on each successful
request. See [Microsoft Entra ID Governance licensing for guests](https://learn.microsoft.com/en-us/entra/id-governance/microsoft-entra-id-governance-licensing-for-guest-users).
The module does not check the link or the billing.

### Limits and lifecycle

- Remove a binding and delete its extension in two applies. Graph refuses to delete an extension
  that a policy still uses, and once the binding is gone from the configuration Terraform has no
  reference that orders the two.
- On a plan that creates the policy, Terraform reports that the result of
  `undeclared_custom_extension_bindings` is known after apply. In a `terraform test` run with
  `command = plan` that creates a policy through this module, that is an error
  ("Check block assertion known after apply"), and `expect_failures` cannot name a check inside
  a module. Run it with `command = apply`, or with Terraform 1.7 or later add an
  `override_module` block for the module.
- `api_version = "beta"` sends the same property. The documented contract is v1.0, and beta
  is not verified.
- Verified with mocked providers only. Live test status: not verified in a licensed tenant.

## Upgrading from a release without custom extension bindings

Older releases never sent `customExtensionStageSettings`, so a binding configured outside
Terraform survived every apply. This release sends it on every apply:

1. Before you upgrade, read the bindings of each policy this module manages, for example with
   `GET /identityGovernance/entitlementManagement/assignmentPolicies/{id}?$expand=customExtensionStageSettings($expand=customExtension)`.
2. Declare each one in `custom_extension_stage_settings`: `stage`, `extension_id` from
   `customExtension.id`, and `extension_type` `request_workflow` for
   `#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension` or `assignment_workflow`
   for `#microsoft.graph.accessPackageAssignmentWorkflowExtension`.
3. Upgrade and plan. The first plan shows an in-place update of every policy, because the request
   body now carries `customExtensionStageSettings`. `undeclared_custom_extension_bindings` warns
   for each policy that still has a binding it does not declare, and the diff of such a policy can
   print the expanded extension objects, including their endpoint configuration.
4. Apply only when no policy warns. An apply with the default `[]` removes the bindings that
   were configured outside Terraform, which stops their Logic Apps from being called.

The guards can also fail a plan that declares bindings in an invalid combination, for example an
expiration stage with `noExpiration`.
