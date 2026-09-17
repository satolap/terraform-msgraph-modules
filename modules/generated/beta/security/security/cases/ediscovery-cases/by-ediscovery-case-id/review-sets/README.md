# /security/cases/ediscoveryCases/{ediscoveryCase-id}/reviewSets

Create reviewSets

[Catalog](../../../../../../README.md) · [Security](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoveryreviewset?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/cases/ediscoveryCases/{ediscoveryCase-id}/reviewSets`, `GET/PATCH/DELETE /security/cases/ediscoveryCases/{ediscoveryCase-id}/reviewSets/{ediscoveryReviewSet-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/cases/ediscovery-cases/by-ediscovery-case-id/review-sets"
  ediscovery_case_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `ediscovery_case_id` | URL parameter `ediscoveryCase-id` | `string` | yes | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `files` | `files` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryFile")       content = optional(string)       custodian = optional(any)       dateTime = optional(string)       extension = optional(string)       extractedTextContent = optional(string)       mediaType = optional(string)       name = optional(string)       otherProperties = optional(any)       processingStatus = optional(any)       senderOrAuthors = optional(list(string))       size = optional(number)       sourceType = optional(any)       subjectTitle = optional(string)       tags = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryReviewTag")       childSelectability = optional(any)       childTags = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       parent = optional(any)     })))     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `queries` | `queries` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryReviewSetQuery")       contentQuery = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- files[].custodian: polymorphic schema; accepts an untyped value
- files[].otherProperties: polymorphic schema; accepts an untyped value
- files[].processingStatus: polymorphic schema; accepts an untyped value
- files[].sourceType: polymorphic schema; accepts an untyped value
- files[].tags[].childSelectability: polymorphic schema; accepts an untyped value
- files[].tags[].childTags[]: recursive schema; accepts an untyped value
- files[].tags[].createdBy: polymorphic schema; accepts an untyped value
- files[].tags[].parent: polymorphic schema; accepts an untyped value
- queries[].createdBy: polymorphic schema; accepts an untyped value
- queries[].lastModifiedBy: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
