# /admin/edge/internetExplorerMode/siteLists

Create browserSiteList

[Catalog](../../../../../README.md) · [Device and app management](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/browsersitelist?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /admin/edge/internetExplorerMode/siteLists`, `GET/PATCH/DELETE /admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/admin/edge/internet-explorer-mode/site-lists"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `published_by` | `publishedBy` | `any` | no | no |
| `published_date_time` | `publishedDateTime` | `string` | no | no |
| `revision` | `revision` | `string` | no | no |
| `shared_cookies` | `sharedCookies` | `list(object({       odata_type = optional(string, "#microsoft.graph.browserSharedCookie")       comment = optional(string)       createdDateTime = optional(string)       deletedDateTime = optional(string)       displayName = optional(string)       history = optional(list(object({       odata_type = optional(string, "#microsoft.graph.browserSharedCookieHistory")       comment = optional(string)       displayName = optional(string)       hostOnly = optional(bool)       hostOrDomain = optional(string)       lastModifiedBy = optional(object({       odata_type = optional(string, "#microsoft.graph.identitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))       path = optional(string)       publishedDateTime = optional(string)       sourceEnvironment = optional(any)     })))       hostOnly = optional(bool)       hostOrDomain = optional(string)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       path = optional(string)       sourceEnvironment = optional(string)       status = optional(string)     }))` | no | no |
| `sites` | `sites` | `list(object({       odata_type = optional(string, "#microsoft.graph.browserSite")       allowRedirect = optional(bool)       comment = optional(string)       compatibilityMode = optional(string)       createdDateTime = optional(string)       deletedDateTime = optional(string)       history = optional(list(object({       odata_type = optional(string, "#microsoft.graph.browserSiteHistory")       allowRedirect = optional(bool)       comment = optional(string)       compatibilityMode = optional(any)       lastModifiedBy = optional(any)       mergeType = optional(any)       publishedDateTime = optional(string)       targetEnvironment = optional(any)     })))       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       mergeType = optional(string)       status = optional(string)       targetEnvironment = optional(string)       webUrl = optional(string)     }))` | no | no |
| `status` | `status` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- lastModifiedBy: polymorphic schema; accepts an untyped value
- publishedBy: polymorphic schema; accepts an untyped value
- sharedCookies[].history[].lastModifiedBy.application: polymorphic schema; accepts an untyped value
- sharedCookies[].history[].lastModifiedBy.device: polymorphic schema; accepts an untyped value
- sharedCookies[].history[].lastModifiedBy.user: polymorphic schema; accepts an untyped value
- sharedCookies[].history[].sourceEnvironment: polymorphic schema; accepts an untyped value
- sharedCookies[].lastModifiedBy: polymorphic schema; accepts an untyped value
- sites[].history[].compatibilityMode: polymorphic schema; accepts an untyped value
- sites[].history[].lastModifiedBy: polymorphic schema; accepts an untyped value
- sites[].history[].mergeType: polymorphic schema; accepts an untyped value
- sites[].history[].targetEnvironment: polymorphic schema; accepts an untyped value
- sites[].lastModifiedBy: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
