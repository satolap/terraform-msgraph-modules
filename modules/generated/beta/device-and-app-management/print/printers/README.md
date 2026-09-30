# /print/printers

Create new navigation property to printers for print

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/printer?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /print/printers`, `GET/PATCH/DELETE /print/printers/{printer-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/device-and-app-management/print/printers?ref=<release-tag>"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `accepting_jobs` | `acceptingJobs` | `bool` | no | no |
| `capabilities` | `capabilities` | `object({       odata_type = optional(string, "#microsoft.graph.printerCapabilities")       bottomMargins = optional(list(number))       collation = optional(bool)       colorModes = optional(list(string))       contentTypes = optional(list(string))       copiesPerJob = optional(object({       odata_type = optional(string, "#microsoft.graph.integerRange")       end = optional(number)       maximum = optional(number)       minimum = optional(number)       start = optional(number)     }))       dpis = optional(list(number))       duplexModes = optional(list(string))       feedDirections = optional(list(string))       feedOrientations = optional(list(string))       finishings = optional(list(string))       inputBins = optional(list(string))       isPageRangeSupported = optional(bool)       leftMargins = optional(list(number))       mediaColors = optional(list(string))       mediaSizes = optional(list(string))       mediaTypes = optional(list(string))       multipageLayouts = optional(list(string))       orientations = optional(list(string))       outputBins = optional(list(string))       pagesPerSheet = optional(list(number))       qualities = optional(list(string))       rightMargins = optional(list(number))       scalings = optional(list(string))       supportedColorConfigurations = optional(list(string))       supportedCopiesPerJob = optional(object({       odata_type = optional(string, "#microsoft.graph.integerRange")       end = optional(number)       maximum = optional(number)       minimum = optional(number)       start = optional(number)     }))       supportedDocumentMimeTypes = optional(list(string))       supportedDuplexConfigurations = optional(list(string))       supportedFinishings = optional(list(string))       supportedMediaColors = optional(list(string))       supportedMediaSizes = optional(list(string))       supportedMediaTypes = optional(list(string))       supportedOrientations = optional(list(string))       supportedOutputBins = optional(list(string))       supportedPagesPerSheet = optional(object({       odata_type = optional(string, "#microsoft.graph.integerRange")       end = optional(number)       maximum = optional(number)       minimum = optional(number)       start = optional(number)     }))       supportedPresentationDirections = optional(list(string))       supportedPrintQualities = optional(list(string))       supportsFitPdfToPage = optional(bool)       topMargins = optional(list(number))     })` | no | no |
| `connectors` | `connectors` | `list(object({       odata_type = optional(string, "#microsoft.graph.printConnector")       appVersion = optional(string)       deviceHealth = optional(object({       odata_type = optional(string, "#microsoft.graph.deviceHealth")       lastConnectionTime = optional(string)     }))       displayName = optional(string)       fullyQualifiedDomainName = optional(string)       location = optional(object({       odata_type = optional(string, "#microsoft.graph.printerLocation")       altitudeInMeters = optional(number)       building = optional(string)       city = optional(string)       countryOrRegion = optional(string)       floor = optional(string)       floorDescription = optional(string)       floorNumber = optional(number)       latitude = optional(any)       longitude = optional(any)       organization = optional(list(string))       postalCode = optional(string)       roomDescription = optional(string)       roomName = optional(string)       roomNumber = optional(number)       site = optional(string)       stateOrProvince = optional(string)       streetAddress = optional(string)       subdivision = optional(list(string))       subunit = optional(list(string))     }))       name = optional(string)       operatingSystem = optional(string)       registeredDateTime = optional(string)     }))` | no | no |
| `defaults` | `defaults` | `object({       odata_type = optional(string, "#microsoft.graph.printerDefaults")       colorMode = optional(string)       contentType = optional(string)       copiesPerJob = optional(number)       documentMimeType = optional(string)       dpi = optional(number)       duplexConfiguration = optional(string)       duplexMode = optional(string)       finishings = optional(list(string))       fitPdfToPage = optional(bool)       inputBin = optional(string)       mediaColor = optional(string)       mediaSize = optional(string)       mediaType = optional(string)       multipageLayout = optional(string)       orientation = optional(string)       outputBin = optional(string)       pagesPerSheet = optional(number)       pdfFitToPage = optional(bool)       presentationDirection = optional(string)       printColorConfiguration = optional(string)       printQuality = optional(string)       quality = optional(string)       scaling = optional(string)     })` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `is_accepting_jobs` | `isAcceptingJobs` | `bool` | no | no |
| `jobs` | `jobs` | `list(object({       odata_type = optional(string, "#microsoft.graph.printJob")       acknowledgedDateTime = optional(string)       completedDateTime = optional(string)       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.printJobConfiguration")       collate = optional(bool)       finishings = optional(list(string))       fitPdfToPage = optional(bool)       inputBin = optional(string)       margin = optional(object({       odata_type = optional(string, "#microsoft.graph.printMargin")       bottom = optional(number)       left = optional(number)       right = optional(number)       top = optional(number)     }))       mediaSize = optional(string)       mediaType = optional(string)       multipageLayout = optional(string)       orientation = optional(string)       outputBin = optional(string)       pagesPerSheet = optional(number)       scaling = optional(string)     }))       createdBy = optional(any)       displayName = optional(string)       documents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.printDocument")       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.printerDocumentConfiguration")       collate = optional(bool)       colorMode = optional(string)       copies = optional(number)       dpi = optional(number)       duplexMode = optional(string)       feedDirection = optional(string)       feedOrientation = optional(string)       finishings = optional(any)       fitPdfToPage = optional(bool)       inputBin = optional(string)       margin = optional(any)       mediaSize = optional(string)       mediaType = optional(string)       multipageLayout = optional(string)       orientation = optional(string)       outputBin = optional(string)       pageRanges = optional(any)       pagesPerSheet = optional(number)       quality = optional(string)       scaling = optional(string)     }))       downloadedDateTime = optional(string)       uploadedDateTime = optional(string)     })))       errorCode = optional(number)       isFetchable = optional(bool)       redirectedFrom = optional(string)       redirectedTo = optional(string)       status = optional(object({       odata_type = optional(string, "#microsoft.graph.printJobStatus")       acquiredByPrinter = optional(bool)       processingState = optional(string)       processingStateDescription = optional(string)       state = optional(string)     }))       tasks = optional(list(object({       odata_type = optional(string, "#microsoft.graph.printTask")       definition = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskDefinition")       createdBy = optional(any)       displayName = optional(string)     }))       status = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskStatus")       description = optional(string)       state = optional(string)     }))       trigger = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskTrigger")       definition = optional(any)       event = optional(string)     }))     })))     }))` | no | no |
| `location` | `location` | `object({       odata_type = optional(string, "#microsoft.graph.printerLocation")       altitudeInMeters = optional(number)       building = optional(string)       city = optional(string)       countryOrRegion = optional(string)       floor = optional(string)       floorDescription = optional(string)       floorNumber = optional(number)       latitude = optional(any)       longitude = optional(any)       organization = optional(list(string))       postalCode = optional(string)       roomDescription = optional(string)       roomName = optional(string)       roomNumber = optional(number)       site = optional(string)       stateOrProvince = optional(string)       streetAddress = optional(string)       subdivision = optional(list(string))       subunit = optional(list(string))     })` | no | no |
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
- connectors[].location.latitude: polymorphic schema; accepts an untyped value
- connectors[].location.longitude: polymorphic schema; accepts an untyped value
- jobs[].createdBy: polymorphic schema; accepts an untyped value
- jobs[].documents[].configuration.finishings: nested schema exceeds depth limit; accepts an untyped value
- jobs[].documents[].configuration.margin: nested schema exceeds depth limit; accepts an untyped value
- jobs[].documents[].configuration.pageRanges: nested schema exceeds depth limit; accepts an untyped value
- jobs[].tasks[].definition.createdBy: nested schema exceeds depth limit; accepts an untyped value
- jobs[].tasks[].trigger.definition: nested schema exceeds depth limit; accepts an untyped value
- location.latitude: polymorphic schema; accepts an untyped value
- location.longitude: polymorphic schema; accepts an untyped value
- share: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
