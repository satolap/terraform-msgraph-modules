# /roleManagement/entitlementManagement/roleAssignmentScheduleRequests

Create new navigation property to roleAssignmentScheduleRequests for roleManagement

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/unifiedroleassignmentschedulerequest?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /roleManagement/entitlementManagement/roleAssignmentScheduleRequests`, `GET/PATCH/DELETE /roleManagement/entitlementManagement/roleAssignmentScheduleRequests/{unifiedRoleAssignmentScheduleRequest-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/identity-and-access/role-management/entitlement-management/role-assignment-schedule-requests?ref=<release-tag>"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `action` | `action` | `string` | no | no |
| `activated_using` | `activatedUsing` | `any` | no | no |
| `app_scope_id` | `appScopeId` | `string` | no | no |
| `approval_id` | `approvalId` | `string` | no | no |
| `completed_date_time` | `completedDateTime` | `string` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `custom_data` | `customData` | `string` | no | no |
| `directory_scope_id` | `directoryScopeId` | `string` | no | no |
| `is_validation_only` | `isValidationOnly` | `bool` | no | no |
| `justification` | `justification` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `principal` | `principal` | `any` | no | no |
| `principal_id` | `principalId` | `string` | no | no |
| `role_definition` | `roleDefinition` | `any` | no | no |
| `role_definition_id` | `roleDefinitionId` | `string` | no | no |
| `schedule_info` | `scheduleInfo` | `object({       odata_type = optional(string, "#microsoft.graph.requestSchedule")       expiration = optional(object({       odata_type = optional(string, "#microsoft.graph.expirationPattern")       duration = optional(string)       endDateTime = optional(string)       type = optional(string)     }))       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       startDateTime = optional(string)     })` | no | no |
| `status` | `status` | `string` | no | no |
| `target_schedule` | `targetSchedule` | `any` | no | no |
| `target_schedule_id` | `targetScheduleId` | `string` | no | no |
| `ticket_info` | `ticketInfo` | `object({       odata_type = optional(string, "#microsoft.graph.ticketInfo")       ticketApproverIdentityId = optional(string)       ticketNumber = optional(string)       ticketSubmitterIdentityId = optional(string)       ticketSystem = optional(string)     })` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- activatedUsing: navigation property; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- principal: polymorphic schema; accepts an untyped value
- roleDefinition: navigation property; accepts an untyped value
- targetSchedule: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
