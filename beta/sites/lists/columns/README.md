# /sites/{site-id}/lists/{list-id}/columns

Create columnDefinition

[Catalog](../../../README.md) Â· [Sites and lists](../../../README.md#sites-and-lists) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /sites/{site-id}/lists/{list-id}/columns`, `GET/PATCH/DELETE /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/sites/lists/columns"
  version = "<version>"

  site_id = "parent-object-id"
  list_id = "parent-object-id"
}
```

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `site_id` | URL parameter `site-id` | `string` | yes | no | not replaced or moved: the update targets the existing object; recreate it to move it |
| `list_id` | URL parameter `list-id` | `string` | yes | no | not replaced or moved: the update targets the existing object; recreate it to move it |
| `boolean` | `boolean` | `any` | no | no | in place |
| `calculated` | `calculated` | `object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     })` | no | no | in place |
| `choice` | `choice` | `object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(list(string))       displayAs = optional(string)     })` | no | no | in place |
| `column_group` | `columnGroup` | `string` | no | no | in place |
| `content_approval_status` | `contentApprovalStatus` | `any` | no | no | in place |
| `currency` | `currency` | `object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     })` | no | no | in place |
| `date_time` | `dateTime` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     })` | no | no | in place |
| `default_value` | `defaultValue` | `object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     })` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `enforce_unique_values` | `enforceUniqueValues` | `bool` | no | no | in place |
| `geolocation` | `geolocation` | `any` | no | no | in place |
| `hidden` | `hidden` | `bool` | no | no | in place |
| `hyperlink_or_picture` | `hyperlinkOrPicture` | `object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     })` | no | no | in place |
| `indexed` | `indexed` | `bool` | no | no | in place |
| `is_deletable` | `isDeletable` | `bool` | no | no | in place |
| `is_sealed` | `isSealed` | `bool` | no | no | in place |
| `is_searchable` | `isSearchable` | `bool` | no | no | in place |
| `lookup` | `lookup` | `object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     })` | no | no | in place |
| `name` | `name` | `string` | no | no | in place |
| `number` | `number` | `object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     })` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `person_or_group` | `personOrGroup` | `object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     })` | no | no | in place |
| `propagate_changes` | `propagateChanges` | `bool` | no | no | in place |
| `read_only` | `readOnly` | `bool` | no | no | in place |
| `required` | `required` | `bool` | no | no | in place |
| `source_column` | `sourceColumn` | `any` | no | no | in place |
| `source_content_type` | `sourceContentType` | `object({       odata_type = optional(string, "#microsoft.graph.contentTypeInfo")       id = optional(string)       name = optional(string)     })` | no | no | in place |
| `term` | `term` | `object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     })` | no | no | in place |
| `text` | `text` | `object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     })` | no | no | in place |
| `thumbnail` | `thumbnail` | `any` | no | no | in place |
| `validation` | `validation` | `object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.displayNameLocalization")       displayName = optional(string)       languageTag = optional(string)     })))       formula = optional(string)     })` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `id`, `isReorderable`, `type`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /sites/{site-id}/lists/{list-id}/columns` | DelegatedWork | `Sites.Manage.All` | — |
| `POST /sites/{site-id}/lists/{list-id}/columns` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /sites/{site-id}/lists/{list-id}/columns` | Application | `Sites.Manage.All` | — |
| `GET /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}` | DelegatedWork | `Sites.Manage.All` | — |
| `GET /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}` | DelegatedWork | `Sites.Read.All` | — |
| `GET /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}` | Application | `Sites.Manage.All` | — |
| `GET /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}` | Application | `Sites.Read.All` | — |
| `PATCH /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}` | DelegatedWork | `Sites.Manage.All` | — |
| `PATCH /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}` | Application | `Sites.Manage.All` | — |
| `DELETE /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}` | DelegatedWork | `Sites.Manage.All` | — |
| `DELETE /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /sites/{site-id}/lists/{list-id}/columns/{columnDefinition-id}` | Application | `Sites.Manage.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
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
