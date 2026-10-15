# identity-governance/entitlement-management/assignment-policies

Manages a Microsoft Entra ID Governance Entitlement Management **access package assignment
policy** (`identityGovernance/entitlementManagement/assignmentPolicies`) via the
`microsoft/msgraph` Terraform provider.

An assignment policy determines who can request or be assigned an access package, whether
approval is required (and by whom, across up to escalating approval stages), what questions
requestors must answer, when the resulting assignment expires, and whether the assignments
are reviewed on a recurring schedule.

Questions are text input or multiple choice, with optional localized texts; see
[Requestor questions](#requestor-questions). Recurring access reviews of the policy's
assignments are configured through `review_settings`; see [Access reviews](#access-reviews).
The module leaves `reviewSettings` out of the request body while `review_settings` is null,
and Learn does not say what an update without it does to reviews configured elsewhere.

It also binds catalog custom extensions (Azure Logic Apps) to stages of the policy's requests
and assignments through `custom_extension_stage_settings`; see
[Custom extension bindings](#custom-extension-bindings). **This module is authoritative over
the custom extension bindings of every policy it manages**, so read
[Upgrading](#upgrading-from-a-release-without-custom-extension-bindings) before you update a
policy that has bindings.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "engineering_policy" {
  source  = "satolap/modules/msgraph//curated/identity-governance/entitlement-management/assignment-policies"
  version = "<version>"

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

A policy for the users of one connected organization, with two approval stages, a localized
multiple choice question and quarterly reviews by a group that remove access when nobody
responds:

```hcl
module "partner_policy" {
  source  = "satolap/modules/msgraph//curated/identity-governance/entitlement-management/assignment-policies"
  version = "<version>"

  access_package_id    = module.partner_access.id
  display_name         = "Fabrikam users"
  description          = "Fabrikam users request; sponsors approve; reviewed quarterly"
  allowed_target_scope = "specificConnectedOrganizationUsers"
  specific_allowed_targets = [
    { type = "connectedOrganizationMembers", id = "<connected organization id>" },
  ]

  expiration = {
    type          = "afterDuration"
    duration_days = 365
  }

  requestor_settings = {
    enable_targets_to_self_add_access    = true
    enable_targets_to_self_remove_access = true
  }

  request_approval_settings = {
    is_approval_required_for_add        = true
    is_requestor_justification_required = true
    stages = [
      {
        approval_timeout_in_days   = 14
        primary_approvers          = [{ type = "externalSponsors" }]
        fallback_primary_approvers = [{ type = "groupMembers", id = "<fallback approver group id>" }]
      },
      {
        approval_timeout_in_days   = 14
        primary_approvers          = [{ type = "internalSponsors" }]
        fallback_primary_approvers = [{ type = "groupMembers", id = "<fallback approver group id>" }]
      },
    ]
  }

  questions = [
    {
      type        = "multiple_choice"
      text        = "Which project do you work on?"
      is_required = true
      sequence    = 1
      localizations = [
        { text = "An welchem Projekt arbeiten Sie?", language_code = "de" },
      ]
      choices = [
        { text = "Project A", actual_value = "project-a", localizations = [{ text = "Projekt A", language_code = "de" }] },
        { text = "Project B", actual_value = "project-b", localizations = [{ text = "Projekt B", language_code = "de" }] },
      ]
    },
  ]

  review_settings = {
    expiration_behavior = "removeAccess"
    primary_reviewers   = [{ type = "groupMembers", id = "<reviewer group id>" }]
    schedule = {
      start_date_time  = "2026-11-01T00:00:00Z"
      duration_in_days = 25
      recurrence       = { type = "absoluteMonthly", interval = 3 }
    }
  }
}
```

To run catalog custom extensions, declare one entry per stage. The extensions must be in the
catalog of the access package:

```hcl
module "engineering_policy" {
  source  = "satolap/modules/msgraph//curated/identity-governance/entitlement-management/assignment-policies"
  version = "<version>"

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
| Create or update the policy, with or without bindings, questions or access reviews | `EntitlementManagement.ReadWrite.All` | *Access package manager*, then *Catalog owner* |
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
| `review_settings` is set | EM-ACCESS-REVIEWS | Recurring access reviews of the assignments made through an access package assignment policy require Microsoft Entra ID Governance or Microsoft Entra Suite. Access reviews licensing covers the member users who review access and the member users whose access is reviewed, self-reviewers included. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every member user who reviews the policy's assignments and every member user whose assignment is reviewed | group_based / per_user | documented |

Notes:

- An accepted enum value is not evidence of entitlement or lifecycle support. Human-user policies with standard approval stages, questions and expiration are the reviewed core profile.
- The custom extension rule was reviewed against Microsoft Learn on 2026-10-01, which is later than the review date stated above.
- Access reviews (review_settings) and multiple-choice and localized questions were reviewed against Microsoft Learn on 2026-10-07, which is later than the review date stated above. Questions of either type, with localizations, are the capability 'EM - Collect additional requestor information for approval', which the licensing table of Microsoft Entra ID Governance includes in Microsoft Entra ID P2, so they stay within EM-CORE.
- When `specific_allowed_targets[*].type` contains `"attributeRuleMembers"`: Attribute-rule targets describe automatic assignment; inspect the emitted body and Graph contract before treating it as a supported workflow.
- When `request_approval_settings.approver_information_visibility` is not one of `["default", null]`: Nondefault approver information visibility is an advanced approval option; verify the exact feature mapping before enabling it in a licensed test.
- When `requestor_settings.on_behalf_requestors[*].type` contains `"targetUserSponsors"`: Sponsor-based subject sets are a feature-review trigger.
- When `custom_extension_stage_settings` is set: A policy that targets guests or external users and uses a custom extension also needs the tenant linked to an Azure subscription for Microsoft Entra ID Governance for guests, and each successful request is billed to that subscription (https://learn.microsoft.com/en-us/entra/id-governance/microsoft-entra-id-governance-licensing-for-guest-users). Azure Logic Apps billing is separate and not modelled.
- When `review_settings` is set: The rule applies whenever review_settings is set, also with is_enabled = false. The licensing table of Microsoft Entra ID Governance includes the access review capabilities previously generally available in Microsoft Entra ID P2 in P2, but the page on access reviews of access packages names Microsoft Entra ID Governance or Microsoft Entra Suite as its prerequisite, so the stricter rule is used. The guest licensing page lists no access package review among the billable guest actions.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license), [Request on behalf of other users](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-request-behalf), [Microsoft Entra ID Governance licensing fundamentals](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#types-of-licenses), [Create an access review of an access package in entitlement management](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-access-reviews-create#prerequisites), [Microsoft Entra ID Governance licensing fundamentals: access reviews](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#access-reviews).
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
| questions | Questions posed to the requestor: `{ text, is_required, is_answer_editable, sequence, type, localizations, is_single_line_question, regex_pattern, is_multiple_selection_allowed, choices }`, with `type` `text_input` (default) or `multiple_choice`; see [Requestor questions](#requestor-questions) | `list(object)` | `[]` | no |
| review_settings | Recurring access reviews of the policy's assignments: `{ is_enabled, expiration_behavior, is_recommendation_enabled, is_reviewer_justification_required, is_self_review, primary_reviewers, fallback_reviewers, schedule }`; null leaves `reviewSettings` out of the body; see [Access reviews](#access-reviews) | `object` | `null` | no |
| custom_extension_stage_settings | `{ stage, extension_id, extension_type }` per stage: the catalog custom extensions that run at that stage. Always sent; an empty list removes the bindings | `list(object)` | `[]` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

Approver/requestor/target objects share the shape `{ type, id, description, membership_rule }`,
where `type` is one of Microsoft Graph's `subjectSet` subtypes (`singleUser`, `groupMembers`,
`requestorManager`, `internalSponsors`, `externalSponsors`, `targetUserSponsors`, plus
`connectedOrganizationMembers` and `attributeRuleMembers` for `specific_allowed_targets`).
`id` maps to the correct underlying Graph property (`userId`, `groupId`, or
`connectedOrganizationId`) automatically based on `type`. Reviewer objects in
`review_settings` are `{ type, id }` with `type` `singleUser` or `groupMembers` only.

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the assignment policy |
| display_name | The display name of the assignment policy |
| access_package_id | The ID of the parent access package |
| custom_extension_stage_settings | The bindings Microsoft Graph returned on the last read, as `{ stage, extension_id }`; `null` when the read returned none of them |

## Requestor questions

Each entry of `questions` is one question, sent as an
[accessPackageTextInputQuestion](https://learn.microsoft.com/en-us/graph/api/resources/accesspackagetextinputquestion?view=graph-rest-1.0)
(`type = "text_input"`, the default) or an
[accessPackageMultipleChoiceQuestion](https://learn.microsoft.com/en-us/graph/api/resources/accesspackagemultiplechoicequestion?view=graph-rest-1.0)
(`type = "multiple_choice"`), in the order given:

| Input | Graph property | Question type | Sent |
|-------|----------------|---------------|------|
| `text` | `text` | both | always |
| `is_required` | `isRequired` | both | always, default `false` |
| `is_answer_editable` | `isAnswerEditable` | both | always, default `true` |
| `sequence` | `sequence` | both | always, `null` when unset |
| `localizations[*]` `{ text, language_code }` | `localizations[*]` `{ text, languageCode }` ([accessPackageLocalizedText](https://learn.microsoft.com/en-us/graph/api/resources/accesspackagelocalizedtext?view=graph-rest-1.0)) | both | when not null |
| `is_single_line_question` | `isSingleLineQuestion` | `text_input` | when not null |
| `regex_pattern` | `regexPattern` | `text_input` | when not null |
| `is_multiple_selection_allowed` | `isMultipleSelectionAllowed` | `multiple_choice` | always, `false` when null |
| `choices[*]` `{ text, actual_value, localizations }` | `choices[*]` `{ text, actualValue, localizations }` ([accessPackageAnswerChoice](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageanswerchoice?view=graph-rest-1.0)) | `multiple_choice` | always, localizations when not null |

- **Earlier bodies are kept.** A question that sets none of the newer attributes, or sets them
  to null, sends exactly the five keys that earlier releases sent: `@odata.type`,
  `isRequired`, `isAnswerEditable`, `sequence` and `text`.
  `tests/request_body_compatibility.tftest.hcl` compares the whole request body with the one
  the previous release built for the same inputs.
- **Validations.** `type` is `text_input` or `multiple_choice`. A `multiple_choice` question
  needs at least one choice, and the choices of a question need distinct `actual_value`
  entries, because an answer carries the actual value. `choices` and
  `is_multiple_selection_allowed` are rejected on a `text_input` question, and
  `is_single_line_question` and `regex_pattern` on a `multiple_choice` question. Choice texts,
  actual values and localized texts must not be empty, and each `localizations` list names a
  language at most once, ignoring case.
- **Language codes.** Learn describes `languageCode` as an ISO 639-1 language code followed by
  an ISO 3166-1 alpha-2 country code, such as `en-us`. The module accepts two letters, with an
  optional hyphen and two more, such as `de`, `en-us` or `fr-CA`. Whether Graph accepts a code
  without a country, and whether it keeps the case of the code, is not verified.
- **Regular expressions.** `regex_pattern` is sent unchanged. Learn does not name the regular
  expression dialect, so the module does not check the pattern.
- **Question IDs.** The question type has an `id` property, but the create examples in Learn
  send none, and Learn does not say whether an update should send one or how Graph matches the
  questions of a `PUT` body with the existing ones. The module sends no ID. Whether an update
  keeps the IDs of unchanged questions is not verified; an answer on a request refers to the
  question it answers (`answeredQuestion`).
- **Reading back.** Learn lists `questions` as a relationship of the v1.0 policy and does not
  say whether a plain `GET` returns it. The module does not expand it, so a question changed
  outside Terraform may not show in a plan; the next update of the policy sends the configured
  questions again.

## Access reviews

`review_settings` configures the recurring access reviews of the assignments made through the
policy, as
[accessPackageAssignmentReviewSettings](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageassignmentreviewsettings?view=graph-rest-1.0)
in the `reviewSettings` property. Quarterly reviews by a group, open for 25 days and removing
access that nobody reviews, are sent as:

```json
"reviewSettings": {
  "isEnabled": true,
  "expirationBehavior": "removeAccess",
  "isRecommendationEnabled": true,
  "isReviewerJustificationRequired": true,
  "isSelfReview": false,
  "primaryReviewers": [
    { "@odata.type": "#microsoft.graph.groupMembers", "groupId": "<reviewer group id>" }
  ],
  "fallbackReviewers": [],
  "schedule": {
    "startDateTime": "2026-11-01T00:00:00Z",
    "expiration": { "duration": "P25D", "type": "afterDuration" },
    "recurrence": {
      "pattern": { "type": "absoluteMonthly", "interval": 3, "dayOfMonth": 1 },
      "range": { "type": "noEnd", "numberOfOccurrences": 0 }
    }
  }
}
```

| Input | Graph property | Values |
|-------|----------------|--------|
| `is_enabled` | `isEnabled` | default `true` |
| `expiration_behavior` | `expirationBehavior` | `keepAccess`, `removeAccess` or `acceptAccessRecommendation`; required |
| `is_recommendation_enabled` | `isRecommendationEnabled` | default `true`, the Graph default |
| `is_reviewer_justification_required` | `isReviewerJustificationRequired` | default `true`, the Graph default |
| `is_self_review` | `isSelfReview` | default `false` |
| `primary_reviewers`, `fallback_reviewers` | `primaryReviewers`, `fallbackReviewers` | `{ type, id }`, `singleUser` (`userId`) or `groupMembers` (`groupId`); default `[]` |
| `schedule.start_date_time` | `schedule.startDateTime` | RFC 3339 timestamp in UTC, ending in `Z`; required |
| `schedule.duration_in_days` | `schedule.expiration` | `{ duration = "P<n>D", type = "afterDuration" }`: how long each review is open; positive whole number |
| `schedule.recurrence.type`, `.interval` | `schedule.recurrence.pattern` `{ type, interval }` | `weekly` or `absoluteMonthly`; interval a positive whole number |
| `schedule.recurrence.day_of_month` | `schedule.recurrence.pattern.dayOfMonth` | 1 to 31, only with `absoluteMonthly`; when null, the day of `start_date_time` is sent |
| `schedule.recurrence.range_type`, `.number_of_occurrences` | `schedule.recurrence.range` `{ type, numberOfOccurrences }` | `noEnd` (default, sent with `numberOfOccurrences` 0) or `numbered` with a positive number of reviews |

- **Reviewers.** Learn documents `singleUser` and `groupMembers` as subject sets for the
  reviewers of access package assignments, and the module accepts only these two. The admin
  center also offers a *Manager* reviewer, but the Graph page of `requestorManager` names only
  approval settings, so a manager reviewer is not supported here. Enabled reviews need at
  least one primary reviewer unless `is_self_review` is true; Learn does not state that rule,
  but a review without reviewers cannot be completed.
- **Recurrence.** Learn says access reviews support only the `weekly` and `absoluteMonthly`
  patterns, with `interval`, `type` and `dayOfMonth`. The admin center offers monthly,
  quarterly, bi-annual and annual reviews; the module expresses them as `absoluteMonthly` with
  an interval of 1, 3, 6 or 12, and whether the admin center shows such a policy with the
  same frequency is not verified. The [recurrencePattern](https://learn.microsoft.com/en-us/graph/api/resources/recurrencepattern?view=graph-rest-1.0)
  page requires `dayOfMonth` with `absoluteMonthly`, so the module always sends one: the
  configured day, or the day of `start_date_time`. An `endDate` range is not supported by the module, because
  Learn does not say which range properties an access package review accepts; the Learn
  example of a policy with reviews uses `noEnd` with `numberOfOccurrences` 0, which the module
  sends the same way, and a `numbered` range is not verified.
- **The start is an input.** Pass a fixed `start_date_time`. A value from `timestamp()` would
  change on every plan and update the policy on every apply.
- **Turning reviews off.** Set `is_enabled = false` and keep the other settings. That sends
  `isEnabled: false` explicitly. Setting `review_settings` back to null does not: see
  [Limits and lifecycle](#limits-and-lifecycle).
- **Licensing.** Learn names Microsoft Entra ID Governance or Microsoft Entra Suite as the
  prerequisite of access reviews of access packages, for the reviewers and the users whose
  access is reviewed; see [Licensing and prerequisites](#licensing-and-prerequisites).

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

## Limits and lifecycle

- **Every update is a full-body `PUT`.** Graph's assignment policy endpoint is updated with
  `PUT`, and the module sends every key it manages on each update.
- **`reviewSettings` is sent only when `review_settings` is set.** With the default `null`
  the request body has no `reviewSettings` key, so a policy without reviews sends the same body
  as before the input existed (`tests/request_body_compatibility.tftest.hcl`). The update
  reference lists `reviewSettings` among the properties required on a `PUT`, yet its own first
  example omits it, and Learn does not say what Graph does with reviews that a `PUT` body
  leaves out. The consequences, none verified:
  - Reviews that were configured in the admin center or by another tool on a policy this
    module manages may be kept or removed by the next apply. While the input is null the
    module neither sends nor reads back `reviewSettings`, so it does not report such reviews.
  - Changing `review_settings` from an object back to `null` sends a body without
    `reviewSettings`, which may leave the reviews enabled. To stop reviews, set
    `is_enabled = false` and apply before you remove the input.
  - While `review_settings` is set, the provider compares the configured `reviewSettings` with
    what Graph returns. If Graph returns a value in another form, such as `startDateTime` with
    fractional seconds or `dayOfMonth` 0, the plan shows an in-place update after every apply.
- **The start date stays in the body.** After the first review has started,
  `schedule.start_date_time` is in the past, and every later update sends it again. Whether
  Graph accepts a past start on an update, and whether it restarts the schedule, is not
  verified.
- **Questions are replaced as a list.** The module sends the configured questions on every
  update without IDs; see [Requestor questions](#requestor-questions) for what is not
  verified about how Graph matches them.
- Remove a binding and delete its extension in two applies. Graph refuses to delete an extension
  that a policy still uses, and once the binding is gone from the configuration Terraform has no
  reference that orders the two.
- On a plan that creates the policy, Terraform reports that the result of
  `undeclared_custom_extension_bindings` is known after apply. In a `terraform test` run with
  `command = plan` that creates a policy through this module, that is an error
  ("Check block assertion known after apply"), and `expect_failures` cannot name a check inside
  a module. Run it with `command = apply`, or with Terraform 1.7 or later add an
  `override_module` block for the module.
- `api_version = "beta"` sends the same body, including `customExtensionStageSettings`,
  `reviewSettings` and both question types. The documented contract is v1.0, and beta is not
  verified.
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

## Upgrading to a release with access reviews and multiple choice questions

Nothing changes for a caller that uses neither `review_settings` nor a new question attribute:
the request body is byte-identical, so the first plan after the upgrade shows no change of
the policy. The `questions` input has a new type, with the new attributes optional, and new
validations that check only the new attributes. Adding `review_settings` to an existing policy
updates it in place with a body that now carries `reviewSettings`.

## Live test status

Live test status: not verified in a licensed tenant. Questions and access reviews are tested
with a mock provider only. These checks are pending, and each needs a tenant licensed for
Microsoft Entra ID Governance:

1. Create a policy with quarterly reviews by a group, and read back `reviewSettings`: whether
   Graph returns `startDateTime`, the expiration and the recurrence as sent (a different form
   is a permanent diff).
2. Update that policy with a full-body `PUT` after the start date has passed.
3. Update a policy that has reviews with a body without `reviewSettings`, and record whether
   the reviews are kept or removed. The same for `is_enabled = false`.
4. A `numbered` range, a `weekly` pattern, `dayOfMonth`, `singleUser` reviewers and fallback
   reviewers, self-reviews without reviewers, and whether Graph rejects enabled reviews without
   reviewers.
5. Whether the admin center shows `absoluteMonthly` reviews with an interval of 3 as quarterly.
6. Create a policy with a multiple choice question with localized choices, and a text question
   with `isSingleLineQuestion` and `regexPattern`; read them back, with and without
   `$expand=questions`.
7. Update the questions of a policy that has answered requests, and record whether question IDs
   and earlier answers survive.
8. Whether Graph accepts a language code without a country, and whether it keeps its case.

## Tests

The offline suites run against a mock provider: `terraform init` and `terraform test` in this
folder. `tests/assignment_policy.tftest.hcl` covers the base body and validations,
`tests/request_body_compatibility.tftest.hcl` compares whole request bodies with the ones the
previous release built, `tests/questions.tftest.hcl` covers both question types and their
validations, `tests/review_settings.tftest.hcl` covers the review bodies, a reviewer group that
the same apply creates and every review validation, and the `custom_extension_*` files cover
the bindings, their guards and read-back. A mock provider does not read the error messages, so
Python tests (`tests/test_assignment_policy_custom_extensions.py` and
`tests/test_assignment_policy_reviews_questions.py`) check the wording of every validation.
`tests/integration` holds the live suite, which does not cover questions or reviews yet.
