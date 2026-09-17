# /identity/verifiedId/profiles

Create verifiedIdProfile

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/verifiedidprofile?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identity/verifiedId/profiles`, `GET/PATCH/DELETE /identity/verifiedId/profiles/{verifiedIdProfile-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity/verified-id/profiles"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `description` | `description` | `string` | no | no |
| `face_check_configuration` | `faceCheckConfiguration` | `object({       odata_type = optional(string, "#microsoft.graph.faceCheckConfiguration")       isEnabled = optional(bool)       sourcePhotoClaimName = optional(string)     })` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `mobile_drivers_license_configuration` | `mobileDriversLicenseConfiguration` | `any` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `priority` | `priority` | `number` | no | no |
| `self_service_issuance` | `selfServiceIssuance` | `any` | no | no |
| `state` | `state` | `string` | no | no |
| `verified_id_profile_configuration` | `verifiedIdProfileConfiguration` | `object({       odata_type = optional(string, "#microsoft.graph.verifiedIdProfileConfiguration")       acceptedIssuer = optional(string)       claimBindingSource = optional(string)       claimBindings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.claimBinding")       matchConfidenceLevel = optional(string)       sourceAttribute = optional(string)       verifiedIdClaim = optional(string)     })))       claimValidation = optional(object({       odata_type = optional(string, "#microsoft.graph.claimValidation")       customExtensionId = optional(string)       isEnabled = optional(bool)     }))       manifestUrl = optional(string)       methodType = optional(string)       type = optional(string)     })` | no | no |
| `verified_id_usage_configurations` | `verifiedIdUsageConfigurations` | `list(object({       odata_type = optional(string, "#microsoft.graph.verifiedIdUsageConfiguration")       isEnabledForTestOnly = optional(bool)       purpose = optional(string)     }))` | no | no |
| `verifier_did` | `verifierDid` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- mobileDriversLicenseConfiguration: polymorphic schema; accepts an untyped value
- selfServiceIssuance: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
