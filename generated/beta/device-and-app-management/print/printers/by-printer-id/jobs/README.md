# /print/printers/{printer-id}/jobs

Create printJob for a printer

[Catalog](../../../../../README.md) · [Device and app management](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/printjob?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /print/printers/{printer-id}/jobs`, `GET/PATCH/DELETE /print/printers/{printer-id}/jobs/{printJob-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/print/printers/by-printer-id/jobs"
  printer_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `printer_id` | URL parameter `printer-id` | `string` | yes | no |
| `acknowledged_date_time` | `acknowledgedDateTime` | `string` | no | no |
| `completed_date_time` | `completedDateTime` | `string` | no | no |
| `configuration` | `configuration` | `object({       odata_type = optional(string, "#microsoft.graph.printJobConfiguration")       collate = optional(bool)       finishings = optional(any)       fitPdfToPage = optional(bool)       inputBin = optional(string)       margin = optional(any)       mediaSize = optional(string)       mediaType = optional(string)       multipageLayout = optional(any)       orientation = optional(any)       outputBin = optional(string)       pagesPerSheet = optional(number)       scaling = optional(any)     })` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `documents` | `documents` | `list(object({       odata_type = optional(string, "#microsoft.graph.printDocument")       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.printerDocumentConfiguration")       collate = optional(bool)       colorMode = optional(any)       copies = optional(number)       dpi = optional(number)       duplexMode = optional(any)       feedDirection = optional(any)       feedOrientation = optional(any)       finishings = optional(any)       fitPdfToPage = optional(bool)       inputBin = optional(string)       margin = optional(any)       mediaSize = optional(string)       mediaType = optional(string)       multipageLayout = optional(any)       orientation = optional(any)       outputBin = optional(string)       pageRanges = optional(list(object({       odata_type = optional(string, "#microsoft.graph.integerRange")       end = optional(number)       maximum = optional(number)       minimum = optional(number)       start = optional(number)     })))       pagesPerSheet = optional(number)       quality = optional(any)       scaling = optional(any)     }))       downloadedDateTime = optional(string)       uploadedDateTime = optional(string)     }))` | no | no |
| `error_code` | `errorCode` | `number` | no | no |
| `is_fetchable` | `isFetchable` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `redirected_from` | `redirectedFrom` | `string` | no | no |
| `redirected_to` | `redirectedTo` | `string` | no | no |
| `status` | `status` | `object({       odata_type = optional(string, "#microsoft.graph.printJobStatus")       acquiredByPrinter = optional(bool)       processingState = optional(any)       processingStateDescription = optional(string)       state = optional(string)     })` | no | no |
| `tasks` | `tasks` | `list(object({       odata_type = optional(string, "#microsoft.graph.printTask")       definition = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskDefinition")       createdBy = optional(object({       odata_type = optional(string, "#microsoft.graph.appIdentity")       appId = optional(string)       displayName = optional(string)       servicePrincipalId = optional(string)       servicePrincipalName = optional(string)     }))       displayName = optional(string)     }))       status = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskStatus")       description = optional(string)       state = optional(string)     }))       trigger = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskTrigger")       definition = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskDefinition")       createdBy = optional(object({       odata_type = optional(string, "#microsoft.graph.appIdentity")       appId = optional(string)       displayName = optional(string)       servicePrincipalId = optional(string)       servicePrincipalName = optional(string)     }))       displayName = optional(string)     }))       event = optional(string)     }))     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- configuration.finishings[]: polymorphic schema; accepts an untyped value
- configuration.margin: polymorphic schema; accepts an untyped value
- configuration.multipageLayout: polymorphic schema; accepts an untyped value
- configuration.orientation: polymorphic schema; accepts an untyped value
- configuration.scaling: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- documents[].configuration.colorMode: polymorphic schema; accepts an untyped value
- documents[].configuration.duplexMode: polymorphic schema; accepts an untyped value
- documents[].configuration.feedDirection: polymorphic schema; accepts an untyped value
- documents[].configuration.feedOrientation: polymorphic schema; accepts an untyped value
- documents[].configuration.finishings[]: polymorphic schema; accepts an untyped value
- documents[].configuration.margin: polymorphic schema; accepts an untyped value
- documents[].configuration.multipageLayout: polymorphic schema; accepts an untyped value
- documents[].configuration.orientation: polymorphic schema; accepts an untyped value
- documents[].configuration.quality: polymorphic schema; accepts an untyped value
- documents[].configuration.scaling: polymorphic schema; accepts an untyped value
- status.processingState: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
