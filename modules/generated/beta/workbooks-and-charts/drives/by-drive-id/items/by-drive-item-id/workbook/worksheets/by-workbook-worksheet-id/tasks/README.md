# /drives/{drive-id}/items/{driveItem-id}/workbook/worksheets/{workbookWorksheet-id}/tasks

Create new navigation property to tasks for drives

[Catalog](../../../../../../../../../README.md) · [Workbooks and charts](../../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/workbookdocumenttask?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /drives/{drive-id}/items/{driveItem-id}/workbook/worksheets/{workbookWorksheet-id}/tasks`, `GET/PATCH/DELETE /drives/{drive-id}/items/{driveItem-id}/workbook/worksheets/{workbookWorksheet-id}/tasks/{workbookDocumentTask-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./workbooks-and-charts/drives/by-drive-id/items/by-drive-item-id/workbook/worksheets/by-workbook-worksheet-id/tasks"
  drive_id = "parent-object-id"
  drive_item_id = "parent-object-id"
  workbook_worksheet_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `drive_id` | URL parameter `drive-id` | `string` | yes | no |
| `drive_item_id` | URL parameter `driveItem-id` | `string` | yes | no |
| `workbook_worksheet_id` | URL parameter `workbookWorksheet-id` | `string` | yes | no |
| `assignees` | `assignees` | `list(object({       odata_type = optional(string, "#microsoft.graph.workbookEmailIdentity")       displayName = optional(string)       email = optional(string)       id = optional(string)     }))` | no | no |
| `changes` | `changes` | `list(object({       odata_type = optional(string, "#microsoft.graph.workbookDocumentTaskChange")       assignee = optional(any)       changedBy = optional(object({       odata_type = optional(string, "#microsoft.graph.workbookEmailIdentity")       displayName = optional(string)       email = optional(string)       id = optional(string)     }))       commentId = optional(string)       createdDateTime = optional(string)       dueDateTime = optional(string)       percentComplete = optional(number)       priority = optional(number)       startDateTime = optional(string)       title = optional(string)       type = optional(string)       undoChangeId = optional(string)     }))` | no | no |
| `comment` | `comment` | `any` | no | no |
| `completed_by` | `completedBy` | `any` | no | no |
| `completed_date_time` | `completedDateTime` | `string` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `percent_complete` | `percentComplete` | `number` | no | no |
| `priority` | `priority` | `number` | no | no |
| `start_and_due_date_time` | `startAndDueDateTime` | `any` | no | no |
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
- changes[].assignee: polymorphic schema; accepts an untyped value
- comment: polymorphic schema; accepts an untyped value
- completedBy: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- startAndDueDateTime: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
