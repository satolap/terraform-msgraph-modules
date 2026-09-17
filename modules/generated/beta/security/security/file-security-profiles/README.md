# /security/fileSecurityProfiles

Create new navigation property to fileSecurityProfiles for security

[Catalog](../../../README.md) · [Security](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/fileSecurityProfiles`, `GET/PATCH/DELETE /security/fileSecurityProfiles/{fileSecurityProfile-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/file-security-profiles"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `activity_group_names` | `activityGroupNames` | `list(string)` | no | no |
| `azure_subscription_id` | `azureSubscriptionId` | `string` | no | no |
| `azure_tenant_id` | `azureTenantId` | `string` | no | no |
| `certificate_thumbprint` | `certificateThumbprint` | `string` | no | no |
| `extensions` | `extensions` | `list(string)` | no | no |
| `file_type` | `fileType` | `string` | no | no |
| `first_seen_date_time` | `firstSeenDateTime` | `string` | no | no |
| `hashes` | `hashes` | `list(object({       odata_type = optional(string, "#microsoft.graph.fileHash")       hashType = optional(any)       hashValue = optional(string)     }))` | no | no |
| `last_seen_date_time` | `lastSeenDateTime` | `string` | no | no |
| `malware_states` | `malwareStates` | `list(object({       odata_type = optional(string, "#microsoft.graph.malwareState")       category = optional(string)       family = optional(string)       name = optional(string)       severity = optional(string)       wasRunning = optional(bool)     }))` | no | no |
| `names` | `names` | `list(string)` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `risk_score` | `riskScore` | `string` | no | no |
| `size` | `size` | `number` | no | no |
| `tags` | `tags` | `list(string)` | no | no |
| `vendor_information` | `vendorInformation` | `any` | no | no |
| `vulnerability_states` | `vulnerabilityStates` | `list(object({       odata_type = optional(string, "#microsoft.graph.vulnerabilityState")       cve = optional(string)       severity = optional(string)       wasRunning = optional(bool)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- hashes[].hashType: polymorphic schema; accepts an untyped value
- vendorInformation: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
