# /admin/windows/updates/products/{product-id}/knownIssues

Create new navigation property to knownIssues for admin

[Catalog](../../../../../../../README.md) · [Device and app management](../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/windowsupdates-knownissue?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /admin/windows/updates/products/{product-id}/knownIssues`, `GET/PATCH/DELETE /admin/windows/updates/products/{product-id}/knownIssues/{knownIssue-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/admin/windows/updates/products/by-product-id/known-issues"
  product_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `product_id` | URL parameter `product-id` | `string` | yes | no |
| `description` | `description` | `string` | no | no |
| `known_issue_histories` | `knownIssueHistories` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsUpdates.knownIssueHistoryItem")       body = optional(object({       odata_type = optional(string, "#microsoft.graph.windowsUpdates.itemBody")       content = optional(string)       contentType = optional(any)     }))     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `originating_knowledge_base_article` | `originatingKnowledgeBaseArticle` | `any` | no | no |
| `resolved_date_time` | `resolvedDateTime` | `string` | no | no |
| `resolving_knowledge_base_article` | `resolvingKnowledgeBaseArticle` | `any` | no | no |
| `safeguard_hold_ids` | `safeguardHoldIds` | `list(number)` | no | no |
| `start_date_time` | `startDateTime` | `string` | no | no |
| `status` | `status` | `string` | no | no |
| `title` | `title` | `string` | no | no |
| `web_view_url` | `webViewUrl` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- knownIssueHistories[].body.contentType: polymorphic schema; accepts an untyped value
- originatingKnowledgeBaseArticle: polymorphic schema; accepts an untyped value
- resolvingKnowledgeBaseArticle: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
