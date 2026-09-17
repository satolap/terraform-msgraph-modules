# /tenantRelationships/managedTenants/managementTemplateStepVersions/{managementTemplateStepVersion-id}/deployments

Create new navigation property to deployments for tenantRelationships

[Catalog](../../../../../../README.md) · [Tenants](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/tenants-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /tenantRelationships/managedTenants/managementTemplateStepVersions/{managementTemplateStepVersion-id}/deployments`, `GET/PATCH/DELETE /tenantRelationships/managedTenants/managementTemplateStepVersions/{managementTemplateStepVersion-id}/deployments/{managementTemplateStepDeployment-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./tenants/tenant-relationships/managed-tenants/management-template-step-versions/by-management-template-step-version-id/deployments"
  management_template_step_version_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `management_template_step_version_id` | URL parameter `managementTemplateStepVersion-id` | `string` | yes | no |
| `created_by_user_id` | `createdByUserId` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `error` | `error` | `any` | no | no |
| `last_action_by_user_id` | `lastActionByUserId` | `string` | no | no |
| `last_action_date_time` | `lastActionDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `status` | `status` | `string` | no | no |
| `template_step_version` | `templateStepVersion` | `object({       odata_type = optional(string, "#microsoft.graph.managedTenants.managementTemplateStepVersion")       acceptedFor = optional(any)       contentMarkdown = optional(string)       createdByUserId = optional(string)       createdDateTime = optional(string)       deployments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.managementTemplateStepDeployment")       createdByUserId = optional(string)       createdDateTime = optional(string)       error = optional(any)       lastActionByUserId = optional(string)       lastActionDateTime = optional(string)       status = optional(string)       templateStepVersion = optional(any)       tenantId = optional(string)     })))       lastActionByUserId = optional(string)       lastActionDateTime = optional(string)       name = optional(string)       templateStep = optional(any)       version = optional(number)       versionInformation = optional(string)     })` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- error: polymorphic schema; accepts an untyped value
- templateStepVersion.acceptedFor: polymorphic schema; accepts an untyped value
- templateStepVersion.deployments[].error: polymorphic schema; accepts an untyped value
- templateStepVersion.deployments[].templateStepVersion: recursive schema; accepts an untyped value
- templateStepVersion.templateStep: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
