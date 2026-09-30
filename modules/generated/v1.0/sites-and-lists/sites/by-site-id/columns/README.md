# /sites/{site-id}/columns

Create a columnDefinition in a site

[Catalog](../../../../README.md) · [Sites and lists](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /sites/{site-id}/columns`, `GET/PATCH/DELETE /sites/{site-id}/columns/{columnDefinition-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/sites-and-lists/sites/by-site-id/columns?ref=<release-tag>"
  site_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `site_id` | URL parameter `site-id` | `string` | yes | no |
| `boolean` | `boolean` | `any` | no | no |
| `calculated` | `calculated` | `object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     })` | no | no |
| `choice` | `choice` | `object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(list(string))       displayAs = optional(string)     })` | no | no |
| `column_group` | `columnGroup` | `string` | no | no |
| `content_approval_status` | `contentApprovalStatus` | `any` | no | no |
| `currency` | `currency` | `object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     })` | no | no |
| `date_time` | `dateTime` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     })` | no | no |
| `default_value` | `defaultValue` | `object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     })` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enforce_unique_values` | `enforceUniqueValues` | `bool` | no | no |
| `geolocation` | `geolocation` | `any` | no | no |
| `hidden` | `hidden` | `bool` | no | no |
| `hyperlink_or_picture` | `hyperlinkOrPicture` | `object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     })` | no | no |
| `indexed` | `indexed` | `bool` | no | no |
| `is_deletable` | `isDeletable` | `bool` | no | no |
| `is_sealed` | `isSealed` | `bool` | no | no |
| `lookup` | `lookup` | `object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     })` | no | no |
| `name` | `name` | `string` | no | no |
| `number` | `number` | `object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     })` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `person_or_group` | `personOrGroup` | `object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     })` | no | no |
| `propagate_changes` | `propagateChanges` | `bool` | no | no |
| `read_only` | `readOnly` | `bool` | no | no |
| `required` | `required` | `bool` | no | no |
| `source_column` | `sourceColumn` | `any` | no | no |
| `term` | `term` | `object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     })` | no | no |
| `text` | `text` | `object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     })` | no | no |
| `thumbnail` | `thumbnail` | `any` | no | no |
| `validation` | `validation` | `object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.displayNameLocalization")       displayName = optional(string)       languageTag = optional(string)     })))       formula = optional(string)     })` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- boolean: polymorphic schema; accepts an untyped value
- contentApprovalStatus: polymorphic schema; accepts an untyped value
- geolocation: polymorphic schema; accepts an untyped value
- number.maximum: polymorphic schema; accepts an untyped value
- number.minimum: polymorphic schema; accepts an untyped value
- sourceColumn: navigation property; accepts an untyped value
- term.parentTerm: navigation property; accepts an untyped value
- term.termSet: navigation property; accepts an untyped value
- thumbnail: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
