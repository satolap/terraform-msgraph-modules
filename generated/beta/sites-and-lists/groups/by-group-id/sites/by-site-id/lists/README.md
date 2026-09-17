# /groups/{group-id}/sites/{site-id}/lists

Create new navigation property to lists for groups

[Catalog](../../../../../../README.md) · [Sites and lists](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/list?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /groups/{group-id}/sites/{site-id}/lists`, `GET/PATCH/DELETE /groups/{group-id}/sites/{site-id}/lists/{list-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./sites-and-lists/groups/by-group-id/sites/by-site-id/lists"
  group_id = "parent-object-id"
  site_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `group_id` | URL parameter `group-id` | `string` | yes | no |
| `site_id` | URL parameter `site-id` | `string` | yes | no |
| `activities` | `activities` | `list(object({       odata_type = optional(string, "#microsoft.graph.itemActivityOLD")       action = optional(any)       actor = optional(any)       driveItem = optional(any)       listItem = optional(any)       times = optional(any)     }))` | no | no |
| `columns` | `columns` | `list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     }))` | no | no |
| `content_types` | `contentTypes` | `list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(list(string))       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnLink")       name = optional(string)     })))       columnPositions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     }))` | no | no |
| `created_by_user` | `createdByUser` | `any` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `drive` | `drive` | `any` | no | no |
| `items` | `items` | `list(object({       odata_type = optional(string, "#microsoft.graph.listItem")       activities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.itemActivityOLD")       action = optional(any)       actor = optional(any)       driveItem = optional(any)       listItem = optional(any)       times = optional(any)     })))       analytics = optional(any)       contentType = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentSetVersions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.documentSetVersion")       comment = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       fields = optional(any)       items = optional(any)       shouldCaptureMinorVersion = optional(bool)     })))       driveItem = optional(any)       fields = optional(any)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)       versions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.listItemVersion")       fields = optional(any)     })))     }))` | no | no |
| `last_modified_by_user` | `lastModifiedByUser` | `any` | no | no |
| `list` | `list` | `any` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operations` | `operations` | `list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(any)       statusDetail = optional(string)       type = optional(string)     }))` | no | no |
| `parent_reference` | `parentReference` | `any` | no | no |
| `subscriptions` | `subscriptions` | `list(object({       odata_type = optional(string, "#microsoft.graph.subscription")       changeType = optional(string)       clientState = optional(string)       encryptionCertificate = optional(string)       encryptionCertificateId = optional(string)       expirationDateTime = optional(string)       includeResourceData = optional(bool)       latestSupportedTlsVersion = optional(string)       lifecycleNotificationUrl = optional(string)       notificationContentType = optional(string)       notificationQueryOptions = optional(string)       notificationUrl = optional(string)       notificationUrlAppId = optional(string)       resource = optional(string)       vapidPublicKey = optional(string)       webPushEncryptionP256dhPublicKey = optional(string)       webPushEncryptionSecret = optional(string)     }))` | no | yes |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- activities[].action: polymorphic schema; accepts an untyped value
- activities[].actor: polymorphic schema; accepts an untyped value
- activities[].driveItem: polymorphic schema; accepts an untyped value
- activities[].listItem: polymorphic schema; accepts an untyped value
- activities[].times: polymorphic schema; accepts an untyped value
- columns[].boolean: polymorphic schema; accepts an untyped value
- columns[].calculated: polymorphic schema; accepts an untyped value
- columns[].choice: polymorphic schema; accepts an untyped value
- columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- columns[].currency: polymorphic schema; accepts an untyped value
- columns[].dateTime: polymorphic schema; accepts an untyped value
- columns[].defaultValue: polymorphic schema; accepts an untyped value
- columns[].geolocation: polymorphic schema; accepts an untyped value
- columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- columns[].lookup: polymorphic schema; accepts an untyped value
- columns[].number: polymorphic schema; accepts an untyped value
- columns[].personOrGroup: polymorphic schema; accepts an untyped value
- columns[].sourceColumn: polymorphic schema; accepts an untyped value
- columns[].sourceContentType: polymorphic schema; accepts an untyped value
- columns[].term: polymorphic schema; accepts an untyped value
- columns[].text: polymorphic schema; accepts an untyped value
- columns[].thumbnail: polymorphic schema; accepts an untyped value
- columns[].validation: polymorphic schema; accepts an untyped value
- contentTypes[].base: polymorphic schema; accepts an untyped value
- contentTypes[].baseTypes[]: recursive schema; accepts an untyped value
- contentTypes[].columnPositions[].boolean: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].calculated: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].choice: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].currency: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].dateTime: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].defaultValue: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].geolocation: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].lookup: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].number: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].personOrGroup: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].sourceColumn: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].sourceContentType: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].term: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].text: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].thumbnail: polymorphic schema; accepts an untyped value
- contentTypes[].columnPositions[].validation: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].boolean: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].calculated: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].choice: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].currency: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].dateTime: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].defaultValue: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].geolocation: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].lookup: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].number: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].personOrGroup: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].sourceColumn: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].sourceContentType: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].term: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].text: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- contentTypes[].columns[].validation: polymorphic schema; accepts an untyped value
- contentTypes[].documentSet: polymorphic schema; accepts an untyped value
- contentTypes[].documentTemplate: polymorphic schema; accepts an untyped value
- contentTypes[].inheritedFrom: polymorphic schema; accepts an untyped value
- contentTypes[].order: polymorphic schema; accepts an untyped value
- createdByUser: polymorphic schema; accepts an untyped value
- drive: polymorphic schema; accepts an untyped value
- items[].activities[].action: polymorphic schema; accepts an untyped value
- items[].activities[].actor: polymorphic schema; accepts an untyped value
- items[].activities[].driveItem: polymorphic schema; accepts an untyped value
- items[].activities[].listItem: polymorphic schema; accepts an untyped value
- items[].activities[].times: polymorphic schema; accepts an untyped value
- items[].analytics: polymorphic schema; accepts an untyped value
- items[].contentType: polymorphic schema; accepts an untyped value
- items[].createdByUser: polymorphic schema; accepts an untyped value
- items[].deleted: polymorphic schema; accepts an untyped value
- items[].documentSetVersions[].createdBy: polymorphic schema; accepts an untyped value
- items[].documentSetVersions[].fields: polymorphic schema; accepts an untyped value
- items[].documentSetVersions[].items[]: nested schema exceeds depth limit; accepts an untyped value
- items[].driveItem: polymorphic schema; accepts an untyped value
- items[].fields: polymorphic schema; accepts an untyped value
- items[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- items[].parentReference: polymorphic schema; accepts an untyped value
- items[].versions[].fields: polymorphic schema; accepts an untyped value
- lastModifiedByUser: polymorphic schema; accepts an untyped value
- list: polymorphic schema; accepts an untyped value
- operations[].error: polymorphic schema; accepts an untyped value
- operations[].status: polymorphic schema; accepts an untyped value
- parentReference: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
