# /roleManagement/enterpriseApps

Create new navigation property to enterpriseApps for roleManagement

[Catalog](../../../README.md) · [Identity and access](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /roleManagement/enterpriseApps`, `GET/PATCH/DELETE /roleManagement/enterpriseApps/{rbacApplication-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/identity-and-access/role-management/enterprise-apps?ref=<release-tag>"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `odata_type` | `@odata.type` | `string` | no | no |
| `resource_namespaces` | `resourceNamespaces` | `list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRbacResourceNamespace")       name = optional(string)       resourceActions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRbacResourceAction")       actionVerb = optional(string)       authenticationContext = optional(any)       authenticationContextId = optional(string)       description = optional(string)       isAuthenticationContextSettable = optional(bool)       name = optional(string)       resourceScope = optional(any)       resourceScopeId = optional(string)     })))     }))` | no | no |
| `role_assignment_approvals` | `roleAssignmentApprovals` | `list(object({       odata_type = optional(string, "#microsoft.graph.approval")       steps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.approvalStep")       justification = optional(string)       reviewResult = optional(string)     })))     }))` | no | no |
| `role_assignment_schedule_instances` | `roleAssignmentScheduleInstances` | `list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRoleAssignmentScheduleInstance")       activatedUsing = optional(any)       appScopeId = optional(string)       assignmentType = optional(string)       directoryScopeId = optional(string)       endDateTime = optional(string)       memberType = optional(string)       principal = optional(any)       principalId = optional(string)       roleAssignmentOriginId = optional(string)       roleAssignmentScheduleId = optional(string)       roleDefinition = optional(any)       roleDefinitionId = optional(string)       startDateTime = optional(string)     }))` | no | no |
| `role_assignment_schedule_requests` | `roleAssignmentScheduleRequests` | `list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRoleAssignmentScheduleRequest")       action = optional(string)       activatedUsing = optional(any)       appScopeId = optional(string)       approvalId = optional(string)       completedDateTime = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       customData = optional(string)       directoryScopeId = optional(string)       isValidationOnly = optional(bool)       justification = optional(string)       principal = optional(any)       principalId = optional(string)       roleDefinition = optional(any)       roleDefinitionId = optional(string)       scheduleInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.requestSchedule")       expiration = optional(object({       odata_type = optional(string, "#microsoft.graph.expirationPattern")       duration = optional(string)       endDateTime = optional(string)       type = optional(string)     }))       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(any)       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       startDateTime = optional(string)     }))       status = optional(string)       targetSchedule = optional(any)       targetScheduleId = optional(string)       ticketInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.ticketInfo")       ticketApproverIdentityId = optional(string)       ticketNumber = optional(string)       ticketSubmitterIdentityId = optional(string)       ticketSystem = optional(string)     }))     }))` | no | no |
| `role_assignment_schedules` | `roleAssignmentSchedules` | `list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRoleAssignmentSchedule")       activatedUsing = optional(any)       appScopeId = optional(string)       assignmentType = optional(string)       createdDateTime = optional(string)       createdUsing = optional(string)       directoryScopeId = optional(string)       memberType = optional(string)       modifiedDateTime = optional(string)       principal = optional(any)       principalId = optional(string)       roleDefinition = optional(any)       roleDefinitionId = optional(string)       scheduleInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.requestSchedule")       expiration = optional(object({       odata_type = optional(string, "#microsoft.graph.expirationPattern")       duration = optional(string)       endDateTime = optional(string)       type = optional(string)     }))       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(any)       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       startDateTime = optional(string)     }))       status = optional(string)     }))` | no | no |
| `role_assignments` | `roleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRoleAssignment")       appScopeId = optional(string)       condition = optional(string)       directoryScopeId = optional(string)       principalId = optional(string)       principalOrganizationId = optional(string)       resourceScope = optional(string)       roleDefinition = optional(any)     }))` | no | no |
| `role_definitions` | `roleDefinitions` | `list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRoleDefinition")     }))` | no | no |
| `role_eligibility_schedule_instances` | `roleEligibilityScheduleInstances` | `list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRoleEligibilityScheduleInstance")       appScopeId = optional(string)       directoryScopeId = optional(string)       endDateTime = optional(string)       memberType = optional(string)       principal = optional(any)       principalId = optional(string)       roleDefinition = optional(any)       roleDefinitionId = optional(string)       roleEligibilityScheduleId = optional(string)       startDateTime = optional(string)     }))` | no | no |
| `role_eligibility_schedule_requests` | `roleEligibilityScheduleRequests` | `list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRoleEligibilityScheduleRequest")       action = optional(string)       appScopeId = optional(string)       approvalId = optional(string)       completedDateTime = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       customData = optional(string)       directoryScopeId = optional(string)       isValidationOnly = optional(bool)       justification = optional(string)       principal = optional(any)       principalId = optional(string)       roleDefinition = optional(any)       roleDefinitionId = optional(string)       scheduleInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.requestSchedule")       expiration = optional(object({       odata_type = optional(string, "#microsoft.graph.expirationPattern")       duration = optional(string)       endDateTime = optional(string)       type = optional(string)     }))       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(any)       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       startDateTime = optional(string)     }))       status = optional(string)       targetSchedule = optional(any)       targetScheduleId = optional(string)       ticketInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.ticketInfo")       ticketApproverIdentityId = optional(string)       ticketNumber = optional(string)       ticketSubmitterIdentityId = optional(string)       ticketSystem = optional(string)     }))     }))` | no | no |
| `role_eligibility_schedules` | `roleEligibilitySchedules` | `list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRoleEligibilitySchedule")       appScopeId = optional(string)       createdDateTime = optional(string)       createdUsing = optional(string)       directoryScopeId = optional(string)       memberType = optional(string)       modifiedDateTime = optional(string)       principal = optional(any)       principalId = optional(string)       roleDefinition = optional(any)       roleDefinitionId = optional(string)       scheduleInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.requestSchedule")       expiration = optional(object({       odata_type = optional(string, "#microsoft.graph.expirationPattern")       duration = optional(string)       endDateTime = optional(string)       type = optional(string)     }))       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(any)       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       startDateTime = optional(string)     }))       status = optional(string)     }))` | no | no |
| `transitive_role_assignments` | `transitiveRoleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRoleAssignment")       appScopeId = optional(string)       condition = optional(string)       directoryScopeId = optional(string)       principalId = optional(string)       principalOrganizationId = optional(string)       resourceScope = optional(string)       roleDefinition = optional(any)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- resourceNamespaces[].resourceActions[].authenticationContext: navigation property; accepts an untyped value
- resourceNamespaces[].resourceActions[].resourceScope: navigation property; accepts an untyped value
- roleAssignmentScheduleInstances[].activatedUsing: navigation property; accepts an untyped value
- roleAssignmentScheduleInstances[].principal: polymorphic schema; accepts an untyped value
- roleAssignmentScheduleInstances[].roleDefinition: navigation property; accepts an untyped value
- roleAssignmentScheduleRequests[].activatedUsing: navigation property; accepts an untyped value
- roleAssignmentScheduleRequests[].createdBy: polymorphic schema; accepts an untyped value
- roleAssignmentScheduleRequests[].principal: polymorphic schema; accepts an untyped value
- roleAssignmentScheduleRequests[].roleDefinition: navigation property; accepts an untyped value
- roleAssignmentScheduleRequests[].scheduleInfo.recurrence.pattern.daysOfWeek: nested schema exceeds depth limit; accepts an untyped value
- roleAssignmentScheduleRequests[].targetSchedule: navigation property; accepts an untyped value
- roleAssignmentSchedules[].activatedUsing: navigation property; accepts an untyped value
- roleAssignmentSchedules[].principal: polymorphic schema; accepts an untyped value
- roleAssignmentSchedules[].roleDefinition: navigation property; accepts an untyped value
- roleAssignmentSchedules[].scheduleInfo.recurrence.pattern.daysOfWeek: nested schema exceeds depth limit; accepts an untyped value
- roleAssignments[].roleDefinition: navigation property; accepts an untyped value
- roleEligibilityScheduleInstances[].principal: polymorphic schema; accepts an untyped value
- roleEligibilityScheduleInstances[].roleDefinition: navigation property; accepts an untyped value
- roleEligibilityScheduleRequests[].createdBy: polymorphic schema; accepts an untyped value
- roleEligibilityScheduleRequests[].principal: polymorphic schema; accepts an untyped value
- roleEligibilityScheduleRequests[].roleDefinition: navigation property; accepts an untyped value
- roleEligibilityScheduleRequests[].scheduleInfo.recurrence.pattern.daysOfWeek: nested schema exceeds depth limit; accepts an untyped value
- roleEligibilityScheduleRequests[].targetSchedule: navigation property; accepts an untyped value
- roleEligibilitySchedules[].principal: polymorphic schema; accepts an untyped value
- roleEligibilitySchedules[].roleDefinition: navigation property; accepts an untyped value
- roleEligibilitySchedules[].scheduleInfo.recurrence.pattern.daysOfWeek: nested schema exceeds depth limit; accepts an untyped value
- transitiveRoleAssignments[].roleDefinition: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
