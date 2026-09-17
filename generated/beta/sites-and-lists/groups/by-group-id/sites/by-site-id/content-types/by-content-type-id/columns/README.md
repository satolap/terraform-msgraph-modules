# /groups/{group-id}/sites/{site-id}/contentTypes/{contentType-id}/columns

Create new navigation property to columns for groups

[Catalog](../../../../../../../../README.md) · [Sites and lists](../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /groups/{group-id}/sites/{site-id}/contentTypes/{contentType-id}/columns`, `GET/PATCH/DELETE /groups/{group-id}/sites/{site-id}/contentTypes/{contentType-id}/columns/{columnDefinition-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./sites-and-lists/groups/by-group-id/sites/by-site-id/content-types/by-content-type-id/columns"
  group_id = "parent-object-id"
  site_id = "parent-object-id"
  content_type_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `group_id` | URL parameter `group-id` | `string` | yes | no |
| `site_id` | URL parameter `site-id` | `string` | yes | no |
| `content_type_id` | URL parameter `contentType-id` | `string` | yes | no |
| `boolean` | `boolean` | `any` | no | no |
| `calculated` | `calculated` | `any` | no | no |
| `choice` | `choice` | `any` | no | no |
| `column_group` | `columnGroup` | `string` | no | no |
| `content_approval_status` | `contentApprovalStatus` | `any` | no | no |
| `currency` | `currency` | `any` | no | no |
| `date_time` | `dateTime` | `any` | no | no |
| `default_value` | `defaultValue` | `any` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enforce_unique_values` | `enforceUniqueValues` | `bool` | no | no |
| `geolocation` | `geolocation` | `any` | no | no |
| `hidden` | `hidden` | `bool` | no | no |
| `hyperlink_or_picture` | `hyperlinkOrPicture` | `any` | no | no |
| `indexed` | `indexed` | `bool` | no | no |
| `is_deletable` | `isDeletable` | `bool` | no | no |
| `is_sealed` | `isSealed` | `bool` | no | no |
| `is_searchable` | `isSearchable` | `bool` | no | no |
| `lookup` | `lookup` | `any` | no | no |
| `name` | `name` | `string` | no | no |
| `number` | `number` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `person_or_group` | `personOrGroup` | `any` | no | no |
| `propagate_changes` | `propagateChanges` | `bool` | no | no |
| `read_only` | `readOnly` | `bool` | no | no |
| `required` | `required` | `bool` | no | no |
| `source_column` | `sourceColumn` | `any` | no | no |
| `source_content_type` | `sourceContentType` | `any` | no | no |
| `term` | `term` | `any` | no | no |
| `text` | `text` | `any` | no | no |
| `thumbnail` | `thumbnail` | `any` | no | no |
| `validation` | `validation` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- boolean: polymorphic schema; accepts an untyped value
- calculated: polymorphic schema; accepts an untyped value
- choice: polymorphic schema; accepts an untyped value
- contentApprovalStatus: polymorphic schema; accepts an untyped value
- currency: polymorphic schema; accepts an untyped value
- dateTime: polymorphic schema; accepts an untyped value
- defaultValue: polymorphic schema; accepts an untyped value
- geolocation: polymorphic schema; accepts an untyped value
- hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- lookup: polymorphic schema; accepts an untyped value
- number: polymorphic schema; accepts an untyped value
- personOrGroup: polymorphic schema; accepts an untyped value
- sourceColumn: polymorphic schema; accepts an untyped value
- sourceContentType: polymorphic schema; accepts an untyped value
- term: polymorphic schema; accepts an untyped value
- text: polymorphic schema; accepts an untyped value
- thumbnail: polymorphic schema; accepts an untyped value
- validation: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
