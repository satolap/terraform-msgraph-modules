# /shares

Add new entity to shares

[Catalog](../../README.md) · [Files](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/shareddriveitem?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /shares`, `GET/PATCH/DELETE /shares/{sharedDriveItem-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./files/shares"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `created_by_user` | `createdByUser` | `any` | no | no |
| `description` | `description` | `string` | no | no |
| `drive_item` | `driveItem` | `any` | no | no |
| `items` | `items` | `list(object({       odata_type = optional(string, "#microsoft.graph.driveItem")       activities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.itemActivityOLD")       action = optional(any)       actor = optional(any)       driveItem = optional(any)       listItem = optional(any)       times = optional(any)     })))       analytics = optional(any)       content = optional(string)       contentStream = optional(string)       createdByUser = optional(any)       description = optional(string)       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       fileSystemInfo = optional(any)       lastModifiedByUser = optional(any)       media = optional(any)       name = optional(string)       parentReference = optional(any)       retentionLabel = optional(any)       root = optional(any)       subscriptions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.subscription")       changeType = optional(string)       clientState = optional(string)       encryptionCertificate = optional(string)       encryptionCertificateId = optional(string)       expirationDateTime = optional(string)       includeResourceData = optional(bool)       latestSupportedTlsVersion = optional(string)       lifecycleNotificationUrl = optional(string)       notificationContentType = optional(string)       notificationQueryOptions = optional(string)       notificationUrl = optional(string)       notificationUrlAppId = optional(string)       resource = optional(string)       vapidPublicKey = optional(string)       webPushEncryptionP256dhPublicKey = optional(string)       webPushEncryptionSecret = optional(string)     })))       webDavUrl = optional(string)       workbook = optional(any)     }))` | no | yes |
| `last_modified_by_user` | `lastModifiedByUser` | `any` | no | no |
| `list` | `list` | `any` | no | no |
| `list_item` | `listItem` | `any` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `owner` | `owner` | `any` | no | no |
| `parent_reference` | `parentReference` | `any` | no | no |
| `permission` | `permission` | `any` | no | no |
| `root` | `root` | `any` | no | no |
| `site` | `site` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- createdByUser: polymorphic schema; accepts an untyped value
- driveItem: polymorphic schema; accepts an untyped value
- items[].activities[].action: polymorphic schema; accepts an untyped value
- items[].activities[].actor: polymorphic schema; accepts an untyped value
- items[].activities[].driveItem: polymorphic schema; accepts an untyped value
- items[].activities[].listItem: polymorphic schema; accepts an untyped value
- items[].activities[].times: polymorphic schema; accepts an untyped value
- items[].analytics: polymorphic schema; accepts an untyped value
- items[].createdByUser: polymorphic schema; accepts an untyped value
- items[].fileSystemInfo: polymorphic schema; accepts an untyped value
- items[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- items[].media: polymorphic schema; accepts an untyped value
- items[].parentReference: polymorphic schema; accepts an untyped value
- items[].retentionLabel: polymorphic schema; accepts an untyped value
- items[].root: polymorphic schema; accepts an untyped value
- items[].workbook: polymorphic schema; accepts an untyped value
- lastModifiedByUser: polymorphic schema; accepts an untyped value
- list: polymorphic schema; accepts an untyped value
- listItem: polymorphic schema; accepts an untyped value
- owner: polymorphic schema; accepts an untyped value
- parentReference: polymorphic schema; accepts an untyped value
- permission: polymorphic schema; accepts an untyped value
- root: polymorphic schema; accepts an untyped value
- site: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
