# /approvalWorkflowProviders/{approvalWorkflowProvider-id}/businessFlows

Create new navigation property to businessFlows for approvalWorkflowProviders

[Catalog](../../../../README.md) · [Uncategorized](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /approvalWorkflowProviders/{approvalWorkflowProvider-id}/businessFlows`, `GET/PATCH/DELETE /approvalWorkflowProviders/{approvalWorkflowProvider-id}/businessFlows/{businessFlow-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/other/approval-workflow-providers/by-approval-workflow-provider-id/business-flows?ref=<release-tag>"
  approval_workflow_provider_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `approval_workflow_provider_id` | URL parameter `approvalWorkflowProvider-id` | `string` | yes | no |
| `custom_data` | `customData` | `string` | no | no |
| `de_duplication_id` | `deDuplicationId` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `policy` | `policy` | `object({       odata_type = optional(string, "#microsoft.graph.governancePolicy")       decisionMakerCriteria = optional(any)       notificationPolicy = optional(object({       odata_type = optional(string, "#microsoft.graph.governanceNotificationPolicy")       enabledTemplateTypes = optional(list(string))       notificationTemplates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.governanceNotificationTemplate")       culture = optional(string)       id = optional(string)       source = optional(string)       type = optional(string)       version = optional(string)     })))     }))     })` | no | no |
| `policy_template_id` | `policyTemplateId` | `string` | no | no |
| `record_version` | `recordVersion` | `string` | no | no |
| `schema_id` | `schemaId` | `string` | no | no |
| `settings` | `settings` | `object({       odata_type = optional(string, "#microsoft.graph.businessFlowSettings")       accessRecommendationsEnabled = optional(bool)       activityDurationInDays = optional(number)       autoApplyReviewResultsEnabled = optional(bool)       autoReviewEnabled = optional(bool)       autoReviewSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.autoReviewSettings")       notReviewedResult = optional(string)     }))       durationInDays = optional(number)       justificationRequiredOnApproval = optional(bool)       mailNotificationsEnabled = optional(bool)       recurrenceSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.accessReviewRecurrenceSettings")       durationInDays = optional(number)       recurrenceCount = optional(number)       recurrenceEndType = optional(string)       recurrenceType = optional(string)     }))       remindersEnabled = optional(bool)     })` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- policy.decisionMakerCriteria[]: object without documented properties; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
