# /tenantRelationships/managedTenants/managedTenantAlerts

Create new navigation property to managedTenantAlerts for tenantRelationships

[Catalog](../../../../README.md) · [Tenants](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/tenants-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /tenantRelationships/managedTenants/managedTenantAlerts`, `GET/PATCH/DELETE /tenantRelationships/managedTenants/managedTenantAlerts/{managedTenantAlert-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./tenants/tenant-relationships/managed-tenants/managed-tenant-alerts"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `alert_data` | `alertData` | `any` | no | no |
| `alert_data_reference_strings` | `alertDataReferenceStrings` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.alertDataReferenceString")       displayName = optional(string)     }))` | no | no |
| `alert_logs` | `alertLogs` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.managedTenantAlertLog")       alert = optional(any)       content = optional(any)       createdByUserId = optional(string)       createdDateTime = optional(string)       lastActionByUserId = optional(string)       lastActionDateTime = optional(string)     }))` | no | no |
| `alert_rule` | `alertRule` | `any` | no | no |
| `alert_rule_display_name` | `alertRuleDisplayName` | `string` | no | no |
| `api_notifications` | `apiNotifications` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.managedTenantApiNotification")       alert = optional(any)       createdByUserId = optional(string)       createdDateTime = optional(string)       isAcknowledged = optional(bool)       lastActionByUserId = optional(string)       lastActionDateTime = optional(string)       message = optional(string)       title = optional(string)       userId = optional(string)     }))` | no | no |
| `assigned_to_user_id` | `assignedToUserId` | `string` | no | no |
| `correlation_count` | `correlationCount` | `number` | no | no |
| `correlation_id` | `correlationId` | `string` | no | no |
| `created_by_user_id` | `createdByUserId` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `email_notifications` | `emailNotifications` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.managedTenantEmailNotification")       alert = optional(any)       createdByUserId = optional(string)       createdDateTime = optional(string)       emailAddresses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.email")       emailAddress = optional(string)     })))       emailBody = optional(string)       lastActionByUserId = optional(string)       lastActionDateTime = optional(string)       subject = optional(string)     }))` | no | no |
| `last_action_by_user_id` | `lastActionByUserId` | `string` | no | no |
| `last_action_date_time` | `lastActionDateTime` | `string` | no | no |
| `message` | `message` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `severity` | `severity` | `any` | no | no |
| `status` | `status` | `any` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `title` | `title` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- alertData: polymorphic schema; accepts an untyped value
- alertLogs[].alert: polymorphic schema; accepts an untyped value
- alertLogs[].content: polymorphic schema; accepts an untyped value
- alertRule: polymorphic schema; accepts an untyped value
- apiNotifications[].alert: polymorphic schema; accepts an untyped value
- emailNotifications[].alert: polymorphic schema; accepts an untyped value
- severity: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
