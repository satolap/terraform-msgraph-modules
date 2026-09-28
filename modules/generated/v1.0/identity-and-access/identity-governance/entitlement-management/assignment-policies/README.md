# /identityGovernance/entitlementManagement/assignmentPolicies

Create assignmentPolicies

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageassignmentpolicy?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/entitlementManagement/assignmentPolicies`, `GET/PUT/DELETE /identityGovernance/entitlementManagement/assignmentPolicies/{accessPackageAssignmentPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-governance/entitlement-management/assignment-policies"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `allowed_target_scope` | `allowedTargetScope` | `string` | no | no |
| `automatic_request_settings` | `automaticRequestSettings` | `object({       odata_type = optional(string, "#microsoft.graph.accessPackageAutomaticRequestSettings")       gracePeriodBeforeAccessRemoval = optional(string)       removeAccessWhenTargetLeavesAllowedTargets = optional(bool)       requestAccessForAllowedTargets = optional(bool)     })` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `custom_extension_stage_settings` | `customExtensionStageSettings` | `list(object({       odata_type = optional(string, "#microsoft.graph.customExtensionStageSetting")       customExtension = optional(any)       stage = optional(string)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `expiration` | `expiration` | `object({       odata_type = optional(string, "#microsoft.graph.expirationPattern")       duration = optional(string)       endDateTime = optional(string)       type = optional(string)     })` | no | no |
| `modified_date_time` | `modifiedDateTime` | `string` | no | no |
| `notification_settings` | `notificationSettings` | `object({       odata_type = optional(string, "#microsoft.graph.accessPackageNotificationSettings")       isAssignmentNotificationDisabled = optional(bool)     })` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `questions` | `questions` | `any` | no | no |
| `request_approval_settings` | `requestApprovalSettings` | `object({       odata_type = optional(string, "#microsoft.graph.accessPackageAssignmentApprovalSettings")       isApprovalRequiredForAdd = optional(bool)       isApprovalRequiredForUpdate = optional(bool)       isRequestorJustificationRequired = optional(bool)       stages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageApprovalStage")       approverInformationVisibility = optional(string)       durationBeforeAutomaticDenial = optional(string)       durationBeforeEscalation = optional(string)       escalationApprovers = optional(any)       fallbackEscalationApprovers = optional(any)       fallbackPrimaryApprovers = optional(any)       isApproverJustificationRequired = optional(bool)       isEscalationEnabled = optional(bool)       primaryApprovers = optional(any)     })))     })` | no | no |
| `requestor_settings` | `requestorSettings` | `object({       odata_type = optional(string, "#microsoft.graph.accessPackageAssignmentRequestorSettings")       allowCustomAssignmentSchedule = optional(bool)       enableOnBehalfRequestorsToAddAccess = optional(bool)       enableOnBehalfRequestorsToRemoveAccess = optional(bool)       enableOnBehalfRequestorsToUpdateAccess = optional(bool)       enableTargetsToSelfAddAccess = optional(bool)       enableTargetsToSelfRemoveAccess = optional(bool)       enableTargetsToSelfUpdateAccess = optional(bool)       onBehalfRequestors = optional(any)     })` | no | no |
| `review_settings` | `reviewSettings` | `object({       odata_type = optional(string, "#microsoft.graph.accessPackageAssignmentReviewSettings")       expirationBehavior = optional(string)       fallbackReviewers = optional(any)       isEnabled = optional(bool)       isRecommendationEnabled = optional(bool)       isReviewerJustificationRequired = optional(bool)       isSelfReview = optional(bool)       primaryReviewers = optional(any)       schedule = optional(object({       odata_type = optional(string, "#microsoft.graph.entitlementManagementSchedule")       expiration = optional(object({       odata_type = optional(string, "#microsoft.graph.expirationPattern")       duration = optional(string)       endDateTime = optional(string)       type = optional(string)     }))       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       startDateTime = optional(string)     }))     })` | no | no |
| `specific_allowed_targets` | `specificAllowedTargets` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- customExtensionStageSettings[].customExtension: polymorphic schema; accepts an untyped value
- questions[]: polymorphic schema; accepts an untyped value
- requestApprovalSettings.stages[].escalationApprovers[]: object without documented properties; accepts an untyped value
- requestApprovalSettings.stages[].fallbackEscalationApprovers[]: object without documented properties; accepts an untyped value
- requestApprovalSettings.stages[].fallbackPrimaryApprovers[]: object without documented properties; accepts an untyped value
- requestApprovalSettings.stages[].primaryApprovers[]: object without documented properties; accepts an untyped value
- requestorSettings.onBehalfRequestors[]: object without documented properties; accepts an untyped value
- reviewSettings.fallbackReviewers[]: object without documented properties; accepts an untyped value
- reviewSettings.primaryReviewers[]: object without documented properties; accepts an untyped value
- specificAllowedTargets[]: object without documented properties; accepts an untyped value

## Licensing and prerequisites

Baseline rules reviewed on 2026-09-18 for the equivalent curated module `curated/identity-governance/entitlement-management/assignment-policies` (confidence: inferred). Input-dependent rules were not re-verified against this module's inputs.

- **EM-CORE**: Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). Coverage: Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing. Assignment: direct; capacity: per_user. Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
