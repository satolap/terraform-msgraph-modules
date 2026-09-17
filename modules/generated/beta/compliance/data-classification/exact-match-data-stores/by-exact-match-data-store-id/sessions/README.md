# /dataClassification/exactMatchDataStores/{exactMatchDataStore-id}/sessions

Create new navigation property to sessions for dataClassification

[Catalog](../../../../../README.md) · [Compliance](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/complianceapioverview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /dataClassification/exactMatchDataStores/{exactMatchDataStore-id}/sessions`, `GET/PATCH/DELETE /dataClassification/exactMatchDataStores/{exactMatchDataStore-id}/sessions/{exactMatchSession-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./compliance/data-classification/exact-match-data-stores/by-exact-match-data-store-id/sessions"
  exact_match_data_store_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `exact_match_data_store_id` | URL parameter `exactMatchDataStore-id` | `string` | yes | no |
| `checksum` | `checksum` | `string` | no | no |
| `completion_date_time` | `completionDateTime` | `string` | no | no |
| `creation_date_time` | `creationDateTime` | `string` | no | no |
| `data_store_id` | `dataStoreId` | `string` | no | no |
| `data_upload_uri` | `dataUploadURI` | `string` | no | no |
| `error` | `error` | `any` | no | no |
| `fields` | `fields` | `list(string)` | no | no |
| `file_name` | `fileName` | `string` | no | no |
| `last_updated_date_time` | `lastUpdatedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `processing_completion_date_time` | `processingCompletionDateTime` | `string` | no | no |
| `remaining_block_count` | `remainingBlockCount` | `number` | no | no |
| `remaining_job_count` | `remainingJobCount` | `number` | no | no |
| `rows_per_block` | `rowsPerBlock` | `number` | no | no |
| `salt` | `salt` | `string` | no | no |
| `start_date_time` | `startDateTime` | `string` | no | no |
| `state` | `state` | `string` | no | no |
| `total_block_count` | `totalBlockCount` | `number` | no | no |
| `total_job_count` | `totalJobCount` | `number` | no | no |
| `upload_agent` | `uploadAgent` | `any` | no | no |
| `upload_agent_id` | `uploadAgentId` | `string` | no | no |
| `upload_completion_date_time` | `uploadCompletionDateTime` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- error: polymorphic schema; accepts an untyped value
- uploadAgent: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
