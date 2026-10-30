# /identityGovernance/accessReviews/definitions

Create definitions

[Catalog](../../../README.md) Â· [Identity and access](../../../README.md#identity-and-access) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/accessreviewscheduledefinition?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/accessReviews/definitions`, `GET/PUT/DELETE /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/identity-governance/access-reviews/definitions"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Full-body update (PUT)

Microsoft Graph updates this object with `PUT /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}`, which replaces the whole writable object, and the provider sends the planned request body as it is. Every update therefore sends the complete body that the inputs produce (`local.body`), not only the inputs that changed.

- **Unmodelled properties are lost on update.** A writable property that the module does not model, or that is set outside Terraform, is not in the body, so Graph resets it to its default or removes it. The pinned update schema lists no writable property without an input, but Microsoft Learn can document more.
- **Update-required nested ids must be set.** The generator admits the endpoint only when every property that the update requires, nested ids included, is guaranteed non-null by an input, so supply each nested id that an object input names as required.
- **Do not import or adopt existing objects.** Import records the identity and URL without a body and a refresh reconciles only keys already in the body, so neither shows which writable properties the configuration omits. The first apply after an import would send a `PUT` that overwrites them.
- The omission effect of each property, server-default normalization and the preservation of unowned fields have not been reviewed for this endpoint.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `additional_notification_recipients` | `additionalNotificationRecipients` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewNotificationRecipientItem")       notificationRecipientScope = optional(any)       notificationTemplateType = optional(string)     }))` | no | no | in place |
| `description_for_admins` | `descriptionForAdmins` | `string` | no | no | in place |
| `description_for_reviewers` | `descriptionForReviewers` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `fallback_reviewers` | `fallbackReviewers` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     }))` | no | no | in place |
| `instance_enumeration_scope` | `instanceEnumerationScope` | `any` | no | no | in place |
| `instances` | `instances` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstance")       decisions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstanceDecisionItem")       decision = optional(string)       insights = optional(any)       justification = optional(string)     })))       fallbackReviewers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     })))       reviewers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     })))       stages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewStage")       decisions = optional(any)       fallbackReviewers = optional(any)       reviewers = optional(any)     })))     }))` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `reviewers` | `reviewers` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     }))` | no | no | in place |
| `scope` | `scope` | `any` | no | no | in place |
| `settings` | `settings` | `object({       odata_type = optional(string, "#microsoft.graph.accessReviewScheduleSettings")       applyActions = optional(any)       autoApplyDecisionsEnabled = optional(bool)       decisionHistoriesForReviewersEnabled = optional(bool)       defaultDecision = optional(string)       defaultDecisionEnabled = optional(bool)       instanceDurationInDays = optional(number)       justificationRequiredOnApproval = optional(bool)       mailNotificationsEnabled = optional(bool)       recommendationInsightSettings = optional(any)       recommendationLookBackDuration = optional(string)       recommendationsEnabled = optional(bool)       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       reminderNotificationsEnabled = optional(bool)     })` | no | no | in place |
| `stage_settings` | `stageSettings` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewStageSettings")       decisionsThatWillMoveToNextStage = optional(list(string))       dependsOn = optional(list(string))       durationInDays = optional(number)       fallbackReviewers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     })))       recommendationInsightSettings = optional(any)       recommendationsEnabled = optional(bool)       reviewers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     })))       stageId = optional(string)     }))` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `createdBy`, `createdDateTime`, `id`, `lastModifiedDateTime`, `status`.

Import and adoption are not supported (see Full-body update (PUT)): create the object with this module.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /identityGovernance/accessReviews/definitions` | DelegatedWork | `AccessReview.ReadWrite.All` | — |
| `POST /identityGovernance/accessReviews/definitions` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /identityGovernance/accessReviews/definitions` | Application | `AccessReview.ReadWrite.All` | — |
| `GET /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}` | DelegatedWork | `AccessReview.Read.All` | — |
| `GET /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}` | DelegatedWork | `AccessReview.ReadWrite.All` | — |
| `GET /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}` | Application | `AccessReview.Read.All` | — |
| `GET /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}` | Application | `AccessReview.ReadWrite.All` | — |
| `PUT /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}` | DelegatedWork | `AccessReview.ReadWrite.All` | — |
| `PUT /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PUT /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}` | Application | `AccessReview.ReadWrite.All` | — |
| `DELETE /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}` | DelegatedWork | `AccessReview.ReadWrite.All` | — |
| `DELETE /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /identityGovernance/accessReviews/definitions/{accessReviewScheduleDefinition-id}` | Application | `AccessReview.ReadWrite.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- additionalNotificationRecipients[].notificationRecipientScope: polymorphic schema; accepts an untyped value
- instanceEnumerationScope: polymorphic schema; accepts an untyped value
- instances[].decisions[].insights[]: nested schema exceeds depth limit; accepts an untyped value
- instances[].stages[].decisions[]: nested schema exceeds depth limit; accepts an untyped value
- instances[].stages[].fallbackReviewers[]: nested schema exceeds depth limit; accepts an untyped value
- instances[].stages[].reviewers[]: nested schema exceeds depth limit; accepts an untyped value
- scope: polymorphic schema; accepts an untyped value
- settings.applyActions[]: object without documented properties; accepts an untyped value
- settings.recommendationInsightSettings[]: object without documented properties; accepts an untyped value
- stageSettings[].recommendationInsightSettings[]: object without documented properties; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
