# /admin/serviceAnnouncement/messages

Create new navigation property to messages for admin

[Catalog](../../../../README.md) · [Device and app management](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/serviceupdatemessage?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /admin/serviceAnnouncement/messages`, `GET/PATCH/DELETE /admin/serviceAnnouncement/messages/{serviceUpdateMessage-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/admin/service-announcement/messages"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `action_required_by_date_time` | `actionRequiredByDateTime` | `string` | no | no |
| `attachments` | `attachments` | `list(object({       odata_type = optional(string, "#microsoft.graph.serviceAnnouncementAttachment")       content = optional(string)       contentType = optional(string)       lastModifiedDateTime = optional(string)       name = optional(string)       size = optional(number)     }))` | no | no |
| `attachments_archive` | `attachmentsArchive` | `string` | no | no |
| `body` | `body` | `object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     })` | no | no |
| `category` | `category` | `string` | no | no |
| `details` | `details` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyValuePair")       name = optional(string)       value = optional(string)     }))` | no | no |
| `end_date_time` | `endDateTime` | `string` | no | no |
| `has_attachments` | `hasAttachments` | `bool` | no | no |
| `is_major_change` | `isMajorChange` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `services` | `services` | `list(string)` | no | no |
| `severity` | `severity` | `string` | no | no |
| `start_date_time` | `startDateTime` | `string` | no | no |
| `tags` | `tags` | `list(string)` | no | no |
| `title` | `title` | `string` | no | no |
| `view_point` | `viewPoint` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- body.contentType: polymorphic schema; accepts an untyped value
- viewPoint: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
