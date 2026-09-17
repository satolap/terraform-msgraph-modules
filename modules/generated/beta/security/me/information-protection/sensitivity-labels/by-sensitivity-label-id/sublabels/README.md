# /me/informationProtection/sensitivityLabels/{sensitivityLabel-id}/sublabels

Create new navigation property to sublabels for me

[Catalog](../../../../../../README.md) · [Security](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-sensitivitylabel?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /me/informationProtection/sensitivityLabels/{sensitivityLabel-id}/sublabels`, `GET/PATCH/DELETE /me/informationProtection/sensitivityLabels/{sensitivityLabel-id}/sublabels/{sensitivityLabel-id1}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/me/information-protection/sensitivity-labels/by-sensitivity-label-id/sublabels"
  sensitivity_label_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `sensitivity_label_id` | URL parameter `sensitivityLabel-id` | `string` | yes | no |
| `action_source` | `actionSource` | `any` | no | no |
| `applicable_to` | `applicableTo` | `any` | no | no |
| `application_mode` | `applicationMode` | `any` | no | no |
| `auto_tooltip` | `autoTooltip` | `string` | no | no |
| `color` | `color` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `has_protection` | `hasProtection` | `bool` | no | no |
| `is_default` | `isDefault` | `bool` | no | no |
| `is_enabled` | `isEnabled` | `bool` | no | no |
| `is_endpoint_protection_enabled` | `isEndpointProtectionEnabled` | `bool` | no | no |
| `is_scoped_to_user` | `isScopedToUser` | `bool` | no | no |
| `locale` | `locale` | `string` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `priority` | `priority` | `number` | no | no |
| `rights` | `rights` | `any` | no | no |
| `sublabels` | `sublabels` | `list(object({       odata_type = optional(string, "#microsoft.graph.sensitivityLabel")       actionSource = optional(any)       applicableTo = optional(any)       applicationMode = optional(any)       autoTooltip = optional(string)       color = optional(string)       description = optional(string)       displayName = optional(string)       hasProtection = optional(bool)       isDefault = optional(bool)       isEnabled = optional(bool)       isEndpointProtectionEnabled = optional(bool)       isScopedToUser = optional(bool)       locale = optional(string)       name = optional(string)       priority = optional(number)       rights = optional(any)       sublabels = optional(any)       toolTip = optional(string)     }))` | no | no |
| `tool_tip` | `toolTip` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- actionSource: polymorphic schema; accepts an untyped value
- applicableTo: polymorphic schema; accepts an untyped value
- applicationMode: polymorphic schema; accepts an untyped value
- rights: polymorphic schema; accepts an untyped value
- sublabels[].actionSource: polymorphic schema; accepts an untyped value
- sublabels[].applicableTo: polymorphic schema; accepts an untyped value
- sublabels[].applicationMode: polymorphic schema; accepts an untyped value
- sublabels[].rights: polymorphic schema; accepts an untyped value
- sublabels[].sublabels[]: recursive schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
