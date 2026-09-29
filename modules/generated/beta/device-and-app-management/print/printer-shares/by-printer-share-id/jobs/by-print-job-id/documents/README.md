# /print/printerShares/{printerShare-id}/jobs/{printJob-id}/documents

Create new navigation property to documents for print

[Catalog](../../../../../../../README.md) · [Device and app management](../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/printdocument?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /print/printerShares/{printerShare-id}/jobs/{printJob-id}/documents`, `GET/PATCH/DELETE /print/printerShares/{printerShare-id}/jobs/{printJob-id}/documents/{printDocument-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/print/printer-shares/by-printer-share-id/jobs/by-print-job-id/documents"
  printer_share_id = "parent-object-id"
  print_job_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `printer_share_id` | URL parameter `printerShare-id` | `string` | yes | no |
| `print_job_id` | URL parameter `printJob-id` | `string` | yes | no |
| `configuration` | `configuration` | `object({       odata_type = optional(string, "#microsoft.graph.printerDocumentConfiguration")       collate = optional(bool)       colorMode = optional(string)       copies = optional(number)       dpi = optional(number)       duplexMode = optional(string)       feedDirection = optional(string)       feedOrientation = optional(string)       finishings = optional(list(string))       fitPdfToPage = optional(bool)       inputBin = optional(string)       margin = optional(object({       odata_type = optional(string, "#microsoft.graph.printMargin")       bottom = optional(number)       left = optional(number)       right = optional(number)       top = optional(number)     }))       mediaSize = optional(string)       mediaType = optional(string)       multipageLayout = optional(string)       orientation = optional(string)       outputBin = optional(string)       pageRanges = optional(list(object({       odata_type = optional(string, "#microsoft.graph.integerRange")       end = optional(number)       maximum = optional(number)       minimum = optional(number)       start = optional(number)     })))       pagesPerSheet = optional(number)       quality = optional(string)       scaling = optional(string)     })` | no | no |
| `downloaded_date_time` | `downloadedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `uploaded_date_time` | `uploadedDateTime` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
