# /auditLogs/directoryAudits

Create new navigation property to directoryAudits for auditLogs

[Catalog](../../../README.md) · [Reports](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/directoryaudit?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /auditLogs/directoryAudits`, `GET/PATCH/DELETE /auditLogs/directoryAudits/{directoryAudit-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./reports/audit-logs/directory-audits"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `activity_date_time` | `activityDateTime` | `string` | no | no |
| `activity_display_name` | `activityDisplayName` | `string` | no | no |
| `additional_details` | `additionalDetails` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     }))` | no | no |
| `category` | `category` | `string` | no | no |
| `correlation_id` | `correlationId` | `string` | no | no |
| `initiated_by` | `initiatedBy` | `object({       odata_type = optional(string, "#microsoft.graph.auditActivityInitiator")       app = optional(any)       user = optional(any)     })` | no | no |
| `logged_by_service` | `loggedByService` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operation_type` | `operationType` | `string` | no | no |
| `result` | `result` | `any` | no | no |
| `result_reason` | `resultReason` | `string` | no | no |
| `target_resources` | `targetResources` | `list(object({       odata_type = optional(string, "#microsoft.graph.targetResource")       displayName = optional(string)       groupType = optional(any)       id = optional(string)       modifiedProperties = optional(list(object({       odata_type = optional(string, "#microsoft.graph.modifiedProperty")       displayName = optional(string)       newValue = optional(string)       oldValue = optional(string)     })))       type = optional(string)       userPrincipalName = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- initiatedBy.app: polymorphic schema; accepts an untyped value
- initiatedBy.user: polymorphic schema; accepts an untyped value
- result: polymorphic schema; accepts an untyped value
- targetResources[].groupType: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
