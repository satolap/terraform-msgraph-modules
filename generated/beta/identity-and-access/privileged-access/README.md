# /privilegedAccess

Add new entity to privilegedAccess

[Catalog](../../README.md) · [Identity and access](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /privilegedAccess`, `GET/PATCH/DELETE /privilegedAccess/{privilegedAccess-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/privileged-access"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `display_name` | `displayName` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `resources` | `resources` | `list(object({       odata_type = optional(string, "#microsoft.graph.governanceResource")       displayName = optional(string)       externalId = optional(string)       registeredDateTime = optional(string)       registeredRoot = optional(string)       roleAssignmentRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.governanceRoleAssignmentRequest")       assignmentState = optional(string)       linkedEligibleRoleAssignmentId = optional(string)       reason = optional(string)       resourceId = optional(string)       roleDefinitionId = optional(string)       schedule = optional(any)       status = optional(any)       subjectId = optional(string)       type = optional(string)     })))       roleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.governanceRoleAssignment")       assignmentState = optional(string)       endDateTime = optional(string)       externalId = optional(string)       linkedEligibleRoleAssignmentId = optional(string)       memberType = optional(string)       resourceId = optional(string)       roleDefinitionId = optional(string)       startDateTime = optional(string)       status = optional(string)       subjectId = optional(string)     })))       roleDefinitions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.governanceRoleDefinition")       displayName = optional(string)       externalId = optional(string)       resourceId = optional(string)       roleSetting = optional(any)       templateId = optional(string)     })))       roleSettings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.governanceRoleSetting")       adminEligibleSettings = optional(any)       adminMemberSettings = optional(any)       resourceId = optional(string)       roleDefinitionId = optional(string)       userEligibleSettings = optional(any)       userMemberSettings = optional(any)     })))       status = optional(string)       type = optional(string)     }))` | no | no |
| `role_assignment_requests` | `roleAssignmentRequests` | `list(object({       odata_type = optional(string, "#microsoft.graph.governanceRoleAssignmentRequest")       assignmentState = optional(string)       linkedEligibleRoleAssignmentId = optional(string)       reason = optional(string)       resourceId = optional(string)       roleDefinitionId = optional(string)       schedule = optional(any)       status = optional(any)       subjectId = optional(string)       type = optional(string)     }))` | no | no |
| `role_assignments` | `roleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.governanceRoleAssignment")       assignmentState = optional(string)       endDateTime = optional(string)       externalId = optional(string)       linkedEligibleRoleAssignmentId = optional(string)       memberType = optional(string)       resourceId = optional(string)       roleDefinitionId = optional(string)       startDateTime = optional(string)       status = optional(string)       subjectId = optional(string)     }))` | no | no |
| `role_definitions` | `roleDefinitions` | `list(object({       odata_type = optional(string, "#microsoft.graph.governanceRoleDefinition")       displayName = optional(string)       externalId = optional(string)       resourceId = optional(string)       roleSetting = optional(any)       templateId = optional(string)     }))` | no | no |
| `role_settings` | `roleSettings` | `list(object({       odata_type = optional(string, "#microsoft.graph.governanceRoleSetting")       adminEligibleSettings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.governanceRuleSetting")       ruleIdentifier = optional(string)       setting = optional(string)     })))       adminMemberSettings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.governanceRuleSetting")       ruleIdentifier = optional(string)       setting = optional(string)     })))       resourceId = optional(string)       roleDefinitionId = optional(string)       userEligibleSettings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.governanceRuleSetting")       ruleIdentifier = optional(string)       setting = optional(string)     })))       userMemberSettings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.governanceRuleSetting")       ruleIdentifier = optional(string)       setting = optional(string)     })))     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- resources[].roleAssignmentRequests[].schedule: polymorphic schema; accepts an untyped value
- resources[].roleAssignmentRequests[].status: polymorphic schema; accepts an untyped value
- resources[].roleDefinitions[].roleSetting: polymorphic schema; accepts an untyped value
- resources[].roleSettings[].adminEligibleSettings[]: nested schema exceeds depth limit; accepts an untyped value
- resources[].roleSettings[].adminMemberSettings[]: nested schema exceeds depth limit; accepts an untyped value
- resources[].roleSettings[].userEligibleSettings[]: nested schema exceeds depth limit; accepts an untyped value
- resources[].roleSettings[].userMemberSettings[]: nested schema exceeds depth limit; accepts an untyped value
- roleAssignmentRequests[].schedule: polymorphic schema; accepts an untyped value
- roleAssignmentRequests[].status: polymorphic schema; accepts an untyped value
- roleDefinitions[].roleSetting: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
