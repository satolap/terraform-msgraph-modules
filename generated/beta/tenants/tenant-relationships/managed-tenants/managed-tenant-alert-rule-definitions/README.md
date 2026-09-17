# /tenantRelationships/managedTenants/managedTenantAlertRuleDefinitions

Create new navigation property to managedTenantAlertRuleDefinitions for tenantRelationships

[Catalog](../../../../README.md) · [Tenants](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/tenants-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /tenantRelationships/managedTenants/managedTenantAlertRuleDefinitions`, `GET/PATCH/DELETE /tenantRelationships/managedTenants/managedTenantAlertRuleDefinitions/{managedTenantAlertRuleDefinition-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./tenants/tenant-relationships/managed-tenants/managed-tenant-alert-rule-definitions"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `alert_rules` | `alertRules` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.managedTenantAlertRule")       alertDisplayName = optional(string)       alertTTL = optional(number)       alerts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.managedTenantAlert")       alertData = optional(any)       alertDataReferenceStrings = optional(any)       alertLogs = optional(any)       alertRule = optional(any)       alertRuleDisplayName = optional(string)       apiNotifications = optional(any)       assignedToUserId = optional(string)       correlationCount = optional(number)       correlationId = optional(string)       createdByUserId = optional(string)       createdDateTime = optional(string)       emailNotifications = optional(any)       lastActionByUserId = optional(string)       lastActionDateTime = optional(string)       message = optional(string)       severity = optional(any)       status = optional(any)       tenantId = optional(string)       title = optional(string)     })))       createdByUserId = optional(string)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       lastActionByUserId = optional(string)       lastActionDateTime = optional(string)       lastRunDateTime = optional(string)       notificationFinalDestinations = optional(any)       ruleDefinition = optional(any)       severity = optional(any)       targets = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.notificationTarget")       displayName = optional(string)     })))       tenantIds = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.tenantInfo")       tenantId = optional(string)     })))     }))` | no | no |
| `created_by_user_id` | `createdByUserId` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `definition_template` | `definitionTemplate` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `last_action_by_user_id` | `lastActionByUserId` | `string` | no | no |
| `last_action_date_time` | `lastActionDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- alertRules[].alerts[].alertData: polymorphic schema; accepts an untyped value
- alertRules[].alerts[].alertDataReferenceStrings[]: nested schema exceeds depth limit; accepts an untyped value
- alertRules[].alerts[].alertLogs[]: nested schema exceeds depth limit; accepts an untyped value
- alertRules[].alerts[].alertRule: polymorphic schema; accepts an untyped value
- alertRules[].alerts[].apiNotifications[]: nested schema exceeds depth limit; accepts an untyped value
- alertRules[].alerts[].emailNotifications[]: nested schema exceeds depth limit; accepts an untyped value
- alertRules[].alerts[].severity: polymorphic schema; accepts an untyped value
- alertRules[].alerts[].status: polymorphic schema; accepts an untyped value
- alertRules[].notificationFinalDestinations: polymorphic schema; accepts an untyped value
- alertRules[].ruleDefinition: polymorphic schema; accepts an untyped value
- alertRules[].severity: polymorphic schema; accepts an untyped value
- definitionTemplate: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
