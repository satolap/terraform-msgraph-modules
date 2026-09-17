# /employeeExperience/learningProviders/{learningProvider-id}/learningContents

Create new navigation property to learningContents for employeeExperience

[Catalog](../../../../../README.md) · [Teamwork and communications](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/learningcontent?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /employeeExperience/learningProviders/{learningProvider-id}/learningContents`, `GET/PATCH/DELETE /employeeExperience/learningProviders/{learningProvider-id}/learningContents/{learningContent-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/employee-experience/learning-providers/by-learning-provider-id/learning-contents"
  learning_provider_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `learning_provider_id` | URL parameter `learningProvider-id` | `string` | yes | no |
| `additional_tags` | `additionalTags` | `list(string)` | no | no |
| `content_web_url` | `contentWebUrl` | `string` | no | no |
| `contributors` | `contributors` | `list(string)` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `duration` | `duration` | `string` | no | no |
| `external_id` | `externalId` | `string` | no | no |
| `format` | `format` | `string` | no | no |
| `is_active` | `isActive` | `bool` | no | no |
| `is_premium` | `isPremium` | `bool` | no | no |
| `is_searchable` | `isSearchable` | `bool` | no | no |
| `language_tag` | `languageTag` | `string` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `level` | `level` | `any` | no | no |
| `number_of_pages` | `numberOfPages` | `number` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `skill_tags` | `skillTags` | `list(string)` | no | no |
| `source_name` | `sourceName` | `string` | no | no |
| `thumbnail_web_url` | `thumbnailWebUrl` | `string` | no | no |
| `title` | `title` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- level: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
