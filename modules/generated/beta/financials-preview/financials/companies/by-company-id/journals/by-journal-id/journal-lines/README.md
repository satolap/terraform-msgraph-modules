# /financials/companies/{company-id}/journals/{journal-id}/journalLines

Create new navigation property to journalLines for financials

[Catalog](../../../../../../../README.md) · [Financials (preview)](../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/dynamics-journalline?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /financials/companies/{company-id}/journals/{journal-id}/journalLines`, `GET/PATCH/DELETE /financials/companies/{company-id}/journals/{journal-id}/journalLines/{journalLine-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./financials-preview/financials/companies/by-company-id/journals/by-journal-id/journal-lines"
  company_id = "parent-object-id"
  journal_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `company_id` | URL parameter `company-id` | `string` | yes | no |
| `journal_id` | URL parameter `journal-id` | `string` | yes | no |
| `account` | `account` | `any` | no | no |
| `account_id` | `accountId` | `string` | no | no |
| `account_number` | `accountNumber` | `string` | no | no |
| `amount` | `amount` | `number` | no | no |
| `comment` | `comment` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `document_number` | `documentNumber` | `string` | no | no |
| `external_document_number` | `externalDocumentNumber` | `string` | no | no |
| `id` | `id` | `string` | no | no |
| `journal_display_name` | `journalDisplayName` | `string` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `line_number` | `lineNumber` | `number` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `posting_date` | `postingDate` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- account: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
