# /financials/companies/{company-id}/customers

Create new navigation property to customers for financials

[Catalog](../../../../../README.md) · [Financials (preview)](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/dynamics-customer?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /financials/companies/{company-id}/customers`, `GET/PATCH/DELETE /financials/companies/{company-id}/customers/{customer-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./financials-preview/financials/companies/by-company-id/customers"
  company_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `company_id` | URL parameter `company-id` | `string` | yes | no |
| `address` | `address` | `any` | no | no |
| `blocked` | `blocked` | `string` | no | no |
| `currency` | `currency` | `any` | no | no |
| `currency_code` | `currencyCode` | `string` | no | no |
| `currency_id` | `currencyId` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `email` | `email` | `string` | no | no |
| `id` | `id` | `string` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `number` | `number` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `payment_method` | `paymentMethod` | `any` | no | no |
| `payment_method_id` | `paymentMethodId` | `string` | no | no |
| `payment_term` | `paymentTerm` | `any` | no | no |
| `payment_terms_id` | `paymentTermsId` | `string` | no | no |
| `phone_number` | `phoneNumber` | `string` | no | no |
| `picture` | `picture` | `list(object({       odata_type = optional(string, "#microsoft.graph.picture")       content = optional(string)       contentType = optional(string)       height = optional(number)       id = optional(string)       width = optional(number)     }))` | no | no |
| `shipment_method` | `shipmentMethod` | `any` | no | no |
| `shipment_method_id` | `shipmentMethodId` | `string` | no | no |
| `tax_area_display_name` | `taxAreaDisplayName` | `string` | no | no |
| `tax_area_id` | `taxAreaId` | `string` | no | no |
| `tax_liable` | `taxLiable` | `bool` | no | no |
| `tax_registration_number` | `taxRegistrationNumber` | `string` | no | no |
| `type` | `type` | `string` | no | no |
| `website` | `website` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- address: polymorphic schema; accepts an untyped value
- currency: polymorphic schema; accepts an untyped value
- paymentMethod: polymorphic schema; accepts an untyped value
- paymentTerm: polymorphic schema; accepts an untyped value
- shipmentMethod: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
