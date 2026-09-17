# /print/printers

Create new navigation property to printers for print

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/printer?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /print/printers`, `GET/PATCH/DELETE /print/printers/{printer-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/print/printers"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `accepting_jobs` | `acceptingJobs` | `bool` | no | no |
| `capabilities` | `capabilities` | `any` | no | no |
| `connectors` | `connectors` | `list(object({       odata_type = optional(string, "#microsoft.graph.printConnector")       appVersion = optional(string)       deviceHealth = optional(any)       displayName = optional(string)       fullyQualifiedDomainName = optional(string)       location = optional(any)       name = optional(string)       operatingSystem = optional(string)       registeredDateTime = optional(string)     }))` | no | no |
| `defaults` | `defaults` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `is_accepting_jobs` | `isAcceptingJobs` | `bool` | no | no |
| `jobs` | `jobs` | `list(object({       odata_type = optional(string, "#microsoft.graph.printJob")       acknowledgedDateTime = optional(string)       completedDateTime = optional(string)       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.printJobConfiguration")       collate = optional(bool)       finishings = optional(any)       fitPdfToPage = optional(bool)       inputBin = optional(string)       margin = optional(any)       mediaSize = optional(string)       mediaType = optional(string)       multipageLayout = optional(any)       orientation = optional(any)       outputBin = optional(string)       pagesPerSheet = optional(number)       scaling = optional(any)     }))       createdBy = optional(any)       displayName = optional(string)       documents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.printDocument")       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.printerDocumentConfiguration")       collate = optional(bool)       colorMode = optional(any)       copies = optional(number)       dpi = optional(number)       duplexMode = optional(any)       feedDirection = optional(any)       feedOrientation = optional(any)       finishings = optional(any)       fitPdfToPage = optional(bool)       inputBin = optional(string)       margin = optional(any)       mediaSize = optional(string)       mediaType = optional(string)       multipageLayout = optional(any)       orientation = optional(any)       outputBin = optional(string)       pageRanges = optional(any)       pagesPerSheet = optional(number)       quality = optional(any)       scaling = optional(any)     }))       downloadedDateTime = optional(string)       uploadedDateTime = optional(string)     })))       errorCode = optional(number)       isFetchable = optional(bool)       redirectedFrom = optional(string)       redirectedTo = optional(string)       status = optional(object({       odata_type = optional(string, "#microsoft.graph.printJobStatus")       acquiredByPrinter = optional(bool)       processingState = optional(any)       processingStateDescription = optional(string)       state = optional(string)     }))       tasks = optional(list(object({       odata_type = optional(string, "#microsoft.graph.printTask")       definition = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskDefinition")       createdBy = optional(any)       displayName = optional(string)     }))       status = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskStatus")       description = optional(string)       state = optional(string)     }))       trigger = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskTrigger")       definition = optional(any)       event = optional(string)     }))     })))     }))` | no | no |
| `location` | `location` | `any` | no | no |
| `manufacturer` | `manufacturer` | `string` | no | no |
| `model` | `model` | `string` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `share` | `share` | `any` | no | no |
| `status` | `status` | `object({       odata_type = optional(string, "#microsoft.graph.printerStatus")       processingState = optional(string)       processingStateDescription = optional(string)       processingStateReasons = optional(list(string))       state = optional(string)     })` | no | no |
| `task_triggers` | `taskTriggers` | `list(object({       odata_type = optional(string, "#microsoft.graph.printTaskTrigger")       definition = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskDefinition")       createdBy = optional(object({       odata_type = optional(string, "#microsoft.graph.appIdentity")       appId = optional(string)       displayName = optional(string)       servicePrincipalId = optional(string)       servicePrincipalName = optional(string)     }))       displayName = optional(string)     }))       event = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- capabilities: polymorphic schema; accepts an untyped value
- connectors[].deviceHealth: polymorphic schema; accepts an untyped value
- connectors[].location: polymorphic schema; accepts an untyped value
- defaults: polymorphic schema; accepts an untyped value
- jobs[].configuration.finishings[]: polymorphic schema; accepts an untyped value
- jobs[].configuration.margin: polymorphic schema; accepts an untyped value
- jobs[].configuration.multipageLayout: polymorphic schema; accepts an untyped value
- jobs[].configuration.orientation: polymorphic schema; accepts an untyped value
- jobs[].configuration.scaling: polymorphic schema; accepts an untyped value
- jobs[].createdBy: polymorphic schema; accepts an untyped value
- jobs[].documents[].configuration.colorMode: polymorphic schema; accepts an untyped value
- jobs[].documents[].configuration.duplexMode: polymorphic schema; accepts an untyped value
- jobs[].documents[].configuration.feedDirection: polymorphic schema; accepts an untyped value
- jobs[].documents[].configuration.feedOrientation: polymorphic schema; accepts an untyped value
- jobs[].documents[].configuration.finishings: nested schema exceeds depth limit; accepts an untyped value
- jobs[].documents[].configuration.margin: polymorphic schema; accepts an untyped value
- jobs[].documents[].configuration.multipageLayout: polymorphic schema; accepts an untyped value
- jobs[].documents[].configuration.orientation: polymorphic schema; accepts an untyped value
- jobs[].documents[].configuration.pageRanges: nested schema exceeds depth limit; accepts an untyped value
- jobs[].documents[].configuration.quality: polymorphic schema; accepts an untyped value
- jobs[].documents[].configuration.scaling: polymorphic schema; accepts an untyped value
- jobs[].status.processingState: polymorphic schema; accepts an untyped value
- jobs[].tasks[].definition.createdBy: nested schema exceeds depth limit; accepts an untyped value
- jobs[].tasks[].trigger.definition: nested schema exceeds depth limit; accepts an untyped value
- location: polymorphic schema; accepts an untyped value
- share: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
