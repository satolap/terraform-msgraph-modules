# /users/{user-id}/dataSecurityAndGovernance/activities/contentActivities

Create new navigation property to contentActivities for users

[Catalog](../../../../../../README.md) · [Security](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/contentactivity?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/dataSecurityAndGovernance/activities/contentActivities`, `GET/PATCH/DELETE /users/{user-id}/dataSecurityAndGovernance/activities/contentActivities/{contentActivity-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/users/by-user-id/data-security-and-governance/activities/content-activities"
  user_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `content_metadata` | `contentMetadata` | `object({       odata_type = optional(string, "#microsoft.graph.processContentRequest")       activityMetadata = optional(object({       odata_type = optional(string, "#microsoft.graph.activityMetadata")       activity = optional(string)       participants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.interactionParticipant")       value = optional(string)     })))     }))       contentEntries = optional(list(object({       odata_type = optional(string, "#microsoft.graph.processContentMetadataBase")       content = optional(any)       contentCategory = optional(any)       correlationId = optional(string)       createdDateTime = optional(string)       identifier = optional(string)       isTruncated = optional(bool)       length = optional(number)       modifiedDateTime = optional(string)       name = optional(string)       sequenceNumber = optional(number)     })))       contextMetadata = optional(any)       deviceMetadata = optional(object({       odata_type = optional(string, "#microsoft.graph.deviceMetadata")       deviceType = optional(string)       ipAddress = optional(string)       operatingSystemSpecifications = optional(any)     }))       evaluationScope = optional(any)       integratedAppMetadata = optional(object({       odata_type = optional(string, "#microsoft.graph.integratedApplicationMetadata")       name = optional(string)       version = optional(string)     }))       protectedAppMetadata = optional(any)     })` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `scope_identifier` | `scopeIdentifier` | `string` | no | no |
| `user_id_2` | `userId` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- contentMetadata.contentEntries[].content: polymorphic schema; accepts an untyped value
- contentMetadata.contentEntries[].contentCategory: polymorphic schema; accepts an untyped value
- contentMetadata.contextMetadata: polymorphic schema; accepts an untyped value
- contentMetadata.deviceMetadata.operatingSystemSpecifications: polymorphic schema; accepts an untyped value
- contentMetadata.evaluationScope: polymorphic schema; accepts an untyped value
- contentMetadata.protectedAppMetadata: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
