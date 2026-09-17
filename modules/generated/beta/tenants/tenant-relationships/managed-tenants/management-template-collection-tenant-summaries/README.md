# /tenantRelationships/managedTenants/managementTemplateCollectionTenantSummaries

Create new navigation property to managementTemplateCollectionTenantSummaries for tenantRelationships

[Catalog](../../../../README.md) · [Tenants](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/tenants-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /tenantRelationships/managedTenants/managementTemplateCollectionTenantSummaries`, `GET/PATCH/DELETE /tenantRelationships/managedTenants/managementTemplateCollectionTenantSummaries/{managementTemplateCollectionTenantSummary-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./tenants/tenant-relationships/managed-tenants/management-template-collection-tenant-summaries"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `complete_steps_count` | `completeStepsCount` | `number` | no | no |
| `complete_users_count` | `completeUsersCount` | `number` | no | no |
| `created_by_user_id` | `createdByUserId` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `dismissed_steps_count` | `dismissedStepsCount` | `number` | no | no |
| `excluded_users_count` | `excludedUsersCount` | `number` | no | no |
| `excluded_users_distinct_count` | `excludedUsersDistinctCount` | `number` | no | no |
| `incomplete_steps_count` | `incompleteStepsCount` | `number` | no | no |
| `incomplete_users_count` | `incompleteUsersCount` | `number` | no | no |
| `ineligible_steps_count` | `ineligibleStepsCount` | `number` | no | no |
| `is_complete` | `isComplete` | `bool` | no | no |
| `last_action_by_user_id` | `lastActionByUserId` | `string` | no | no |
| `last_action_date_time` | `lastActionDateTime` | `string` | no | no |
| `management_template_collection_display_name` | `managementTemplateCollectionDisplayName` | `string` | no | no |
| `management_template_collection_id` | `managementTemplateCollectionId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `regressed_steps_count` | `regressedStepsCount` | `number` | no | no |
| `regressed_users_count` | `regressedUsersCount` | `number` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `unlicensed_users_count` | `unlicensedUsersCount` | `number` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
