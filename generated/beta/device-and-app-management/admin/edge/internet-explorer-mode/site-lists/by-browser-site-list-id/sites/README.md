# /admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}/sites

Create browserSite

[Catalog](../../../../../../../README.md) · [Device and app management](../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/browsersite?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}/sites`, `GET/PATCH/DELETE /admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}/sites/{browserSite-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/admin/edge/internet-explorer-mode/site-lists/by-browser-site-list-id/sites"
  browser_site_list_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `browser_site_list_id` | URL parameter `browserSiteList-id` | `string` | yes | no |
| `allow_redirect` | `allowRedirect` | `bool` | no | no |
| `comment` | `comment` | `string` | no | no |
| `compatibility_mode` | `compatibilityMode` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `history` | `history` | `list(object({       odata_type = optional(string, "#microsoft.graph.browserSiteHistory")       allowRedirect = optional(bool)       comment = optional(string)       compatibilityMode = optional(any)       lastModifiedBy = optional(any)       mergeType = optional(any)       publishedDateTime = optional(string)       targetEnvironment = optional(any)     }))` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `merge_type` | `mergeType` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `status` | `status` | `string` | no | no |
| `target_environment` | `targetEnvironment` | `string` | no | no |
| `web_url` | `webUrl` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- history[].compatibilityMode: polymorphic schema; accepts an untyped value
- history[].lastModifiedBy: polymorphic schema; accepts an untyped value
- history[].mergeType: polymorphic schema; accepts an untyped value
- history[].targetEnvironment: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
