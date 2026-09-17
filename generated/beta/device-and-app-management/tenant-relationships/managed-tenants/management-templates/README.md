# /tenantRelationships/managedTenants/managementTemplates

Create new navigation property to managementTemplates for tenantRelationships

[Catalog](../../../../README.md) · [Device and app management](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/managedtenants-managementtemplate?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /tenantRelationships/managedTenants/managementTemplates`, `GET/PATCH/DELETE /tenantRelationships/managedTenants/managementTemplates/{managementTemplate-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/tenant-relationships/managed-tenants/management-templates"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `created_by_user_id` | `createdByUserId` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `graph_provider` | `provider` | `string` | no | no |
| `graph_version` | `version` | `number` | no | no |
| `information_links` | `informationLinks` | `list(object({       odata_type = optional(string, "#microsoft.graph.actionUrl")       displayName = optional(string)       url = optional(string)     }))` | no | no |
| `last_action_by_user_id` | `lastActionByUserId` | `string` | no | no |
| `last_action_date_time` | `lastActionDateTime` | `string` | no | no |
| `management_template_collections` | `managementTemplateCollections` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.managementTemplateCollection")       createdByUserId = optional(string)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       lastActionByUserId = optional(string)       lastActionDateTime = optional(string)       managementTemplates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.managementTemplate")       createdByUserId = optional(string)       createdDateTime = optional(string)       informationLinks = optional(any)       lastActionByUserId = optional(string)       lastActionDateTime = optional(string)       managementTemplateCollections = optional(any)       managementTemplateSteps = optional(any)       priority = optional(number)       provider = optional(string)       userImpact = optional(string)       version = optional(number)     })))     }))` | no | no |
| `management_template_steps` | `managementTemplateSteps` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.managementTemplateStep")       acceptedVersion = optional(any)       category = optional(any)       createdByUserId = optional(string)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       informationLinks = optional(list(object({       odata_type = optional(string, "#microsoft.graph.actionUrl")       displayName = optional(string)       url = optional(string)     })))       lastActionByUserId = optional(string)       lastActionDateTime = optional(string)       managementTemplate = optional(any)       portalLink = optional(any)       priority = optional(number)       userImpact = optional(string)       versions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedTenants.managementTemplateStepVersion")       acceptedFor = optional(any)       contentMarkdown = optional(string)       createdByUserId = optional(string)       createdDateTime = optional(string)       deployments = optional(any)       lastActionByUserId = optional(string)       lastActionDateTime = optional(string)       name = optional(string)       templateStep = optional(any)       version = optional(number)       versionInformation = optional(string)     })))     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `priority` | `priority` | `number` | no | no |
| `user_impact` | `userImpact` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- managementTemplateCollections[].managementTemplates[].informationLinks[]: nested schema exceeds depth limit; accepts an untyped value
- managementTemplateCollections[].managementTemplates[].managementTemplateCollections[]: recursive schema; accepts an untyped value
- managementTemplateCollections[].managementTemplates[].managementTemplateSteps[]: nested schema exceeds depth limit; accepts an untyped value
- managementTemplateSteps[].acceptedVersion: polymorphic schema; accepts an untyped value
- managementTemplateSteps[].category: polymorphic schema; accepts an untyped value
- managementTemplateSteps[].managementTemplate: polymorphic schema; accepts an untyped value
- managementTemplateSteps[].portalLink: polymorphic schema; accepts an untyped value
- managementTemplateSteps[].versions[].acceptedFor: polymorphic schema; accepts an untyped value
- managementTemplateSteps[].versions[].deployments[]: nested schema exceeds depth limit; accepts an untyped value
- managementTemplateSteps[].versions[].templateStep: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
